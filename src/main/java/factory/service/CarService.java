package factory.service;

import java.util.List;
import java.util.Map;

import org.ietf.jgss.Oid;

import factory.entity.Car;
import factory.entity.User;

public interface CarService {
    public List<Car> queryAllCar();
	
	public Car queryCarByDriverId(int driverId);
	
	public Car queryCarByLicense(String license);
	
	public List<Car> queryCarByStatus(int status);
	
	public void deleteCar(int carId);
	
	public List<User> queryNoCarAssignedDriver();
	
	public int addCar(Car car);
	
	public void editCar(Car car);
	
	public List<Car> fuzzyQueryCar(String condition);

	public List<Car> queryAllCarOrderByStatus();

	public List<Car> queryMapCar(String queryStr,int carType);

	public List<Car> queryWorkerMapCar(int userId);

	public void editWorkerCarStatus(int userId, int status);
	
	public List<Car> queryCarWhichNotAssignDriver();

	public List<Car> queryTreatmentCarUnassign();
	
	public Car flushCarStatus(int driverId);
	
	public List<Car> queryCarrierUnassign();
	
	public Car assignCar(int siteId,double siteLongitude,double siteLatitude,int carType);
	
	public List<Car> queryMapCarBySiteIdAndCarTypeAndStatus(int siteId,int carType,int status);
	
	public List<Car> queryCarInRoad();
	
	public List<Car> querycarWithoutVideo();
	
	public List<Car> queryCarByCarType(int carType);
	
	/**
	 * 修改车的状态和siteId,如果siteId为0,则只修改carId
	 * @param carId
	 * @param status
	 * @param siteId
	 */
	public void editWorkerCarStatusAndSiteId(int carId,int status,int siteId);
	
	public Car updateCarStatusByButton(Map<String, Integer> map);
	
	public Integer queryCarStatusById(int id);
 
}
