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
 * @description:后续做代码优化
 *
 */
public class SocketThreadOld implements Runnable {

	private Socket socket;

	private SensorDao sensorDao;

	private SimpleDateFormat dateFormat;
	private static Map<String, Integer> sensorMap;//用作缓存,key=传感器编号,value=传感器id

	public SocketThreadOld(Socket socket, SensorDao sensorDao) {
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
				// System.out.println("Thread: "+Thread.currentThread()+" "+"receive...from.re"
				// + bufr.toString());
				// 读取键盘录入信息
				// BufferedReader bufIn =
				// new BufferedReader(new InputStreamReader(System.in));

				// 输出流，输入到Socket中，发送给Client
				PrintWriter pout = new PrintWriter(socket.getOutputStream(), true);
				// 读取socket信息
				String line = bufr.readLine();
				//时间戳
				String time = dateFormat.format(new Date());
				//传感器信息是以,分隔
				String info[] = line.split(",");
				// 如果是GPS传感器传来的信息
				if (info[0].startsWith("G")) {  
					if (sensorMap.containsKey(info[0])) {  //如果map中缓存了传感器的信息
						sensorDao.addGPSRecord((new DoubleValueSensorRecord(sensorMap.get(info[0]), time,
								Double.valueOf(info[1]), Double.valueOf(info[2]))));
					} else {  //如果map没有缓存传感器的信息，则需要去数据库中先查询出传感器信息
						Sensor GPSSensor = sensorDao.querySensorBySerialNumber(info[0]);
						if (GPSSensor != null) { // 如果存在这个传感器
							sensorMap.put(info[0], GPSSensor.getId());
							sensorDao.addGPSRecord((new DoubleValueSensorRecord(GPSSensor.getId(), time,
									Double.valueOf(info[1]), Double.valueOf(info[2]))));
						}
					}
					//修改传感器的实时数据表 sensor_value_realtime
					sensorDao.updateSensorRealTimeValue(new SensorValue(sensorMap.get(info[0]),Double.valueOf(info[1]),Double.valueOf(info[2])));
				}
				// 如果是氨气传感器
				else if (info[0].startsWith("A")) {
					if (sensorMap.containsKey(info[0])) {
						sensorDao.addAmmniaGasRecord(
								new SingleValueSensorRecord(sensorMap.get(info[0]), time, Double.valueOf(info[1])));
					} else {
						Sensor ammoniaGasSensor = sensorDao.querySensorBySerialNumber(info[0]);
						if (ammoniaGasSensor != null) { // 如果存在这个传感器
							sensorMap.put(info[0], ammoniaGasSensor.getId());
							sensorDao.addAmmniaGasRecord(new SingleValueSensorRecord(ammoniaGasSensor.getId(), time,
									Double.valueOf(info[1])));
						}
						sensorDao.updateSensorRealTimeValue(new SensorValue(sensorMap.get(info[0]),Double.valueOf(info[1]),0));
					}
				} else if (info[0].startsWith("S")) {  //S开头表示硫化氢传感器
					if (sensorMap.containsKey(info[0])) {
						sensorDao.addShydrothionRecord(
								new SingleValueSensorRecord(sensorMap.get(info[0]), time, Double.valueOf(info[1])));
					} else {
						Sensor shydrothionSensor = sensorDao.querySensorBySerialNumber(info[0]);
						if (shydrothionSensor != null) { // 如果存在这个传感器
							sensorMap.put(info[0], shydrothionSensor.getId());
							sensorDao.addShydrothionRecord(new SingleValueSensorRecord(shydrothionSensor.getId(), time,
									Double.valueOf(info[1])));
						}
						sensorDao.updateSensorRealTimeValue(new SensorValue(sensorMap.get(info[0]),Double.valueOf(info[1]),0));
					}
				} else if (info[0].startsWith("H")) { //H开头表示温湿度传感器
					if (sensorMap.containsKey(info[0])) {
						sensorDao.addHumitureRecord((new DoubleValueSensorRecord(sensorMap.get(info[0]), time,
								Double.valueOf(info[1]), Double.valueOf(info[2]))));
					} else {
						Sensor humitureSensor = sensorDao.querySensorBySerialNumber(info[0]);
						if (humitureSensor != null) { // 如果存在这个传感器
							sensorMap.put(info[0],humitureSensor.getId());
							sensorDao.addHumitureRecord((new DoubleValueSensorRecord(humitureSensor.getId(), time,
									Double.valueOf(info[1]), Double.valueOf(info[2]))));
						}
					}
					sensorDao.updateSensorRealTimeValue(new SensorValue(sensorMap.get(info[0]),Double.valueOf(info[1]),Double.valueOf(info[2])));
				}
				System.out.println("From client:" + line);
				pout.println("server receive success");
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

	}


}
