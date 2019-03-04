package factory.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.ServletConfig;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Component;
import org.springframework.web.context.ServletConfigAware;

import factory.dao.CarDao;
import factory.entity.Car;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
//@Component
public class GetCarlocation implements InitializingBean,ServletConfigAware{
	private static String mds = "";
	private static String loginUrl = "http://api.18gps.net/GetDateServices.asmx/loginSystem?LoginName=teamluo123456&LoginPassword=123456&LoginType=ENTERPRISE&language=cn&ISMD5=0&timeZone=+08&apply=WEB";
	private static String getDataUrl="http://api.18gps.net/GetDateServices.asmx/GetDate?method=loadUser";
	@Autowired
	private CarDao carDao;
	
	@Autowired
	private ThreadPoolTaskExecutor taskExecuter;
	
	@Override
	public void setServletConfig(ServletConfig arg0) {
		taskExecuter.submit(new UpdateCarLocationThread());
	}
	
	class UpdateCarLocationThread implements Runnable{

		@Override
		public void run() {
			System.out.println(carDao);
			setMDS();
			while(true) {
				List<Car> carList=carDao.queryCarDeviceIdInCloud();
				for(Car car:carList) {
					try {
						JSONObject gpsInfo=getData(getDataUrl, car.getCloudDeviceId());
						//System.out.println(gpsInfo);
						if("true".equals(gpsInfo.getString("success")) && gpsInfo.getInt("errorCode")==200) {
							JSONObject locaion=(JSONObject) ((JSONArray) gpsInfo.get("data")).get(0);
							double longidude=locaion.getDouble("jingdu");
							double latitude=locaion.getDouble("weidu");
							//System.out.println(car.getId()+" "+locaion.get("jingdu")+" "+locaion.get("weidu"));
							carDao.updateCarLocation(car.getId(), longidude,latitude);
						}
					} catch (IOException e) {
						System.out.println("更新GPS");
						e.printStackTrace();
					}
				}
				try {
					Thread.sleep(3000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		}
		
	}

	
	public void setMDS() {
		try {
			mds=(String) getData(loginUrl, null).get("mds");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public JSONObject getData(String urlOrigin, String deviceId) throws IOException {

		HttpURLConnection conn = null;
		BufferedReader reader = null;
		JSONObject jsonObject = null;
		try {
			// 拼接参数，转义参数
			if (mds != "") {
				urlOrigin = urlOrigin + "&user_id=" + URLEncoder.encode(deviceId, "UTF-8") + "&mds=" + mds;
			}

			// 创建连接
			URL url = new URL(urlOrigin);
			conn = (HttpURLConnection) url.openConnection();
			conn.setUseCaches(false);
			conn.setConnectTimeout(30000);
			conn.setReadTimeout(30000);
			conn.setInstanceFollowRedirects(false);
			conn.connect();

			// 获取并解析数据
			InputStream is = conn.getInputStream();
			reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
			StringBuffer sb = new StringBuffer();
			String strRead = null;
			while ((strRead = reader.readLine()) != null) {
				sb.append(strRead);
			}
			jsonObject = JSONObject.fromObject(sb.toString());
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (reader != null) {
				reader.close();
			}
			if (conn != null) {
				conn.disconnect();
			}
		}
		return jsonObject;
	}


	@Override
	public void afterPropertiesSet() throws Exception {
	}

}
