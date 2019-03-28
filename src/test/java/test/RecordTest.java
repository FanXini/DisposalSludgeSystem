package test;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import factory.dao.RecordDao;
import factory.entity.Record;
import factory.entity.RecordTreatCar;

public class RecordTest extends BaseTest{
	@Autowired
	private RecordDao recordDao;
	private static List<Record> recordList;
	
	/*@Test
	public void test(){
		recordList=recordDao.queryAllRecord();
		for(Record record:recordList)
		{
			System.out.println(record.getId());
			for(RecordTreatCar recordTreatCar:record.getRecordTreatCars()) {
				System.out.println(recordTreatCar.getTreatcar().getDriver().getRealname());
			}
		}
	}*/
	
	@Test
	public void test13() {
		Record treatmentRecord=recordDao.queryProcessingRecordBySiteIdOfCarAndRecord(2);
		System.out.println(treatmentRecord.getCarNum());
	}
	

	
//	@Test
//	public void queryRecordByDate(){
//		recordList=recordDao.queryRecordByDate("2018-12-12", "2018-12-13");
//		System.out.println(recordList.size());
//		for(Record record:recordList){
//			System.out.println(record.getAllocationTime());
//		}
//			
//	}

}
