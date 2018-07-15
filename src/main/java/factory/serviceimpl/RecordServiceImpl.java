package factory.serviceimpl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import factory.dao.CarDao;
import factory.dao.RecordDao;
import factory.entity.Car;
import factory.entity.Record;
import factory.enums.Result;
import factory.exception.AllocateCarForRecordConflict;
import factory.service.RecordService;

@Service
public class RecordServiceImpl implements RecordService{
	@Autowired
	private RecordDao recordDao;
	
	@Autowired
	private CarDao carDao;
	
	/**
	 * 查询所有的处理记录
	 */
	@Override
	public List<Record> queryAllRecord() {
		// TODO Auto-generated method stub
		return recordDao.queryAllRecord();
	}
	/**
	 * 通过工厂名来查询处理记录
	 */
	@Override
	public List<Record> queryRecordBySiteId(int siteId) {
		// TODO Auto-generated method stub
		return recordDao.queryRecordBySiteId(siteId);
	}
	/**
	 * 通过处理人(司机)来查询处理记录
	 */
	@Override
	public List<Record> queryRecordByDriverId(int driverId) {
		// TODO Auto-generated method stub
		return recordDao.queryRecordByDriverId(driverId);
	}

	/**
	 * 通过日期查询处理记录
	 */
	@Override
	public List<Record> queryRecordByDate(String startDate, String endDate) {
		// TODO Auto-generated method stub
		return recordDao.queryRecordByDate(startDate, endDate);
	}
	/**
	 * 修改处理人
	 */
	@Override
	public void updateCarId(int recordId, int carId) {
		// TODO Auto-generated method stub
		recordDao.updateCarId(recordId, carId);
		
	}
	
	/**
	 * 删除记录
	 */
	@Override
	public void deleteRecord(int recordId) {
		// TODO Auto-generated method stub
		recordDao.deleteRecord(recordId);
	}
	@Override
	public List<Record> queryAllRecordOfOneDriver(int driverId) {
		List<Record> records=new ArrayList<Record>();
		records.addAll(recordDao.queryAllRecordOfOneDriver(driverId));
		return records;
		
	}
	@Override
	public List<Record> queryRecordBySiteIdOfOneDriver(Map<String, Integer> condition) {
		List<Record> records=new ArrayList<Record>();
		int driverId=condition.get("driverId");
		int siteId=condition.get("siteId");
		System.out.println(driverId+"  "+siteId);
		records.addAll(recordDao.queryRecordBySiteIdOfOneDriver(driverId, siteId));
		return records;
	}
	@Override
	public List<Record> queryRecordByDateOfOneDriver(Map<String, Object> condition) {
		int driverId=(int) condition.get("driverId");
		String startDate=String.valueOf(condition.get("startDate"));
		String endDate=String.valueOf(condition.get("endDate"));
		System.out.println(driverId+" "+startDate+" "+endDate);
		List<Record> records=new ArrayList<Record>();
		records.addAll(recordDao.queryRecordByDateOfOneDriver(driverId, startDate, endDate));
		return records;
	}
	@Override
	public List<Record> queryAllRecordOfOneFactory(int siteId) {
		List<Record> records=new ArrayList<Record>();
		records.addAll(recordDao.queryAllRecordOfOneFactory(siteId));
		return records;
	}
	@Override
	public List<Record> queryRecordByDriverIdOfOneFacotry(Map<String, Integer> condition) {
		List<Record> records=new ArrayList<Record>();
		int driverId=condition.get("driverId");
		int siteId=condition.get("siteId");
		System.out.println(driverId+"  "+siteId);
		records.addAll(recordDao.queryRecordByDriverIdOfOneFacotry(driverId, siteId));
		return records;		
	}
	@Override
	public List<Record> queryRecordByDateOfOneFactory(Map<String, Object> condition) {
		int siteId=(int) condition.get("siteId");
		String startDate=String.valueOf(condition.get("startDate"));
		String endDate=String.valueOf(condition.get("endDate"));
		System.out.println(siteId+" "+startDate+" "+endDate);
		List<Record> records=new ArrayList<Record>();
		records.addAll(recordDao.queryRecordByDateOfOneFactory(siteId, startDate, endDate));
		return records;
	}
	@Override
	public String editRecord(Map<String, Integer> map) {
		// TODO Auto-generated method stubCar car=carService.queryCarByDriverId(jsonMap.get("driverId"));
		int recordId=map.get("recordId");
		int driverId=map.get("driverId");
		int siteId=map.get("siteId");
		Car queryCar=carDao.queryCarByRecordId(recordId);//查询record是否已经分配了处理人(车)
		if(queryCar==null){ //未分配司机
			Car car=carDao.queryCarByDriverId(driverId);
			recordDao.updateCarId(recordId, car.getId());
			//car.status --0表示空闲，1表示在途中，2到达，3已派单（未出发），4返程（处理完）
			carDao.editWorkerCarStatusAndSiteId(car.getId(), 3, siteId); 
			return car.getLicense();
		}
		else{//分配了司机
			if(queryCar.getStatus()==1||queryCar.getStatus()==2||queryCar.getStatus()==4){
				throw new AllocateCarForRecordConflict("无法更改");
			}
			else{//0-空闲状态和3已派单状态-可以修改
				//要把之前分配的car状态改回来
				carDao.editWorkerCarStatusAndSiteId(queryCar.getId(),0,0);//sql判断如果siteId是0，则赋值site_id=NULL
				Car newCar=carDao.queryCarByDriverId(driverId);
				recordDao.updateCarId(recordId, newCar.getId());
				carDao.editWorkerCarStatusAndSiteId(newCar.getId(), 3, siteId);
				return newCar.getLicense();
			}
		}
		
	}
	@Override
	public List<Record> queryRecordOfCarNull() {
		// TODO Auto-generated method stub
		return recordDao.queryRecordOfCarNull();
	}
	
	@Override
	public void editRecordCarIdBySiteId(int siteId, int carId) {
		// TODO Auto-generated method stub
		recordDao.editRecordCarIdBySiteId(siteId,carId);
		carDao.editWorkerCarStatusAndSiteId(carId,3,siteId);
	}
	

}
