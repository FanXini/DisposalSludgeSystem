package factory.controller;

import factory.entity.Site;
import factory.entity.Sludge;
import factory.service.SiteService;
import factory.service.SludgeService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping(value="analyse")
public class AnalyseController {
	@Autowired
	private SiteService siteService;

	@Autowired
	private SludgeService sludgeService;

	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式

	private static Log log=LogFactory.getLog(ChargeController.class);
	/**
	 * @description:从sludge和record表中查询所有记录
	 */

	@RequestMapping("/jumpToAnalyse")
	public ModelAndView querySite(ModelAndView mv){
		log.info("调用查询工厂的方法");
		List<Site> sites=siteService.queryAllSites();
		mv.addObject("siteList",sites);//设置需要返回的值
		mv.setViewName("analyse/analyse"); //跳转到指定的页面

		return mv; //返回到charge.jsp页面
	}

	@RequestMapping("queryAllSludge")
	@ResponseBody
	public List<Sludge> queryAllSludge(){
		log.info("进入查询所有污泥的方法");
		List<Sludge> sludges=new ArrayList<Sludge>();
		sludges.addAll(sludgeService.queryAllSludge());
		return sludges;
	}

	//	Add by Anmy at 2018-06-21
	@RequestMapping("querySludgeByDates")
	@ResponseBody
	public List<Sludge> querySludgeByDates(@RequestParam("startDate") String startDate,@RequestParam("endDate") String endDate,@RequestParam("siteId") int siteId){
		log.info("调用querySludgeByDates");
		System.out.println("siteid and startDate, endDate are:"+siteId+":"+startDate+","+endDate);
		if(startDate == null || startDate =="")
		{
			startDate = df.format(new Date())+" 00:00:00";
		}

		if(endDate == null || endDate =="")
		{
			endDate = df.format(new Date())+" 23:59:59";
		}

		List<Sludge> sludges=sludgeService.querySludgeByDates(startDate, endDate, siteId);
		return sludges;
	}

	//	Add by Anmy at 2018-06-21
	@RequestMapping("querySludgeBySiteName")
	@ResponseBody
	public List<Sludge> querySludgeBySiteName(@RequestParam("siteName") String siteName){
		log.info("调用 querySludgeBySiteName");
		List<Sludge> sludges=sludgeService.querySludgeBySiteName(siteName);
		return sludges;
	}
}
