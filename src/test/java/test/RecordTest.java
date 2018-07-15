package test;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import factory.dao.RecordDao;
import factory.entity.Record;

public class RecordTest extends BaseTest{
	@Autowired
	private RecordDao recordDao;
	private static List<Record> recordList;
	
	@Test
	public void test(){
		recordList=recordDao.queryAllRecord();
		System.out.println(recordList.size());
		for(Record record:recordList)
		{
			System.out.println(record.getCar().getDriver().getUsername());
		}
	}
	
	
	

	
	@Test
	public void queryRecordByDate(){
		recordList=recordDao.queryRecordByDate("2018-12-12", "2018-12-13");
		System.out.println(recordList.size());
		for(Record record:recordList){
			System.out.println(record.getAllocationTime());
		}
			
	}

}
