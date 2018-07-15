package factory.controller;

import factory.entity.Charge;
import factory.entity.Site;
import factory.service.*;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping(value="charge")
public class ChargeController {
	@Autowired
	private SiteService siteService;
	@Autowired
	private ChargeService chargeService;

	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式

	private static Log log=LogFactory.getLog(ChargeController.class);
	/**
	 * @description:从sludge和record表中查询所有记录
	 */

	@RequestMapping("/jumpToCharge")
	public ModelAndView querySite(ModelAndView mv){
		log.info("调用查询工厂的方法");
		List<Site> sites=siteService.queryAllSites();
		mv.addObject("siteList",sites);//设置需要返回的值
		mv.setViewName("charge/charge"); //跳转到指定的页面
//		for(int i=0;i<sites.size();i++)
//		{
//			System.out.println("the site is:"+sites.get(i).getSiteName());
//		}

		return mv; //返回到charge.jsp页面
	}

	@RequestMapping("queryAllCharge")
	@ResponseBody
	public List<Charge> queryAllCharge(){
		log.info("调用queryAllCharge");
		List<Charge> charge=chargeService.queryAllCharge();
		return charge;
	}
	
	@RequestMapping("queryChargeBySiteName")
	@ResponseBody
	public  List<Charge> queryChargeBySiteName(@RequestParam("siteName") String siteName,Model model){
		log.info("调用queryChargeBySiteName");
		List<Charge> charge=chargeService.queryChargeBySiteName(siteName);
		return charge;
	}

	@RequestMapping("queryChargeByDate")
	@ResponseBody
	public List<Charge> queryChargeByDate(@RequestParam("startDate") String startDate,@RequestParam("endDate") String endDate){
		log.info("调用queryChargeByDate");
		if(startDate == null || startDate =="")
		{
			startDate = df.format(new Date())+" 00:00:00";
		}

		if(endDate == null || endDate =="")
		{
			endDate = df.format(new Date())+" 23:59:59";
		}

		List<Charge> charge=chargeService.queryChargeByDate(startDate, endDate);
		return charge;
	}

}
