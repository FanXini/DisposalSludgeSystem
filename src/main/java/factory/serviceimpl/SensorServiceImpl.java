package factory.serviceimpl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import factory.dao.CarDao;
import factory.dao.SensorDao;
import factory.dao.SiteDao;
import factory.entity.Car;

import factory.entity.Sensor;
import factory.entity.SensorType;
import factory.entity.Site;
import factory.exception.DataNoneException;
import factory.service.SensorService;
import factory.util.Util;

@Service
public class SensorServiceImpl implements SensorService {

	@Autowired
	private SensorDao sensorDao;

	@Autowired
	private CarDao carDao;

	@Autowired
	private SiteDao siteDao;

	private Log log = LogFactory.getLog(SensorServiceImpl.class);

	/**
	 * 查询所有的传感器类型
	 */
	@Override
	public List<SensorType> queryAllSensorType() {
		// TODO Auto-generated method stub
		List<SensorType> sensorTypes=new ArrayList<SensorType>();
		sensorTypes.addAll(sensorDao.queryAllSensorType());
		return sensorTypes;
	}

	/**
	 * 查询放置在车上的传感器
	 */
	@Override
	public List<Sensor> queryAllSensor() {
		// TODO Auto-generated method stub
		List<Sensor> sensors = new ArrayList<Sensor>();
		List<Sensor> carSensors = sensorDao.queryAllSensorOfCar();
		List<Sensor> siteSensors = sensorDao.queryAllSensorOfSite();
		sensors.addAll(carSensors);
		sensors.addAll(siteSensors);
		return sensors;
	}

	/**
	 * 添加传感器
	 */
	@Override
	public int addSensor(Map<String, String> sensorInfo) {
		// TODO Auto-generated method stub
		// place是车牌号或者工厂名
		String sensorSerialNumber = sensorInfo.get("sensorSerialNumber");
		String sensorType = sensorInfo.get("sensorType");
		String place = sensorInfo.get("place");
		String placeSelect = sensorInfo.get("placeSelect");
		if (sensorSerialNumber == null || sensorSerialNumber.equals("") || sensorType == null || sensorType.equals("")
				|| place == null || place.equals("") || placeSelect == null || placeSelect.equals("")) {
			throw new DataNoneException("form data is empty！");
		}
		Sensor sensor = new Sensor();
		sensor.setSerialNumber(sensorSerialNumber);
		sensor.setTypeId(querySensorTypeByType(sensorType).getId());
		// 如果是车上的传感器
		if (placeSelect.equals("slugeCar")) {
			Car car = carDao.queryCarByLicense(place);
			sensor.setCarId(car.getId());
			sensor.setSiteId(-1);
			sensorDao.addSensor(sensor);
			String newSensorIdSet = Util.addsensorIdtoSensorSet(car.getSensorIdSet(), sensor.getId());
			carDao.updateSenserIdSet(car.getId(), newSensorIdSet);
		}
		// 如果是工厂上的传感器
		else {
			log.info(place);
			Site site = siteDao.querySiteBySiteName(place);
			sensor.setSiteId(site.getId());
			sensor.setCarId(-1);
			sensorDao.addSensor(sensor);
			String newSensorIdSet = Util.addsensorIdtoSensorSet(site.getSensorIdSet(), sensor.getId());
			siteDao.updateSetIdSet(site.getId(), newSensorIdSet);
		}
		// 获取到sensor的id
		sensorDao.addSensorValue(sensor.getId());
		return sensor.getId();

	}

	/**
	 * 通过传感器类型查询传感器信息
	 */
	@Override
	public SensorType querySensorTypeByType(String type) {
		// TODO Auto-generated method stub
		return sensorDao.querySensorTypeByType(type);
	}

	@Override
	public void deleteSensor(Map<String, Integer> deleteSensorInfo) {
		int sensorId = deleteSensorInfo.get("sensorId");
		Sensor sensor = sensorDao.querySensorById(sensorId);
		sensorDao.delectSensor(sensorId);
		if (sensor.getCarId() != -1 && sensor.getSiteId() == -1) { // 在车上
			Car car = carDao.queryCarById(sensor.getCarId());
			String newSensorIdSet = Util.deleteSensorIdOfSensorIdSet(car.getSensorIdSet(), sensor.getId());
			carDao.updateSenserIdSet(car.getId(), newSensorIdSet);
		} else if (sensor.getCarId() == -1 && sensor.getSiteId() != -1) {
			Site site = siteDao.querySiteById(sensor.getSiteId());
			String newSensorSetId = Util.deleteSensorIdOfSensorIdSet(site.getSensorIdSet(), sensor.getId());
			siteDao.updateSetIdSet(site.getId(), newSensorSetId);
		}
		// 删除
	}

