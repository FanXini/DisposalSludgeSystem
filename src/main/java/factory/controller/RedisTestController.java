package factory.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import factory.entity.User;
import factory.service.RedisTestService;
import factory.service.SiteService;

@Controller
public class RedisTestController {

	@Autowired
	public RedisTestService redisTestService;
	
	@Autowired
	private SiteService siteService;
	
	@RequestMapping("/RedisTest")
	@ResponseBody
	public void redisTest(@RequestParam("username") String username) {
		User user=redisTestService.getUserInfo(username);
		System.out.println(user.getUsername());		
	}
	
	@RequestMapping("/siteTest")
	@ResponseBody
	public void siteTest() {
		siteService.updateSiteStatusById(53, 2);	
	}
}
