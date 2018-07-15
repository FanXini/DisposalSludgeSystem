package factory.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import factory.entity.Car;
import factory.entity.Record;

public interface RecordDao {

	public List<Record> queryAllRecord();
	
	public List<Record> queryRecordBySiteId(@Param("siteId")int siteId);
	
	public List<Record> queryRecordByDriverId(@Param("driverId")int driverId);
	
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
	
	
	
}
