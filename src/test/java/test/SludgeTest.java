package test;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.mysql.fabric.xmlrpc.base.Data;

import factory.dao.SludgeDao;
import factory.entity.Sludge;
import factory.entity.SludgeFunction;

public class SludgeTest extends BaseTest {

	@Autowired
	private SludgeDao sludgeDao;
	
	@Test
	public void test1() {
		//sludgeDao.setArrivalTimeAndStatusById(40, 1, "2001-12-12 10:10:10");
		List<Sludge> sludges=sludgeDao.queryAllSludgeOfOneFactory(53);
		for(Sludge sludge:sludges) {
			System.out.println(sludge.getCar().getDriver().getRealname());
		}
	}
	/*
	 * @Test public void queryAllSludgeFunction(){ List<SludgeFunction>
	 * sludgeFunctions=sludgeDao.queryAllSludgeFunction();
	 * System.out.println(sludgeFunctions.size()); }
	 */

	/*@Test
	public void queryAllSludge() {
		List<Sludge> sludges = sludgeDao.querySludgeByDriverIdAndInOutFlagWithMinorWareHouseId(driverId, inOutFlag, minorWareHouseId);
		for (Sludge sludge : sludges) {
			System.out.println(sludge.getId()+" "+sludge.getRfidString() + "  " + sludge.getDestinationAddress() + " "
					+ sludge.getRecord().getId() + " " + sludge.getRecord().getCar().getLicense() + " "
					+ sludge.getRecord().getCar().getDriver().getTelephone() + "  "
					+ sludge.getRecord().getSite().getSiteName());
		}
	}*/
	
	/*@Test
	public void deleteSludge(){
		sludgeDao.deleteSludge(1);
	}*/
}
