package factory.tcpnet;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Date;
import java.util.List;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

public class Server
{
	public static void main(String[] args) throws IOException 
	{
		//构造ServerSocket实例，指定端口监听客户端的连接请求
		@SuppressWarnings("resource")
		ServerSocket ss = new ServerSocket(8088);
		//建立跟客户端的连接 
		Socket s = ss.accept();
		String ip=s.getInetAddress().getHostAddress();
		System.out.println(ip+"..connected.");
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
	    Map<String, Float> valuedemo = null;
	    //用键值对保存每个超声波传感器的上一次数据
	    valuedemo = new HashMap<String, Float>();
	    
	    Map<String,Integer> num = null;
	    num = new HashMap<String,Integer>();
	    int m = 0;
		while(true)
		{
			try 
			{
				//读入从Client发送的Socket流中信息
				BufferedReader bufr = 
						new BufferedReader(new InputStreamReader(s.getInputStream()));
				System.out.println("receive...from.."+bufr.toString());
				//读取键盘录入信息
//				BufferedReader bufIn =
//						new BufferedReader(new InputStreamReader(System.in));
				
				//输出流，输入到Socket中，发送给Client
				PrintWriter pout = 
						new PrintWriter(s.getOutputStream(),true);
				
				String line = bufr.readLine();
				System.out.println("From client:"+line);
				String curDate = df.format(new Date());
			    System.out.println("The current system time is: "+curDate);// new Date()为获取当前系统时间
				
//			    DataInputStream dis = new DataInputStream(s.getInputStream());
//			    DataOutputStream dos = new DataOutputStream(s.getOutputStream());
			    
//			    String clientMsg = dis.readUTF();
//			    System.out.println("客户端的消息是："+clientMsg);
			    
			    
				String paraArray[] = null;
				String serial_number="";
				int sensor_id= 0;
				String time="";
				float longitude=0;
				float latitude=0;
				float value=0;
				int record_id=0;
				int place=0;
				String snType="";
				
				if(line!=null && !line.startsWith("xV") && line.contains(";") && line.contains(","))
				{
					line = line.substring(0,line.length()-1);
					System.out.println("receive data is :"+line);
					paraArray = line.split(",");
					// Ultrasonic sensor
					if(paraArray[0].startsWith("U") && paraArray.length==2)
					{
						serial_number = paraArray[0];
						snType = "超声波传感器";
						value = Float.parseFloat(paraArray[1]);//表示污泥液面高度
						time = df.format(new Date());
						int site_id = SqlOperator01.searchSiteid(serial_number);
						int Sitestatus = SqlOperator01.searchSiteStatus(site_id);
						//status代表污泥厂状态，0表示不需处理，1表示处理中，2表示需要处理
						sensor_id = SqlOperator01.searchSensor_id(serial_number);
						SqlOperator01.updateSiteSis(site_id,sensor_id);
						int insert = SqlOperator01.insertUltrasonicrecord(sensor_id,time,value);
						//插入site_record
						if(insert >0)
						{
							System.out.println("insert site_record successful...");
						}
						else
						{
							System.out.println("insert site_record failed...");
						}
						SqlOperator01.updateSVR(sensor_id,String.valueOf(value));
						if(Sitestatus == 0) //通过site表中的status判断当前表中记录的状态
						{
							if(value <= 300){//设置阈值，小于阈值，表示污泥满了，需要处理，然后更新site表中的status为2
								int update = SqlOperator01.updateSiteStatus(site_id,2);
								if(update >0)
								{
									System.out.println("update site status successful...");
								}
								else
								{
									System.out.println("update site status failed...");
								}
									int i = SqlOperator01.insertRecord(time, site_id, 2);
									if(i>0){
										System.out.println("insert record successful...");
									}else{
										System.out.println("insert record failed...");
									}

							}
						}
						else if(Sitestatus == 1)
						{
							/**
							 * valuedemo是一个hashmap集合
							 * key为serial_number（传感器唯一标识号），value为本传感器上次传输的值
							 * */
							if(valuedemo.containsKey(serial_number)){
								if(value <= valuedemo.get(serial_number)){
									/**
									 * num是一个hashmap集合
									 * key为serial_number（传感器唯一标识号），value为本传感器记录次数
									 * */
									if(num.containsKey(serial_number)){
										num.put(serial_number,num.get(serial_number)+1);
									}else{
										
										num.put(serial_number, 0);
									}
									if(num.get(serial_number) == 3){
										//对比上次数据，如果页面高度连续3次没有变化或者变高，就认为污泥处理完成，并把status更新为0
										record_id = SqlOperator01.updateFinish_time(site_id,time,0);
										int update = SqlOperator01.updateSiteStatus(site_id, 0);
										int insertsludge = SqlOperator01.insertSludge(time, record_id);
										if(insertsludge >0){
											System.out.println("insert sludge successful...");
										}else{
											System.out.println("insert sludge failed...");
										}
										int car_id = SqlOperator01.searchCarid(record_id);
										SqlOperator01.updateCarstatus(car_id, 4);
										if(update >0)
										{
											System.out.println("update site status successful...");
										}
										else
										{
											System.out.println("update site status failed...");
										}
										num.put(serial_number, 0);
									}
								}
							}
						}
						else if(Sitestatus == 2){
							if(valuedemo.containsKey(serial_number)){
								if(value > valuedemo.get(serial_number)){
									//对比上次数据，如果液面高度下降的话，就认为污泥处理中，并把status更新为1
									int i = SqlOperator01.updateDisposal_time(site_id,time,1);
									int update = SqlOperator01.updateSiteStatus(site_id, 1);
									if(update >0)
									{
										System.out.println("update site status successful...");
									}
									else
									{
										System.out.println("update site status failed...");
									}
								}
							}
						}
						valuedemo.put(serial_number, value);
						
					}
					else if(paraArray[0].startsWith("G"))
					{
						serial_number = paraArray[0];
						snType= "GPS传感器";
						longitude = Float.parseFloat(paraArray[1]);
						latitude = Float.parseFloat(paraArray[2]);
						time = df.format(new Date());
						int car_id = SqlOperator01.searchCarid(serial_number);
						int Carstatus = SqlOperator01.searchCarStatus(car_id);
						sensor_id = SqlOperator01.searchSensor_id(serial_number);
						if(Carstatus==1||Carstatus==4){
							record_id = SqlOperator01.searchRecordid(car_id);
							int insert = SqlOperator01.insertGpsrecord(sensor_id, time, longitude, latitude,record_id);
							if(insert >0)
							{
								System.out.println("insert car_record successful...");
							}
							else
							{
								System.out.println("insert car_record failed...");
							}
							SqlOperator01.updateSVR(sensor_id, String.valueOf(longitude)+","+String.valueOf(latitude));
							int update = SqlOperator01.updateCarGps(car_id, longitude, latitude);
							if(update >0){
								System.out.println("update CarGps successful...");
							}else{
								System.out.println("update CarGps successful...");
							}
						}
					}
					//Light sensor--not ready
					//else if(paraArray[0].startsWith("L"))
 
					//Angel sensor
			
					pout.println("server receive success");
					
				
				}
				else
				{
					System.out.println("Please check the data format!");
					pout.println("receive data format wrong");
				}
				
				if(line.equals("bye")||line.equals(null))
				{
					break;
				}
//				pout.println(bufIn.readLine());//输出键盘录入到Socket输入流中，发送给Client
				
			} 
			catch (IOException e) 
			{
				throw new RuntimeException(ip+" Connection failed");
			}
		}
		//ss.close();
		//s.close();
	}
}