	/**
	 * 按照条件查询传感器
	 */
	@Override
	public List<Sensor> conditionQuery(Map<String, String> condition) {
		Sensor sensor = new Sensor();
		List<Sensor> sensors = new ArrayList<Sensor>();
		String serialNumber = condition.get("sensorSerialNumber");
		String placeSelect = condition.get("placeSelect");
		int typeId = Integer.parseInt(condition.get("sensorTypeId"));
		String place = condition.get("place");
		int status = Integer.parseInt(condition.get("status"));
		log.info(serialNumber + " " + typeId + " " + place + " " + status);
		if (!serialNumber.equals("none")) { // 优先查询编号
			Sensor querySensor = sensorDao.querySensorBySerialNumber(serialNumber);
			if (querySensor != null) {
				if (querySensor.getCarId() == -1) { // 说明在Site上
					querySensor = sensorDao.querySensorOfSiteBySerialNumber(serialNumber);
				} else if (querySensor.getSiteId() == -1) {
					querySensor = sensorDao.querySensorOfCarBySerialNumber(serialNumber);
				}
				sensors.add(querySensor);
			}

		} else {
			sensor.setTypeId(typeId);
			sensor.setStatus(status);
			if (!place.equals("none")) { // 说明选了位置
				if (placeSelect.equals("site")) {
					int siteId = siteDao.querySiteBySiteName(place).getId();
					sensor.setSiteId(siteId);
					sensor.setCarId(-1);
				} else {
					int carId = carDao.queryCarByLicense(place).getId();
					sensor.setCarId(carId);
					sensor.setSiteId(-1);
				}
				sensors.addAll(sensorDao.querySensorOfCarOrSite(sensor));

			} else if (!placeSelect.equals("none")) {// 说明只选了工厂/污泥池，没有具体到细节
				sensor.setPlaceSelect(placeSelect);
				sensors = sensorDao.querySensorByCarsOrSites(sensor);
			} else { // 说明只选了 类型和状态
				List<Sensor> carSensors = sensorDao.querySensorOfCarByTypeOrStatus(sensor);
				List<Sensor> siteSensors = sensorDao.querySensorOfSiteByTypeOrStatus(sensor);
				sensors.addAll(carSensors);
				sensors.addAll(siteSensors);
			}
		}
		return sensors;
	}

	/**
	 * 按照idSet查询传感器
	 */
	@Override
	public List<Sensor> querySensorTypeByIdSet(String idSet) {
		String[] id = idSet.split(",");
		List<Sensor> sensors = new ArrayList<Sensor>();
		for (int i = 0; i < id.length; i++) {
			sensors.add(sensorDao.querySensorTypeById(Integer.valueOf(id[i])));
		}
		return sensors;
	}

	@Override
	public void setSiteIdSetNull(String idSet) {
		// TODO Auto-generated method stub
		String[] id = idSet.split(",");
		for (int i = 0; i < id.length; i++) {
			sensorDao.setSiteIdNull(Integer.valueOf(id[i]));
		}

	}

	@Override
	public List<Sensor> querySensorDetail(int id, int locationId) {
		List<Sensor> sensors = new ArrayList<Sensor>();
		if (locationId == 0) { //如果是0,则查询的是车上的传感器
			// 查询到传感器集合
			String sensorIdSet = carDao.querySensorIdSetByCarId(id);
			if (sensorIdSet == null||sensorIdSet=="") {
				return sensors;
			}
			sensorIdSet = "(" + sensorIdSet + ")";
			log.info(sensorIdSet);
			sensors.addAll(sensorDao.querySensorBySensorIdSet(sensorIdSet));

		} else if (locationId == 1) { //如果是1则查询的是工厂中的传感器
			String sensorIdSet = siteDao.querySensorIdSetBySiteId(id);
			log.info(sensorIdSet);
			if (sensorIdSet == null||sensorIdSet=="") {
				return sensors;
			}
			sensorIdSet = "(" + sensorIdSet + ")";
			sensors.addAll(sensorDao.querySensorBySensorIdSet(sensorIdSet));
		}
		return sensors;
	}

	@Override
	public List<Float> queryHistoryDataOfUltrasonicBySensorId(Map<String, Object> map) {
		int sensorId=(int) map.get("sensorId");
		List<Float> historyDatas=new ArrayList<Float>();
		String sensorType=(String) map.get("sensorType");
		if(sensorType.equals("超声波传感器")){
			historyDatas.addAll(sensorDao.queryHistoryDataOfUltrasonicBySensorId(sensorId));
		}
		return historyDatas;		
	}
	
	@Override
	public List<Float> queryHistoryDataOfSingleValueBySensorId(Map<String, Object> map) {
		int sensorId=(int) map.get("sensorId");
		List<Float> historyDatas=new ArrayList<Float>();
		char headInfo = 0;
		String sensorType=(String) map.get("sensorType");
		if(sensorType.equals("氨气传感器")){
			headInfo='A';
		}else if(sensorType.equals("硫化氢传感器")) {
			headInfo='S';
		}
		historyDatas.addAll(sensorDao.queryHistoryDataOfSingleValueBySensorId(sensorId, headInfo));
		return historyDatas;		
	}

	@Override
	public Float queryRealTimeValueBySensorId(int sensorId) {
		// TODO Auto-generated method stub
		return sensorDao.queryRealTimeValueBySensorId(sensorId);
	}
	
	@Override
	public List<Sensor> querySensorsByDriverId(int driverId) {
		//List<Sensor>  sensors=new ArrayList<Sensor>();
		//sensors.addAll(sensorDao.querySensorsByDriverId(driverId));
		return sensorDao.querySensorsByDriverId(driverId);
		//return sensors;
	}

	@Override
	public List<Sensor> querySensorsByCarId(int carId) {
		List<Sensor> sensors=new ArrayList<>();
		sensors.addAll(sensorDao.querySensorsByCarId(carId));
		return sensors;	
	}

}
