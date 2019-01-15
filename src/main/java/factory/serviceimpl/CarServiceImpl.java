package factory.serviceimpl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;

import factory.dao.CarDao;
import factory.dao.UserDao;
import factory.entity.Car;
import factory.entity.User;
import factory.exception.DataNoneException;
import factory.service.CarService;
import factory.util.AssignCarThread;
import factory.util.GpsUtil;


@Service
public class CarServiceImpl implements CarService{
	
	@Autowired
	private CarDao carDao;
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private ThreadPoolTaskExecutor taskExecuter;

	@Override
	public List<Car> queryAllCar() {
		List<Car> cars=new ArrayList<Car>();
		cars.addAll(carDao.queryAllCar());
		return cars;
	}

	@Override
	public Car queryCarByDriverId(int driverId) {
		return carDao.queryCarByDriverId(driverId);
	}
	

	@Override
	public Car queryCarByLicense(String license) {
		return carDao.queryCarByLicense(license);
	}
	

	@Override
	public List<Car> queryCarByStatus(int status) {
		List<Car> cars=new ArrayList<Car>();
		cars.addAll(carDao.queryCarByStatus(status));
		return cars;
	}
	

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
			throw new DataNoneException("���ƺű�����Ϊ�գ�");
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
			throw new DataNoneException("���ƺű�����Ϊ��!");
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
	public List<Car> queryTreatmentCarUnassign() {
		// TODO Auto-generated method stub
		List<Car> cars=new ArrayList<Car>();
		cars.addAll(carDao.queryTreatmentCarUnassign());
		for(Car car:cars){
			System.out.println(car.getLicense());
		}
		return cars;
	}
	@Override
	public List<Car> queryCarrierUnassign() {
		// TODO Auto-generated method stub
		List<Car> cars=new ArrayList<Car>();
		cars.addAll(carDao.queryCarrierUnassign());
		for(Car car:cars){
			System.out.println(car.getLicense());
		}
		return cars;
	}
	
	@Override
	public Car assignCar(int siteId, double siteLongitude, double siteLatitude,int carType) {
		// TODO Auto-generated method stub
		List<Car> cars=new ArrayList<Car>();
		/*if(carType == 0){
			cars.addAll(carDao.queryTreatmentCarUnassign());
		}else if(carType == 1){
			cars.addAll(carDao.queryCarrierUnassign());
		}
		if(cars.size() == 0) return null;*/
		Future<List<Car>> futureCar=null;
		System.out.println(taskExecuter);
		futureCar=(taskExecuter.submit(new AssignCarThread(carDao, carType)));
		try {
			cars.addAll(futureCar.get());
		} catch (InterruptedException e) {
			e.printStackTrace();
		} catch (ExecutionException e) {
			e.printStackTrace();
		}
		for(Car car:cars) {
			System.out.println(car.getId());
		}
		double minDistance = Double.MAX_VALUE;
		Car car = new Car();
		for(int i = 0; i < cars.size();i++){
			double dis = GpsUtil.getDistance(siteLongitude,siteLatitude,cars.get(i).getLongitude(),cars.get(i).getLatitude());
			System.out.println("id: "+ cars.get(i).getId() + "  "+ dis);
			if(dis < minDistance){
				minDistance = dis;
				car = cars.get(i);
			}
		}
		return car;
	}
	@Override
	public List<Car> queryMapCarBySiteId(int siteId) {
		// TODO Auto-generated method stub
		List<Car> cars=new ArrayList<Car>();
		cars.addAll(carDao.queryMapCarBySiteId(siteId));
		for(Car car:cars){
			System.out.println(car.getLicense());
		}
		return cars;
	}
	
	@Override
	public List<Car> querycarWithoutVideo() {
		// TODO Auto-generated method stub
		List<Car> carWithoutVideo=new ArrayList<Car>();
		carWithoutVideo.addAll(carDao.querycarWithoutVideo());
		for(Car car:carWithoutVideo){
			System.out.println(car.getId()+car.getLicense());
		}
		return carWithoutVideo;
	}
	@Override
	public List<Car> queryCarByCarType(int carType) {
		List<Car> cars=new ArrayList<>();
		cars.addAll(carDao.queryCarByCarType(carType));
		return cars;
	}

	@Override
	public void editWorkerCarStatusAndSiteId(int carId, int status, int siteId) {
		carDao.editWorkerCarStatusAndSiteId(carId, status, siteId);		
	}
	
}
