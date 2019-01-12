package test;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import factory.dao.MudWareHouseDao;

public class MudWareHouseTest extends BaseTest{

	@Autowired 
	private MudWareHouseDao dao;
	
	@Test
	public void test() {
		System.out.println(dao.queryWareHouse());
	}
}
