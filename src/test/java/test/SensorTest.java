package test;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import factory.dao.SensorDao;
import factory.entity.Sensor;
import factory.entity.SensorValue;

public class SensorTest extends BaseTest {

	@Autowired
	private SensorDao sensorDao;
	@Test
	public void test1(){
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String time=format.format(new Date());
		SensorValue sensorValue=new SensorValue(2, time,148,0,'S');
		sensorDao.addSensorRecord(sensorValue);
	}

	/*@Test
	public void queryAllSensorType() {
		List<SensorType> sensorTypes = sensorDao.queryAllSensorType();
		for(SensorType type:sensorTypes){
			System.err.println(type.getType());
		}
	}
	
	@Test
	public void queryAllSensorOfCar(){
		List<Sensor> carSensors=sensorDao.queryAllSensorOfCar();
		System.out.println(carSensors.size());
	}*/
	/*@Test
	public void queryAllSensorOfSite(){
		List<Sensor> siteSensors=sensorDao.queryAllSensorOfSite();
		System.out.println(siteSensors.get(0).getCar());
	}*/
	
	/*@Test
	public void querySensorOfCarOrSiteBySerialNumber(){
		Sensor sensor=sensorDao.querySensorOfCarOrSiteBySerialNumber("12", "site");
		System.out.println(sensor.getSerialNumber());
		
	}*/
	
	/*@Test
	public void addSensor(){
		Sensor sensor=new Sensor();
		sensor.setSiteId(1);
		sensor.setCarId(-1);
		sensor.setTypeId(1);
		sensor.setSerialNumber("ggo");
		sensorDao.addSensor(sensor);
	}*/
	/*@Test
	public void querySensorOfCarOrSiteBySerialNumber(){
		Sensor sensor=new Sensor();
		sensor.setCarId(1);
		sensor.setSiteId(-1);
		sensor.setTypeId(1);
		sensor.setStatus(0);
		List<Sensor> sensors=sensorDao.querySensorOfCarOrSite(sensor);
		System.out.println(sensors.get(0).getSerialNumber());
	}*/
	/*@Test	
	public void querySensorByCarsOrSites(){
		Sensor sensor=new Sensor();
		sensor.setTypeId(-1);
		sensor.setStatus(-1);
		sensor.setPlaceSelect("site");
		List<Sensor> sensors=sensorDao.querySensorByCarsOrSites(sensor);
		for(Sensor sensor2:sensors){
			System.out.println(sensor2.getSerialNumber());
		}
	}*/
	
	/*@Test
	public void querySensorOfCarByTypeOrStatus(){
		Sensor sensor=new Sensor();
		sensor.setTypeId(-1);
		sensor.setStatus(-1);
		List<Sensor> carSensors=sensorDao.querySensorOfCarByTypeOrStatus(sensor);
		List<Sensor> siteSensors=sensorDao.querySensorOfSiteByTypeOrStatus(sensor);
		for(Sensor sensor2:carSensors){
			System.out.println(sensor2.getSerialNumber());
		}
		for(Sensor sensor2:siteSensors){
			System.out.println(sensor2.getSerialNumber());
		}
		
	}*/
	
	@Test
	public void test(){
		String haha="(1,2)";
		List<Sensor> sensors=sensorDao.querySensorBySensorIdSet(haha);
		System.out.println(sensors.size());
	}
	
	@Test
	public void test3() {
		List<Float> list=sensorDao.queryHistoryDataOfSingleValueBySensorId(20, 'A');
		for(Float float1:list) {
			System.out.println(float1);
		}
	}

}
