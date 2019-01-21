package factory.serviceimpl;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;

import factory.dao.CarDao;
import factory.dao.RecordDao;
import factory.dao.SiteDao;
import factory.dao.SludgeDao;
import factory.dao.UserDao;
import factory.entity.Car;
import factory.entity.Record;
import factory.entity.Sludge;
import factory.entity.User;
import factory.enums.CarStatus;
import factory.enums.RecordStatus;
import factory.enums.SiteStatus;
import factory.enums.SludgeStatus;
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
	private RecordDao recordDao;
	
	@Autowired
	private SiteDao siteDao;
	
	@Autowired
	private SludgeDao sludgeDao;
	
	@Autowired
	private ThreadPoolTaskExecutor taskExecuter;
	
	private static SimpleDateFormat dataFormat=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

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
			throw new DataNoneException("没有数据");
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
			throw new DataNoneException("没有数据");
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
	public List<Car> queryMapCar(String queryStr, int carType) {
		// TODO Auto-generated method stub
		return carDao.queryMapCar(queryStr, carType);
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
	public List<Car> queryMapCarBySiteIdAndCarTypeAndStatus(int siteId,int carType,int status) {
		// TODO Auto-generated method stub
		List<Car> cars=new ArrayList<Car>();
		cars.addAll(carDao.queryMapCarBySiteIdAndCarTypeAndStatus(siteId,carType,status));
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

	@Override
	public Car updateCarStatusByButton(Map<String, Integer> map) {
		int driverId=map.get("driverId");
		int nowStatus=map.get("nowStatus");
		Car car=carDao.queryCarByDriverId(driverId);
		int carStatusInDB=car.getStatus();
		int carType=car.getCarType();
		int carId=car.getId();
		int siteId=car.getSiteId();
		if(nowStatus!=carStatusInDB || nowStatus==CarStatus.LEISURE.ordinal()) {//是由页面触发而不是按钮触发
			return new Car(carStatusInDB, carType,siteId);
		}
		else {
			if(nowStatus==carStatusInDB) { //状态一致
				//如果车目前的状态是已分配任务,但还未出发
				//司机触发按钮表示开始出发
				if(nowStatus==CarStatus.NODEPARTURE.ordinal()) {
					//修改成在途中
					carDao.editWorkerCarStatus(driverId, CarStatus.ONTHEWAY.ordinal());
					return new Car(CarStatus.ONTHEWAY.ordinal(), carType,siteId);
				}
				//如果车目前的状态是在途中
				//司机触发按钮表示已到达
				else if(nowStatus==CarStatus.ONTHEWAY.ordinal()) {
					//修改成已到达
					carDao.editWorkerCarStatus(driverId, CarStatus.ARRIVAL.ordinal());
					if(carType==0) {  //如果是处理车到达,要修改record和site的状态为处理中,并设置record开始时间
						//查询现在处理的是哪个任务
						Record treatmentRecord=recordDao.queryRecordByCarIdAndStatus(car.getId(), RecordStatus.WATINGPROCESS.ordinal());
						//修改record的状态为处理中,并且设置任务开始时间,0表示存的是任务开始时间
						recordDao.UpdateRecordStatusAndTimeById(treatmentRecord.getId(), RecordStatus.PROCESSING.ordinal(), dataFormat.format(new Date()), 0);
						//修改site的状态为处理中
						siteDao.updateSiteStatusById(treatmentRecord.getSiteId(), SiteStatus.PROCESSING.ordinal());
						
					}
					else if(carType==1) { //如果是污泥车，要判断是到达污泥厂，还是到达目的地
						if(car.getSiteId()==0) {  //污泥到达目的地
							//查询当前运输的的污泥
							Sludge processingSludge=sludgeDao.queryProcessingSludgeByCarIdAndStatus(carId);
							String arrivalTime=dataFormat.format(new Date());
							int sludgeStatus=0;
							//如果是产出地到泥仓路上；
							if(processingSludge.getStatus()==SludgeStatus.FACTORYTOMWHRAOD.ordinal()) {
								sludgeStatus=SludgeStatus.STOREINMWH.ordinal();
							}
							//如果是产出地到目的地路上；
							else if (processingSludge.getStatus()==SludgeStatus.FACTORYTODESROAD.ordinal()){
								sludgeStatus=SludgeStatus.ARRIVEDESFROMFACTORY.ordinal();
							}
							//如果是泥仓地到泥仓路上；
							else if (processingSludge.getStatus()==SludgeStatus.MWHTODESROAD.ordinal()){
								sludgeStatus=SludgeStatus.ARRIVEDESFROMMWH.ordinal();
							}
							sludgeDao.setArrivalTimeAndStatusById(processingSludge.getId(), sludgeStatus, arrivalTime);
						}
					}
					return new Car(CarStatus.ARRIVAL.ordinal(), carType,siteId);
				}
				//如果车目前的状态是已到达
				//司机触发按钮表示到底处理任务完成 或者是  运输任务开始/结束了
				else if(nowStatus==CarStatus.ARRIVAL.ordinal()) {
					if(carType==0) {  //如果是处理车
						// 修改为车的状态返程状态,修改site为null
						carDao.editWorkerCarStatusAndSiteId(carId, CarStatus.GETBACK.ordinal(),0); 
						//查询现在处理的是哪个任务
						Record treatmentRecord=recordDao.queryRecordByCarIdAndStatus(car.getId(), RecordStatus.PROCESSING.ordinal());
						//修改record的状态为处理完成
						recordDao.UpdateRecordStatusAndTimeById(treatmentRecord.getId(), RecordStatus.ACCOMPLISH.ordinal(), dataFormat.format(new Date()), 1);
						//修改site的状态为正常
						siteDao.updateSiteStatusById(treatmentRecord.getSiteId(), SiteStatus.NORMAL.ordinal());
						return new Car(CarStatus.GETBACK.ordinal(),carType,0);
					}
					else if(carType==1) {//如果是运输车
						if(siteId!=0) { //开始将污泥运输到目的地,工厂置为0
							carDao.editWorkerCarStatusAndSiteId(carId, CarStatus.ONTHEWAY.ordinal(),0);
							return new Car(CarStatus.ONTHEWAY.ordinal(),carType,0);
						}
						else {  //送到了目的地,返程
							carDao.editWorkerCarStatus(driverId, CarStatus.GETBACK.ordinal());
							return new Car(CarStatus.GETBACK.ordinal(),carType,siteId);
						}
					}
				}
				//如果处理车目前的状态返程
				//司机触发按钮表示到达仓库了
				else if(nowStatus==CarStatus.GETBACK.ordinal()) {
					carDao.editWorkerCarStatus(driverId, CarStatus.LEISURE.ordinal());
					return new Car(CarStatus.LEISURE.ordinal(),carType,siteId);
				}
			}
		}
		return null;
	}

	@Override
	public Car flushCarStatus(int driverId) {
		return carDao.queryCarByDriverId(driverId);
	}
	
}
