package factory.serviceimpl;

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
			throw new DataNoneException("锟斤拷锟狡号憋拷锟斤拷锟斤拷为锟秸ｏ拷");
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
			throw new DataNoneException("锟斤拷锟狡号憋拷锟斤拷锟斤拷为锟斤拷!");
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
		if(nowStatus!=carStatusInDB || nowStatus==CarStatus.LEISURE.ordinal()) { //鏄敱椤甸潰瑙﹀彂鑰屼笉鏄寜閽Е鍙�
			return new Car(carStatusInDB, carType);
		}
		else {
			if(nowStatus==carStatusInDB) { //鐘舵�佷竴鑷�
				//濡傛灉杞︾洰鍓嶇殑鐘舵�佹槸宸插垎閰嶄换鍔�,浣嗚繕鏈嚭鍙�
				//鍙告満瑙﹀彂鎸夐挳琛ㄧず寮�濮嬪嚭鍙�
				if(nowStatus==CarStatus.NODEPARTURE.ordinal()) {
					//淇敼鎴愬湪閫斾腑
					carDao.editWorkerCarStatus(driverId, CarStatus.ONTHEWAY.ordinal());
					return new Car(CarStatus.ONTHEWAY.ordinal(), carType);
				}
				//濡傛灉杞︾洰鍓嶇殑鐘舵�佹槸鍦ㄩ�斾腑
				//鍙告満瑙﹀彂鎸夐挳琛ㄧず宸插埌杈�
				else if(nowStatus==CarStatus.ONTHEWAY.ordinal()) {
					//淇敼鎴愬凡鍒拌揪
					carDao.editWorkerCarStatus(driverId, CarStatus.ARRIVAL.ordinal());
					if(carType==0) { //濡傛灉鏄鐞嗚溅鍒拌揪,瑕佷慨鏀箁ecord鍜宻ite鐨勭姸鎬佷负澶勭悊涓�
						//鏌ヨ鐜板湪澶勭悊鐨勬槸鍝釜浠诲姟
						Record treatmentRecord=recordDao.queryRecordByCarIdAndStatus(car.getId(), RecordStatus.WATINGPROCESS.ordinal());
						//淇敼record鐨勭姸鎬佷负澶勭悊涓�,骞朵笖璁剧疆浠诲姟寮�濮嬫椂闂�,0琛ㄧず瀛樼殑鏄换鍔″紑濮嬫椂闂�
						recordDao.UpdateRecordStatusAndTimeById(treatmentRecord.getId(), RecordStatus.PROCESSING.ordinal(), dataFormat.format(new Date()), 0);
						//淇敼site鐨勭姸鎬佷负澶勭悊涓�
						siteDao.updateSiteStatusById(treatmentRecord.getSiteId(), SiteStatus.PROCESSING.ordinal());
						
					}
					return new Car(CarStatus.ARRIVAL.ordinal(), carType);
				}
				//濡傛灉杞︾洰鍓嶇殑鐘舵�佹槸宸插埌杈�
				//鍙告満瑙﹀彂鎸夐挳琛ㄧず鍒板簳澶勭悊浠诲姟/杩愯緭浠诲姟瀹屾垚浜�
				else if(nowStatus==CarStatus.ARRIVAL.ordinal()) {
					if(carType==0) { //濡傛灉鏄鐞嗚溅
						// 淇敼涓鸿溅鐨勭姸鎬佽繑绋嬬姸鎬�,淇敼site涓簄ull
						carDao.editWorkerCarStatusAndSiteId(car.getId(), CarStatus.GETBACK.ordinal(),0); 
						//鏌ヨ鐜板湪澶勭悊鐨勬槸鍝釜浠诲姟
						Record treatmentRecord=recordDao.queryRecordByCarIdAndStatus(car.getId(), RecordStatus.PROCESSING.ordinal());
						//淇敼record鐨勭姸鎬佷负澶勭悊瀹屾垚
						recordDao.UpdateRecordStatusAndTimeById(treatmentRecord.getId(), RecordStatus.ACCOMPLISH.ordinal(), dataFormat.format(new Date()), 1);
						//淇敼site鐨勭姸鎬佷负姝ｅ父
						siteDao.updateSiteStatusById(treatmentRecord.getSiteId(), SiteStatus.NORMAL.ordinal());
						return new Car(CarStatus.GETBACK.ordinal(),carType);
					}
					else if(carType==1) { //濡傛灉鏄繍杈撹溅
			
						//鏌ヨ褰撳墠杩愯緭鐨勭殑姹℃偿
						Sludge processingSludge=sludgeDao.queryProcessingSludgeByCarIdAndStatus(carId);
						String arrivalTime=dataFormat.format(new Date());
						int sludgeStatus=0;
						//濡傛灉鏄骇鍑哄湴鍒版偿浠撹矾涓婏紱
						if(processingSludge.getStatus()==SludgeStatus.FACTORYTOMWHRAOD.ordinal()) {
							sludgeStatus=SludgeStatus.STOREINMWH.ordinal();
						}
						//濡傛灉鏄骇鍑哄湴鍒扮洰鐨勫湴璺笂锛�
						else if (processingSludge.getStatus()==SludgeStatus.FACTORYTODESROAD.ordinal()){
							sludgeStatus=SludgeStatus.ARRIVEDESFROMFACTORY.ordinal();
						}
						//濡傛灉鏄偿浠撳湴鍒版偿浠撹矾涓婏紱
						else if (processingSludge.getStatus()==SludgeStatus.MWHTODESROAD.ordinal()){
							sludgeStatus=SludgeStatus.ARRIVEDESFROMMWH.ordinal();
						}
						sludgeDao.setArrivalTimeAndStatusById(processingSludge.getId(), sludgeStatus, arrivalTime);

						//修改为空闲状态,并且修改siteId为null
						carDao.editWorkerCarStatusAndSiteId(carId, CarStatus.LEISURE.ordinal(),0); 
						return new Car(CarStatus.LEISURE.ordinal(), carType);
					}
				}
				//濡傛灉澶勭悊杞︾洰鍓嶇殑鐘舵�佽繑绋�
				//鍙告満瑙﹀彂鎸夐挳琛ㄧず鍒拌揪浠撳簱浜�
				else if(nowStatus==CarStatus.GETBACK.ordinal()) {
					carDao.editWorkerCarStatus(driverId, CarStatus.LEISURE.ordinal());
					return new Car(CarStatus.LEISURE.ordinal(),carType);
				}
			}
		}
		return null;
	}
	
}
