package factory.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import factory.entity.Car;
import factory.entity.Site;
import factory.entity.User;
import factory.enums.CarStatus;
import factory.enums.Result;
import factory.exception.DataNoneException;
import factory.service.CarService;
import factory.service.UserService;

@Controller
@RequestMapping(value = "car")
public class CarController {
	@Autowired
	private CarService carService;
	
	@Autowired
	private UserService userService;
	private static Log log = LogFactory.getLog(CarController.class);

	/**
	 * @description:从car表中查询所有车辆
	 */
	@RequestMapping("carManage")
	public String jumpToCarManage() {	
		return "system/carManage";
	}
	
	

	@RequestMapping("queryAllCar")
	@ResponseBody
	public List<Car> queryAllCar() {
		log.info("调用queryAllCar");
		List<Car> cars = carService.queryAllCar();
		return cars;
	}

	@RequestMapping("queryCarByLicense")
	@ResponseBody
	public Car queryCarByLicense(@RequestParam("license") String license, Model model) {
		log.info("调用queryCarByLicense");
		Car car = carService.queryCarByLicense(license);
		return car;
	}
	@RequestMapping("queryCarWhichNotAssignDriver")
	@ResponseBody
	public List<Car> queryCarWhichNotAssignDriver(){
		log.info("queryCarWhichNotAssignDriver");
		return carService.queryCarWhichNotAssignDriver();
	}

	@RequestMapping("queryCarByStatus")
	@ResponseBody
	public List<Car> queryCarByStatus(@RequestParam("status") int status, Model model) {
		log.info("调用queryCarByStatus");
		return carService.queryCarByStatus(status);
	}

	@RequestMapping("deleteCar")
	@ResponseBody
	public Result deleteCar(@RequestParam("carId") int carId) {
		log.info("调用删除car");
		/*Map<String, Result> result = new HashMap<String, Result>();*/
		try {
			carService.deleteCar(carId);
			return Result.SUCCESS;
		} catch (Exception e) {
			// TODO: handle exception
			return Result.ERROR;
		}
	}

