package factory.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import factory.entity.Car;
import factory.entity.Record;

public interface RecordDao {

	public List<Record> queryAllRecord();
	
	public List<Record> queryRecordBySiteId(@Param("siteId")int siteId);
	
	public List<Record> queryRecordByRecordId(@Param("recordId")int recordId);
	
	public List<Record> queryRecordByDriverId(@Param("driverId")int driverId);
	
	public List<Record> queryRecordByDriverIdAndStatus(@Param("driverId")int driverId,@Param("status") int status,@Param("flag") int flag);
	
	public List<Record> queryRecordByDate(@Param("startDate") String startDate,@Param("endDate") String endDate);
	
	public void updateCarId(@Param("recordId") int recordId,@Param("carId")int carId);
	
	public void deleteRecord(@Param("recordId") int recordId);
	
	public List<Record> queryAllRecordOfOneDriver(@Param("driverId") int driverId);
	
	public List<Record> queryRecordBySiteIdOfOneDriver(@Param("driverId") int driverId,@Param("siteId") int siteId);
	
	public List<Record> queryRecordByDateOfOneDriver(@Param("driverId") int driverId,@Param("startDate") String startDate,@Param("endDate") String endDate);
	
	public List<Record> queryAllRecordOfOneFactory(@Param("siteId") int siteId);
	
	public List<Record> queryRecordByDriverIdOfOneFacotry(@Param("driverId") int driverId,@Param("siteId") int siteId);
	
	public List<Record> queryRecordByDateOfOneFactory(@Param("siteId") int siteId,@Param("startDate") String startDate,@Param("endDate") String endDate);

	public List<Record> queryRecordOfCarNull();

	public void editRecordCarIdBySiteId(@Param("siteId") int siteId,@Param("carId") int carId);

	public int countRecordOfCarNullBySiteId(int siteId);
	
	public int insertRecordByAlert(Record record);
	
	public Record queryRateOfProcessBySiteId(@Param("siteId") int siteId);
	
	public double queryCurrentPretreatAmountBySiteId(@Param("siteId") int siteId);
	
	public void updateRecordStatusById(@Param("recordId") int recordId,@Param("status") int status);
	
	public Record queryRecordByCarIdAndStatus(@Param("carId") int carId,@Param("status") int status);
	
	public void UpdateRecordStatusAndTimeById(@Param("recordId") int recordId,@Param("status") int status,@Param("time") String time,@Param("timeFlag")int timeFlag);
	
	
	
}
