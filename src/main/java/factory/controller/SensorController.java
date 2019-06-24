package factory.controller;

import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import factory.entity.Car;
import factory.entity.Sensor;
import factory.entity.SensorType;
import factory.entity.SensorValue;
import factory.entity.Site;
import factory.enums.Result;
import factory.exception.DataNoneException;
import factory.service.CarService;
import factory.service.SensorService;
import factory.service.SiteService;
import net.sf.json.JSONArray;

@Controller
@RequestMapping("sensor")
public class SensorController {
	@Autowired
	private SensorService sensorService;
	@Autowired
	private CarService carService;
	@Autowired
	private SiteService siteService;

	private Log log = LogFactory.getLog(SensorController.class);

	@RequestMapping("jumpToDeviceManage")
	public ModelAndView jumpToDeviceManageJSP(ModelAndView mv) {
		log.info("调用jumpToDeviceManageJSP");
		List<SensorType> sensorTypes = sensorService.queryAllSensorType();
		List<Car> cars = carService.queryAllCar();
		List<Site> sites = siteService.queryAllSite();
		mv.addObject("sensorTypeList", sensorTypes);
		JSONArray carJson = JSONArray.fromObject(cars);
		JSONArray siteJson = JSONArray.fromObject(sites);
		mv.addObject("carList", carJson.toString());
		mv.addObject("siteList", siteJson.toString());
		mv.setViewName("system/deviceManage");
		return mv;
	}
    @RequestMapping("queryAllSensorType")
    @ResponseBody
    public List<SensorType> queryAllSensorType(){
    	List<SensorType> sensorTypes = sensorService.queryAllSensorType();
    	return sensorTypes;
    }
    
	@RequestMapping("queryAllSensor")
	@ResponseBody
	public List<Sensor> queryAllSensor() {
		List<Sensor> sensors = sensorService.queryAllSensor();
		Collections.sort(sensors, new Comparator<Sensor>() {
			public int compare(Sensor arg0, Sensor arg1) {
				return arg0.getSerialNumber().compareTo(arg1.getSerialNumber());
			}
		});
		/*for (Sensor sensor : sensors) {
			System.out.println(sensor.getCar().getId() + "  " + sensor.getSite().getId());
		}*/
		return sensors;

	}

	@RequestMapping("addSensor")
	@ResponseBody
	public Map<String, Object> addSensor(@RequestBody Map<String, String> sensorInfo) {
		log.info("调用增加传感器");
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			/*for (Map.Entry<String, String> entry : sensorInfo.entrySet()) {
				System.out.println(entry.getKey() + " " + entry.getValue());
			}*/
			int sensorId=sensorService.addSensor(sensorInfo);
			result.put("result", Result.SUCCESS);
			result.put("sensorId",sensorId);

		} catch (DuplicateKeyException e) {
			// TODO: handle exception
			result.put("result", Result.DUPLICATE);
		}catch (DataNoneException e) {
			// TODO: handle exception
			result.put("result", Result.INPUT);
		}catch (Exception e) {
			// TODO: handle exception
			result.put("result", Result.ERROR);
		}
		return result;

	}
	//delete不会报异常
	@RequestMapping("deleteSensor")
	@ResponseBody
	public Result deleteSensor(@RequestBody Map<String, Integer> deleteSensorInfo) {
		log.info("调用deleteSensor");
		try {
			sensorService.deleteSensor(deleteSensorInfo);
			return Result.SUCCESS;
		} catch (Exception e) {
			// TODO: handle exception
			return Result.ERROR;
		}
	}

	@RequestMapping("conditionalQuery")
	@ResponseBody
	public List<Sensor> conditionQuery(@RequestBody Map<String, String> condition) {
		log.info("调用conditionalQuery");
		/*for (Map.Entry<String, String> entry : condition.entrySet()) {
			System.out.println(entry.getKey() + " " + entry.getValue());
		}*/
		List<Sensor> sensors = sensorService.conditionQuery(condition);
		Collections.sort(sensors, new Comparator<Sensor>() {
			public int compare(Sensor arg0, Sensor arg1) {
				return arg0.getSerialNumber().compareTo(arg1.getSerialNumber());
			}
		});
		System.out.println(sensors);
		for (Sensor sensor2 : sensors) {
			System.out.println(sensor2.getSerialNumber());
		}
		return sensors;
	}
	@RequestMapping("deviceDetail")
	public ModelAndView deviceDetail(@RequestParam("id") int id,@RequestParam("location") String location,@RequestParam("locationId") int locationId,ModelAndView mv){
		log.info(locationId+" "+location);
		List<Sensor> sensors=sensorService.querySensorDetail(id, locationId);
		mv.addObject("sensorList",sensors);
		mv.addObject("location",location);
		mv.setViewName("system/deviceDetail");
		return mv;
	}
	
	@RequestMapping("queryHistoryData")
	@ResponseBody
	public List<Float> queryHistoryData(@RequestBody Map<String, Object> map){
		log.info("queryHistoryData");
		return sensorService.queryHistoryDataOfSingleValueBySensorId(map);
	}
	
	@RequestMapping("queryRealTimeValue")
	@ResponseBody
	public SensorValue queryRealTimeValue(@RequestParam("sensorId") int sensorId){
		log.info("queryRealTimeValue");
		return sensorService.queryRealTimeValueBySensorId(sensorId);
	}
	
	@RequestMapping("querySensorBySensorId")
    @ResponseBody
    public Sensor querySensorBySensorId(@RequestParam("sensorId") int sensorId){
		log.info("调用querySensorBySensorId:" + sensorId);
		Sensor sensor = sensorService.querySensorBySensorId(sensorId);
		System.out.println(sensor);
		return sensor;
	}
	

}