	@RequestMapping("addCar")
	@ResponseBody
	public Map<String, Object> addCar(@RequestBody Car car) {
		log.info("调用addCar");
		log.info(car.getLicense() + "  " + car.getBrand() + "  " + car.getDriverId());
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			int carId = carService.addCar(car);
			map.put("result", Result.SUCCESS);
			map.put("carId", carId);
		} catch (DuplicateKeyException e) {
			// TODO: handle exception
			map.put("result", Result.DUPLICATE);
		}catch (DataNoneException e) {
			// TODO: handle exception
			map.put("result", Result.INPUT);
		}catch (Exception e) {
			// TODO: handle exception	
			e.printStackTrace();
			map.put("result", Result.ERROR);
		}
		return map;
	}

	@RequestMapping("editCar")
	@ResponseBody
	public Result editCar(@RequestBody Car car) {
		log.info("调用修改车辆信息的方法");
		log.info(car.getLicense() + " " + car.getId() + " " + car.getBrand() + " " + car.getDriverId());
		try {
			carService.editCar(car);
			return Result.SUCCESS;
		} catch (DuplicateKeyException e) {
			// TODO: handle exception
			return Result.DUPLICATE;
		} catch (DataNoneException e) {
			return Result.INPUT;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return Result.ERROR;
		}
	}

	@RequestMapping("fuzzyQueryCar")
	@ResponseBody
	public List<Car> fuzzyQueryCar(@RequestParam("condition") String condition) {
		log.info("进入fuzzyQueryCar");
		log.info(condition);
		List<Car> cars = new ArrayList<Car>();
		if (condition.equals("none")) {
			cars.addAll(carService.queryAllCar());
		} else {
			cars.addAll(carService.fuzzyQueryCar(condition));
		}
		return cars;
	}

	@RequestMapping("queryAllCarOrderByStatus")
	@ResponseBody
	public List<Car> queryAllCarOrderByStatus() {
		log.info("调用queryAllCarOrderByStatus");
		return carService.queryAllCarOrderByStatus();
	}
	
	@RequestMapping("queryMapCar")
	@ResponseBody
	public List<Car> queryMapCar(@RequestParam("queryStr") String queryStr,@RequestParam("carType") int carType) {
		log.info("地图查询车辆");
		List<Car> carList=new ArrayList<Car>();
		try{
			carList=carService.queryMapCar(queryStr,carType);
		}catch (Exception e) {
			// TODO: handle exception
			log.info(e);
			carList=null;
		}

		return carList;
	}
	
	@RequestMapping("queryWorkerMapCar")
	@ResponseBody
	public List<Car> queryWorkerMapCar(@RequestParam("userId") int userId) {
		log.info("司机地图查询待出发车辆");
		List<Car> carList=new ArrayList<Car>();
		try{
			carList=carService.queryWorkerMapCar(userId);
		}catch (Exception e) {
			// TODO: handle exception
			log.info(e);
			carList=null;
		}

		return carList;
	}
	
	@RequestMapping("editWorkerCarStatus")
	@ResponseBody
	public Map<String,String> editWorkerCarStatus(@RequestParam("userId") int userId,@RequestParam("status") int status) {
		log.info("司机更改状态");
		Map<String,String> result=new HashMap<String,String>();
		try{
			carService.editWorkerCarStatus(userId,status);
			result.put("result", "success");
		}catch (Exception e) {
			// TODO: handle exception
			log.info(e);
			result.put("result","failure");
		}

		return result;
	}
	/**
	 * 
	 *@Description:查询空闲的分配了司机的运输车辆
	 *@author:fanxin 
	 *@date:2019年1月22日 上午11:01:29
	 */
	@RequestMapping("queryCarrierUnassign")
	@ResponseBody
	public List<Car> queryCarrierUnassign(){
		log.info("queryCarrierUnassign");
		return carService.queryCarrierUnassign();
	}
	
	@RequestMapping("queryDriverUnassign")
	@ResponseBody
	public List<User> queryDriverUnassign() {
		log.info("查询空闲司机");
		try{
			return userService.queryDriverUnassign();
		}catch (Exception e) {
			// TODO: handle exception
			log.info(e);
			return null;
		}
	}
	
	/**
	 * @description:为站点分配运输车辆（根据最短直线距离）
	 */
	@RequestMapping("assignCarrier")
	@ResponseBody
	public Car assignCarrier(@RequestParam("id") int siteId,@RequestParam("longitude") String siteLongitude,@RequestParam("latitude") String siteLatitude) {
		log.info("为site"+siteId+"分配运输车辆");
		double longitude = Double.valueOf(siteLongitude);
		double latitude = Double.valueOf(siteLatitude);
		try{
			//1代表运输车辆
			return carService.assignCar(siteId,longitude,latitude,1);
		}catch (Exception e) {
			// TODO: handle exception
			log.info(e);
			return null;
		}
	}
	
	/**
	 * @description:为站点分配处理车辆（根据最短直线距离）
	 */
	@RequestMapping("assignTreatmentCar")
	@ResponseBody
	public Car assignTreatmentCar(@RequestParam("id") int siteId,@RequestParam("longitude") String siteLongitude,@RequestParam("latitude") String siteLatitude) {
		log.info("为site"+siteId+"分配处理车辆");
		double longitude = Double.valueOf(siteLongitude);
		double latitude = Double.valueOf(siteLatitude);
		try{
			//0代表处理车辆
			return carService.assignCar(siteId,longitude,latitude,0);
		}catch (Exception e) {
			// TODO: handle exception
			log.info(e);
			return null;
		}
	}
	
	/**
	 * @description:地图查找车辆信息
	 */
	@RequestMapping("queryMapCarBySiteIdAndCarTypeAndStatus")
	@ResponseBody
	public List<Car> queryMapCarBySiteIdAndCarTypeAndStatus(@RequestParam("siteId") int siteId,@RequestParam("carType") int carType,@RequestParam("status") int status) {
		log.info("查找site"+siteId+"carType"+carType+"status"+status+"的车辆列表");
		try{
			return carService.queryMapCarBySiteIdAndCarTypeAndStatus(siteId,carType,status);
		}catch (Exception e) {
			// TODO: handle exception
			log.info(e);
			return null;
		}
	}
	
	@RequestMapping("queryCarInRoad")
	@ResponseBody
	public List<Car> queryCarInRoad(){
		try {
			return carService.queryCarInRoad();
		} catch (Exception e) {
			return null;
		}
	}
	
	@RequestMapping("queryCarByCarType")
	@ResponseBody 
	List<Car> queryCarByCarType(@RequestParam("carType") int carType){
		log.info("queryCarByCarType type:"+carType);
		return carService.queryCarByCarType(carType);
	}
	@RequestMapping("updateCarStatusByButton")
	@ResponseBody
	public Car updateCarStatusByButton(@RequestBody Map<String, Integer> map) {
		try {
			return carService.updateCarStatusByButton(map);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	@RequestMapping("flushCarStatus")
	@ResponseBody
	public Car flushCarStatus(@RequestParam("driverId") int driverId) {
		try {
			return carService.flushCarStatus(driverId);
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	@RequestMapping("queryCarStatusById")
	@ResponseBody
	public Integer queryCarStatusById(@RequestParam("id")int id) {
		return carService.queryCarStatusById(id);
	}
	
}
