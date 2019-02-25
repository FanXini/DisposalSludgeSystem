package RedisTest;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import factory.service.CarService;
import factory.service.SiteService;

public class SiteTest extends BaseConfig{

	@Autowired
	private SiteService siteService;
	
	@Autowired 
	private CarService carService;
	
	/*@Test
	public void queryAll() {
		carService.queryMapCarBySiteIdAndCarTypeAndStatus(-1, -1, -1);
		siteService.querySiteMapBySiteIdAndStatus(-1,-1);
		System.out.println("ok");
	}*/
	@Test
	public void editSiteStatus() {
		siteService.updateSiteStatusById(53,2);
	}
	
	
}
