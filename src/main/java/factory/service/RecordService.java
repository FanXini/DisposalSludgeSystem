package factory.service;

import java.util.List;
import java.util.Map;

import factory.entity.Car;
import factory.entity.Record;
public interface RecordService {
	
	public List<Record> queryAllRecord();
	
	public List<Record> queryRecordBySiteId(int siteId);
	
	public List<Record> queryRecordByDriverId(int driverId);
	
	public List<Record> queryRecordByDriverIdAndStatus(int driverId,int status,int flag);
	
	public List<Record> queryRecordByDate(String startDate,String endDate);
	
	public void updateCarId(int recordId,int carId);
	
	public void deleteRecord(int recordId);
	
	public String editRecord(Map<String, Integer> map);
	
	public List<Record> queryAllRecordOfOneDriver(int driverId);
	
	public List<Record> queryRecordBySiteIdOfOneDriver(Map<String, Integer> condition);
	
	public List<Record> queryRecordByDateOfOneDriver(Map<String, Object> condition);
	
	public List<Record> queryAllRecordOfOneFactory(int siteId);
	
	public List<Record> queryRecordByDriverIdOfOneFacotry(Map<String, Integer> condition);
	
	public List<Record> queryRecordByDateOfOneFactory(Map<String, Object> condition);

	public List<Record> queryRecordOfCarNull();

	public void editRecordCarIdBySiteId(int siteId, int carId);
	
	public void insertRecordByAlert(Record record);
	
	public double queryRateOfProcessBySiteId(int siteId);
	
	public double queryCurrentPretreatAmountBySiteId(int siteId);
	
	public void synUpdateRecordAndSiteStatus(int recordId,int siteId,int status);
	

}
