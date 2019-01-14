package test;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import factory.dao.MudWareHouseDao;
import factory.entity.MinorMudWareHouse;

public class MudWareHouseTest extends BaseTest {

	@Autowired
	private MudWareHouseDao dao;

	@Test
	public void test() {
		List<MinorMudWareHouse> list = dao.queryMinorWareHouse();
		for (MinorMudWareHouse house : list) {
			System.out.println(house.getId() + " " + house.getMainMudWareHouseId() + " " + house.getSerialNumber()+
					" "+house.getCapacity()+" "+house.getRemainCapacity()+" "+house.getMoistrueDegree());
		}
	}
}
