package factory.tcpnet;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import factory.dao.SensorDao;
import factory.entity.DoubleValueSensorRecord;
import factory.entity.Sensor;
import factory.entity.SensorValue;
import factory.entity.SingleValueSensorRecord;
import factory.service.SensorService;

/**
 * 
 * @author 凡鑫
 * @description:优化版本
 *
 */
public class SocketThread implements Runnable {

	private Socket socket;

	private SensorDao sensorDao;

	private SimpleDateFormat dateFormat;
	private static Map<String, Integer> sensorMap;// 用作缓存,key=传感器编号,value=传感器id

	public SocketThread(Socket socket, SensorDao sensorDao) {
		this.socket = socket;
		this.sensorDao = sensorDao;
		dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		sensorMap = new HashMap<>();
	}

	@Override
	public void run() {
		try {
			while (true) {
				BufferedReader bufr = new BufferedReader(new InputStreamReader(socket.getInputStream()));
				PrintWriter pout = new PrintWriter(socket.getOutputStream(), true);
				// 读取socket信息
				String line = bufr.readLine();
				if(!("".equals(line))&&line!=null) {
					String datas[]=line.split(";");
					for(int i=0;i<datas.length;i++) {
						char headInfo = datas[i].charAt(0);
						// 如果是有效信息
						if (headInfo == 'S' || headInfo == 'A' || headInfo == 'H' || headInfo=='U'||headInfo=='L') {
							System.out.println("From client:" + datas[i]);
							// 时间戳
							String time = dateFormat.format(new Date());
							// 传感器信息是以','分隔
							String info[] = datas[i].split(",");
							// sensorMap中如果不存在这个传感器的信息，则先去数据库中查询
							if (!sensorMap.containsKey(info[0])) {
								Sensor sensor = sensorDao.querySensorIdBySerialNumber(info[0]); // 查询
								if (sensor != null) { // 如果存在
									sensorMap.put(info[0], sensor.getId()); // 加入缓存
								} else { // 如果数据库中都没有，则不处理
									System.out.println("数据库中不存在");
									continue;
								}
							}
							int sensorId = sensorMap.get(info[0]); // 取得传感器id
							// 创建信息对象，单个数据类型传感器的value2用0填充
							SensorValue sensorValue = new SensorValue(sensorId, time, Double.valueOf(info[1]), 0, headInfo);
							if (headInfo == 'H') { // gps和温湿度都是有两个数据
								sensorValue.setValue2(Double.valueOf(info[2]));
							}
							//加入到传感器对应的数据库中，通过sensorValue中的headInfo选择对应的sql语句
							sensorDao.addSensorRecord(sensorValue);
							//加入到实时数据表中
							sensorDao.updateSensorRealTimeValue(sensorValue);
							pout.println("server receive success");
						}
						else {
							System.out.println("无效信息:"+line);
							pout.println("server receive success");
						}
					}
					
				}
				else {
					System.out.println("无效信息:"+line);
					pout.println("server receive success");
				}				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
