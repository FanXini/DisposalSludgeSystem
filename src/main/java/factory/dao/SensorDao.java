package factory.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import factory.entity.DoubleValueSensorRecord;
import factory.entity.Sensor;
import factory.entity.SensorType;
import factory.entity.SensorValue;
import factory.entity.SingleValueSensorRecord;

public interface SensorDao {
	
	public List<SensorType> queryAllSensorType();
	
	public List<Sensor> queryAllSensorOfCar();
	
	public List<Sensor> queryAllSensorOfSite();
	
	public void addSensor(Sensor sensor);
	
	public void addSensorValue(@Param("sensorId") int sensorId);
	
	public SensorType querySensorTypeByType(@Param("type") String type);
	
	public void delectSensor(@Param("sensorId") int sensorId);
	
	public Sensor querySensorTypeById(@Param("id") int id);
	
	public Sensor querySensorBySerialNumber(@Param("serialNumber") String serialNumber);
	
	public Sensor querySensorIdBySerialNumber(@Param("serialNumber") String serialNumber);
	
	public Sensor querySensorOfCarBySerialNumber(@Param("serialNumber") String serialNumber);
	
	public Sensor querySensorOfSiteBySerialNumber(@Param("serialNumber") String serialNumber);
	
	public List<Sensor>  querySensorOfCarOrSite(Sensor sensor);
	
	public List<Sensor> querySensorByCarsOrSites(Sensor sensor);
	
	public List<Sensor> querySensorOfCarByTypeOrStatus(Sensor sensor);
	
	public List<Sensor> querySensorOfSiteByTypeOrStatus(Sensor sensor);
	
	public void setSiteIdNull(@Param("sensorId") int sensorId);
	
	public Sensor querySensorById(@Param("sensorId") int sensorId);
	
	public List<Sensor> querySensorBySensorIdSet(@Param("sensorIdSet") String sensorIdSet);
	
	public List<Float> queryHistoryDataOfUltrasonicBySensorId(@Param("sensorId") int sensorId);
	
	public List<Float> queryHistoryDataOfSingleValueBySensorId(@Param("sensorId") int sensorId,@Param("headInfo") char headInfo);
	
	public Float queryRealTimeValueBySensorId(@Param("sensorId") int sensorId);
	
	//存氨气数据
	public void addAmmniaGasRecord(SingleValueSensorRecord record);
	//存硫化氢数据
	public void addShydrothionRecord(SingleValueSensorRecord record);
	//存温湿度数据	
	public void addHumitureRecord(DoubleValueSensorRecord record);
	
	//存gps数据
	public void addGPSRecord(DoubleValueSensorRecord record);
	
	public void addSensorRecord(SensorValue sensorValue);
	//修改实时数据
	public void updateSensorRealTimeValue(SensorValue sensorValue);
	
	public List<Sensor> querySensorsByDriverId(@Param("driverId") int driverId);
	
	public List<Sensor> querySensorsByCarId(@Param("carId") int carId);
	
	

}
