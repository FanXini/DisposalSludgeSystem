package factory.serviceimpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import factory.dao.CarDao;
import factory.dao.UserDao;
import factory.entity.Car;
import factory.entity.User;
import factory.exception.DataNoneException;
import factory.service.CarService;


@Service
public class CarServiceImpl implements CarService{
	@Autowired
	private CarDao carDao;
	
	@Autowired
	private UserDao userDao;

	@Override
	public List<Car> queryAllCar() {
		List<Car> cars=new ArrayList<Car>();
		cars.addAll(carDao.queryAllCar());
		return cars;
	}
	/**
	 * 通过driverId查询Car的信息
	 */
	@Override
	public Car queryCarByDriverId(int driverId) {
		return carDao.queryCarByDriverId(driverId);
	}
	
	/**
	 * 通过车牌号查询Car的信息
	 */
	@Override
	public Car queryCarByLicense(String license) {
		return carDao.queryCarByLicense(license);
	}
	
	/**
	 * 通过车辆状态查询Car的信息
	 */
	@Override
	public List<Car> queryCarByStatus(int status) {
		List<Car> cars=new ArrayList<Car>();
		cars.addAll(carDao.queryCarByStatus(status));
		return cars;
	}
	
	/**
	 * 删除记录
	 */
	public void deleteCar(int carId) {
		// TODO Auto-generated method stub
		carDao.deleteCar(carId);
	}
	/*@Override
	public Map<String, List<User>> queryDrivers() {
		List<User> allDriverList=userDao.queryAllDriver();
		List<User> NoCarAssignedDriverList=userDao.queryNoCarAssignedDriver();
		Map<String, List<User>> listMap=new HashMap<String, List<User>>();
		listMap.put("allDriverList", allDriverList);
		listMap.put("NoCarAssignedDriverList", NoCarAssignedDriverList);
		return listMap;		
	}*/
	
	@Override
	public List<User> queryNoCarAssignedDriver() {
		List<User> NoCarAssignedDriverList=new ArrayList<User>();
		NoCarAssignedDriverList.addAll(userDao.queryNoCarAssignedDriver());
		return NoCarAssignedDriverList;		
	}
	@Override
	public int addCar(Car car) {
		// TODO Auto-generated method stub
		if (car.getLicense().equals("") || car.getLicense() == null) {
			throw new DataNoneException("车牌号表单数据为空！");
		}
		else if(car.getBrand().equals("none")){
			car.setBrand(null);
		}
		carDao.addCar(car);
		return car.getId();
	}
	@Override
	public void editCar(Car car) {
		// TODO Auto-generated method stub
		if (car.getLicense().equals("") || car.getLicense() == null) {
			throw new DataNoneException("车牌号表单数据为空！");
		}
		if(car.getBrand().equals("none")){
			car.setBrand(null);
		}
		if(car.getDriverId()==-1){
			User driver=userDao.queryUserByRealName(car.getDriver().getRealname());
			car.setDriverId(driver.getId());
		}
		carDao.editCar(car);	
	}
	@Override
	public List<Car> fuzzyQueryCar(String condition) {
		List<Car> cars=new ArrayList<Car>();
		cars.addAll(carDao.fuzzyQueryCar(condition));
		/*cars.addAll(carDao.fuzzyQueryCarWithNoDriver(condition));*/
		return cars;
	}
	@Override
	public List<Car> queryAllCarOrderByStatus() {
		// TODO Auto-generated method stub
		List<Car> cars=new ArrayList<Car>();
		cars.addAll(carDao.queryAllCarOrderByStatus());
		return cars;
	}
	@Override
	public List<Car> queryMapCar(String queryStr) {
		// TODO Auto-generated method stub
		return carDao.queryMapCar(queryStr);
	}
	@Override
	public List<Car> queryWorkerMapCar(int userId) {
		// TODO Auto-generated method stub
		return carDao.queryWorkerMapCar(userId);
	}
	@Override
	public void editWorkerCarStatus(int userId, int status) {
		// TODO Auto-generated method stub
		carDao.editWorkerCarStatus(userId,status);
	}
	@Override
	public List<Car> queryCarWhichNotAssignDriver() {
		List<Car>  cars=new ArrayList<Car>();
		cars.addAll(carDao.queryCarWhichNotAssignDriver());
		return cars;
	}
	@Override
	public List<Car> queryCarUnassign() {
		// TODO Auto-generated method stub
		List<Car> cars=new ArrayList<Car>();
		cars.addAll(carDao.queryCarUnassign());
		for(Car car:cars){
			System.out.println(car.getLicense());
		}
		return cars;
	}

}
