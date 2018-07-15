package test;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import factory.dao.SludgeDao;
import factory.entity.Sludge;
import factory.entity.SludgeFunction;

public class SludgeTest extends BaseTest {

	@Autowired
	private SludgeDao sludgeDao;
	/*
	 * @Test public void queryAllSludgeFunction(){ List<SludgeFunction>
	 * sludgeFunctions=sludgeDao.queryAllSludgeFunction();
	 * System.out.println(sludgeFunctions.size()); }
	 */

/*	@Test
	public void queryAllSludge() {
		List<Sludge> sludges = sludgeDao.queryAllSludge();
		for (Sludge sludge : sludges) {
			System.out.println(sludge.getRfidString() + "  " + sludge.getDestinationAddress() + " "
					+ sludge.getRecord().getId() + " " + sludge.getRecord().getCar().getLicense() + " "
					+ sludge.getRecord().getCar().getDriver().getTelephone() + "  "
					+ sludge.getRecord().getSite().getSiteName());
		}
	}*/
	
	@Test
	public void deleteSludge(){
		sludgeDao.deleteSludge(1);
	}

}
