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
	 * @description:��car���в�ѯ���г���
	 */
	@RequestMapping("carManage")
	public String jumpToCarManage() {	
		return "system/carManage";
	}
	
	

	@RequestMapping("queryAllCar")
	@ResponseBody
	public List<Car> queryAllCar() {
		log.info("����queryAllCar");
		List<Car> cars = carService.queryAllCar();
		return cars;
	}

	@RequestMapping("queryCarByLicense")
	@ResponseBody
	public Car queryCarByLicense(@RequestParam("license") String license, Model model) {
		log.info("����queryCarByLicense");
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
		log.info("����queryCarByStatus");
		return carService.queryCarByStatus(status);
	}

	@RequestMapping("deleteCar")
	@ResponseBody
	public Result deleteCar(@RequestParam("carId") int carId) {
		log.info("����ɾ��car");
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
		log.info("����addCar");
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
		log.info("�����޸ĳ�����Ϣ�ķ���");
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
			return Result.ERROR;
		}
	}

	@RequestMapping("fuzzyQueryCar")
	@ResponseBody
	public List<Car> fuzzyQueryCar(@RequestParam("condition") String condition) {
		log.info("����fuzzyQueryCar");
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
		log.info("����queryAllCarOrderByStatus");
		return carService.queryAllCarOrderByStatus();
	}
	
	@RequestMapping("queryMapCar")
	@ResponseBody
	public List<Car> queryMapCar(@RequestParam("queryStr") String queryStr,@RequestParam("carType") int carType) {
		log.info("��ͼ��ѯ����");
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
		log.info("˾����ͼ��ѯ����������");
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
		log.info("˾������״̬");
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
	 *@Description:��ѯ���еķ�����˾�������䳵��
	 *@author:fanxin 
	 *@date:2019��1��22�� ����11:01:29
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
		log.info("��ѯ����˾��");
		try{
			return userService.queryDriverUnassign();
		}catch (Exception e) {
			// TODO: handle exception
			log.info(e);
			return null;
		}
	}
	
	/**
	 * @description:Ϊվ��������䳵�����������ֱ�߾��룩
	 */
	@RequestMapping("assignCarrier")
	@ResponseBody
	public Car assignCarrier(@RequestParam("id") int siteId,@RequestParam("longitude") String siteLongitude,@RequestParam("latitude") String siteLatitude) {
		log.info("Ϊsite"+siteId+"�������䳵��");
		double longitude = Double.valueOf(siteLongitude);
		double latitude = Double.valueOf(siteLatitude);
		try{
			//1�������䳵��
			return carService.assignCar(siteId,longitude,latitude,1);
		}catch (Exception e) {
			// TODO: handle exception
			log.info(e);
			return null;
		}
	}
	
	/**
	 * @description:Ϊվ����䴦�������������ֱ�߾��룩
	 */
	@RequestMapping("assignTreatmentCar")
	@ResponseBody
	public Car assignTreatmentCar(@RequestParam("id") int siteId,@RequestParam("longitude") String siteLongitude,@RequestParam("latitude") String siteLatitude) {
		log.info("Ϊsite"+siteId+"���䴦����");
		double longitude = Double.valueOf(siteLongitude);
		double latitude = Double.valueOf(siteLatitude);
		try{
			//0��������
			return carService.assignCar(siteId,longitude,latitude,0);
		}catch (Exception e) {
			// TODO: handle exception
			log.info(e);
			return null;
		}
	}
	
	/**
	 * @description:��ͼ���ҳ�����Ϣ
	 */
	@RequestMapping("queryMapCarBySiteIdAndCarTypeAndStatus")
	@ResponseBody
	public List<Car> queryMapCarBySiteIdAndCarTypeAndStatus(@RequestParam("siteId") int siteId,@RequestParam("carType") int carType,@RequestParam("status") int status) {
		log.info("����site"+siteId+"carType"+carType+"status"+status+"�ĳ����б�");
		try{
			return carService.queryMapCarBySiteIdAndCarTypeAndStatus(siteId,carType,status);
		}catch (Exception e) {
			// TODO: handle exception
			log.info(e);
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
	
}
