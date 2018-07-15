package test;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import factory.dao.SiteDao;
import factory.entity.Site;

public class SiteTest extends BaseTest{
	@Autowired
	private SiteDao siteDao;
	@Test
	public void queryAllSite(){
		List<Site> sites=siteDao.queryAllSite();
		System.out.println(sites.get(0).getSiteName());
	}
	@Test
	public void querySiteBySiteName(){
		Site site=siteDao.querySiteBySiteName("湖南星科环保科技有限公司");
		System.out.println(site.getId());
	}

	
}
