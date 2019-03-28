package factory.controller;



import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import factory.entity.Record;
import factory.entity.Site;
import factory.entity.User;
import factory.enums.AutoAssign;
import factory.enums.CarStatus;
import factory.enums.RecordStatus;
import factory.enums.Result;
import factory.enums.SiteStatus;
import factory.exception.AllocateCarForRecordConflict;
import factory.service.CarService;
import factory.service.RecordService;
import factory.service.SiteService;
import factory.service.SludgeService;
import factory.service.UserService;
import factory.util.AssignCarForReocrdThread;

@Controller
@RequestMapping(value="record")
public class RecordController {
	@Autowired
	private RecordService recordService;
	@Autowired
	private UserService userService;
	@Autowired
	private SiteService siteService;
	@Autowired
	private CarService carService;
	
	@Autowired
	private  RedisTemplate<String, Object> redisTemplate;
	
	@Autowired
	private SludgeService sludgeService;
	
	@Autowired
	private ThreadPoolTaskExecutor taskExecuter;
	
	@Autowired
	private  SimpleDateFormat dateFormat;
	/*private  SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");*/
	
	private static Logger log=Logger.getLogger(RecordController.class);
	/**
	 * @description:从record表中查询所有记录
	 */
	@RequestMapping("/jumpToRecord")
	public ModelAndView querySiteAndDriver(ModelAndView mv){
		log.info("调用查询工厂和司机的方法");
		List<User> assignCarDrivers=userService.queryCarAssignedDriver();
		List<User> allDrivers=userService.quertAllDriver();
		List<Site> sites=siteService.queryAllSite();		
		mv.addObject("assignCarTreatDriver",userService.queryCarAssignTreatDriver());
		mv.addObject("driverList",allDrivers);
		mv.addObject("siteList",sites);
		mv.setViewName("mudwarehouse/records");
		return mv;
	}
	
	@RequestMapping("/jumpToSludgesOfOneRecord")
	public ModelAndView sludgesOfOneRecord(@RequestParam("recordId") int recordId,ModelAndView mv){
		log.info("jumpToSludgesOfOneRecord");
		mv.addObject("recordId", recordId);
		mv.setViewName("mudwarehouse/sludgeOfOneRecord");
		return mv;
	}
	
	@RequestMapping("queryassignCarTreatDriver")
	@ResponseBody
	public List<User> queryassignCarTreatDriver(){
		log.info("调用queryassignCarTreatDriver");
		return userService.queryCarAssignTreatDriver();
	}
	
	@RequestMapping("queryAllRecord")
	@ResponseBody
	public List<Record> queryAllRecord(){
		log.info("调用queryAllRecord");
		List<Record> records=new ArrayList<Record>();
		records.addAll(recordService.queryAllRecord());
		return records;
	}
	
	
	@RequestMapping("queryRecordBySiteId")
	@ResponseBody
	public  List<Record> queryRecordBySiteId(@RequestParam("siteId") int siteId,Model model){
		log.info("调用queryRecordBySiteId");
		List<Record> records=new ArrayList<Record>();
		records.addAll(recordService.queryRecordBySiteId(siteId));
		return records;	
	}
	
	
	
	@RequestMapping("queryRecordByDriverId")
	@ResponseBody
	public List<Record> queryRecordByDriverId(@RequestParam("driverId") int driverId){
		log.info("调用queryRecordByDriverId");
		List<Record> records=new ArrayList<Record>();
		records.addAll(recordService.queryRecordByDriverId(driverId));
		return records;
	}
	
	@RequestMapping("queryRecordByDriverIdAndStatus")
	@ResponseBody
	public List<Record> queryRecordByDriverIdAndStatus(@RequestParam("driverId") int driverId,@RequestParam("status") int status,@RequestParam("flag") int flag){
		log.info("调用queryRecordByDriverIdAndStatus");
		List<Record> records=new ArrayList<Record>();
		records.addAll(recordService.queryRecordByDriverIdAndStatus(driverId, status, flag));
		return records;
	}
	
	@RequestMapping("queryRecordByDate")
	@ResponseBody
	public List<Record> queryRecordByDate(@RequestParam("startDate") String startDate,@RequestParam("endDate") String endDate){
		log.info("调用queryRecordByDate");
		List<Record> records=new ArrayList<Record>();
		records.addAll(recordService.queryRecordByDate(startDate, endDate));
		return records;
	}
	
	@RequestMapping("editRecord")
	@ResponseBody
	public Map<String, Object> editRecord(@RequestBody Map<String,Integer> jsonMap){
		log.info("调用editRecord");
		Map<String, Object> map=new HashMap<String, Object>();
		try {
			//这个地方要用事务管理
			String license=recordService.editRecord(jsonMap);
			map.put("license",license);
			map.put("result", Result.SUCCESS);
		} catch (AllocateCarForRecordConflict e) {
			// TODO: handle exception
			e.printStackTrace();
			map.put("result",Result.CONFLICT);
		}catch (Exception e) {
			// TODO: handle exception
			map.put("result",Result.ERROR);
		}
		return map;
	}
	
	@RequestMapping("deleteRecord")
	@ResponseBody
	public Result deleteRecord(@RequestParam("recordId") int recordId){
		try {
			recordService.deleteRecord(recordId);
			return Result.SUCCESS;
		} catch (Exception e) {
			// TODO: handle exception
			return Result.ERROR;
		}
		
	}
	
	
	
	@RequestMapping("/recordOfOneDriver")
	public ModelAndView recordOfOneDriver(ModelAndView mv,HttpSession session){
		log.info("调用查询工厂的方法");
		User user=(User) session.getAttribute("user");
		List<Site> sites=siteService.querySiteServedByOneDriver(user.getId());		
		mv.addObject("siteList",sites);
		mv.setViewName("worker/record");
		return mv;
	}
	
	@RequestMapping("queryAllRecordOfOneDriver")
	@ResponseBody
	public List<Record> queryAllRecordOfOneDisposeDriver(@RequestBody User user){
		log.info("调用queryAllRecordOfOneDisposeDriver");
		System.out.println(user.getId());
		List<Record> records=recordService.queryAllRecordOfOneDriver(user.getId());
		System.out.println(records.size()+"ha");
		return records;
	}
	
	@RequestMapping("queryRecordBySiteIdOfOneDriver")
	@ResponseBody
	public  List<Record> queryRecordBySiteIdOfOneDriver(@RequestBody Map<String, Integer> condition){
		log.info("调用queryRecordBySiteIdOfOneDriver");
		List<Record> records=recordService.queryRecordBySiteIdOfOneDriver(condition);
		return records;	
	}
	
	@RequestMapping("queryRecordByDateOfOneDriver")
	@ResponseBody
	public List<Record> queryRecordByDateOfOneDriver(@RequestBody Map<String, Object> condition){
		log.info("调用queryRecordByDateOfOneDriver");
		List<Record> records=recordService.queryRecordByDateOfOneDriver(condition);
		return records;
	}
	
	
	@RequestMapping("/recordOfOneFactory")
	public ModelAndView recordOfOneFactory(@RequestParam("siteId") int siteId,ModelAndView mv){
		log.info("调用recordOfOneFactory");
		log.info(siteId);
		List<User> drivers=userService.queryTreatDriverServeOneFactory(siteId);
		for(User user:drivers){
			System.out.println(user.getRealname());
		}
		mv.addObject("driverList",drivers);
		mv.setViewName("factory/record");
		return mv;
	}
	
	@RequestMapping("/alert")
	@ResponseBody
	public ModelAndView alert(@RequestParam("siteId") int siteId,ModelAndView mv){
		log.info("调用alert");
		log.info(siteId);
		Site site = siteService.querySiteById(siteId);
		System.out.println(site.getId()+","+site.getSiteName()+","+site.getAddress()+","+site.getTelephone()+","+site.getManage());
		mv.addObject("site",site);
		mv.setViewName("factory/alert");
		return mv;
	}
	
	@RequestMapping("/insertRecordByAlert")
	@ResponseBody
	@Transactional
	//@CacheEvict(value="site",allEntries=true)
	public String insertRecordByAlert(@RequestBody Record record) {
		log.info("添加一条记录");
		log.info(record.getSiteId()+","+record.getPretreatAmount());
		int siteId=record.getSiteId();
		record.setAllocationTime(dateFormat.format(new Date()));
		//设置record状态为待处理
		record.setStatus(RecordStatus.WATINGPROCESS.ordinal());
		recordService.insertRecordByAlert(record);
		//修改工厂的状态为待处理
		siteService.updateSiteStatusById(siteId, SiteStatus.WATINGPROCESS.ordinal());
		if(AutoAssign.autoAssign) {
			Site site=siteService.querySiteById(siteId);
			taskExecuter.submit(new AssignCarForReocrdThread(redisTemplate,recordService, carService, sludgeService, record.getId(), site));
		}
		return "success";
	}
	
	@RequestMapping("queryAllRecordOfOneFactory")
	@ResponseBody
	public List<Record> queryAllRecordOfOneFactory(@RequestBody Site site){
		log.info("调用queryAllRecordOfOneFactory");
		List<Record> records=recordService.queryAllRecordOfOneFactory(site.getId());
		for(Record record:records) {
			System.out.println(record);
		}
		return records;
	}
	
	@RequestMapping("queryRecordByDriverIdOfOneFacotry")
	@ResponseBody
	public  List<Record> queryRecordByDriverIdOfOneFacotry(@RequestBody Map<String, Integer> condition){
		log.info("调用queryRecordByDriverIdOfOneFacotry");
		List<Record> records=recordService.queryRecordByDriverIdOfOneFacotry(condition);
		for(Record record:records){
			System.out.println(record.getId());
		}
		return records;	
	}
	
	
	@RequestMapping("queryRecordByDateOfOneFactory")
	@ResponseBody
	public List<Record> queryRecordByDateOfOneFactory(@RequestBody Map<String, Object> condition){
		log.info("调用queryRecordByDateOfOneFactory");
		List<Record> records=recordService.queryRecordByDateOfOneFactory(condition);
		return records;
	}

	@RequestMapping("queryRecordOfCarNull")
	@ResponseBody
	public List<Record> queryRecordOfCarNull(){
		log.info("调用queryRecordOfCarNull");
		try {
			List<Record> records=recordService.queryRecordOfCarNull();
			return records;
		}catch (Exception e) {
			// TODO: handle exception
			log.info(e);
			return null;
		}
	}
	@Transactional
	@RequestMapping("assignDriverForRecord")
	@ResponseBody
	public Result assignDriverForRecord(@RequestParam("siteId") int siteId,@RequestParam("treatcarId") int treatcarId,@RequestParam("transcarId") int transcarId){
		log.info("调用editRecordBySiteId");
		Map<String, String> result=new HashMap<String, String>();
		try {
			recordService.assignDriverForRecord(siteId, treatcarId, transcarId);
			return Result.SUCCESS;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return Result.ERROR;
			
		}
	}
	
	/**
	 * 根据站点Id计算当前处理进度
	 * @param siteId
	 * @return 返回处理进度，-1代表数据异常
	 */
	@RequestMapping("queryRateOfProcessBySiteId")
	@ResponseBody
	public double queryRateOfProcessBySiteId(@RequestParam("siteId") int siteId){
		log.info("调用queryRateOfProcessBySiteId,siteId:"+siteId);
		return recordService.queryRateOfProcessBySiteId(siteId);
	}
	
	/**
	 * 根据站点Id返回当前预处理量
	 * @param siteId
	 * @return 返回处理量，-1代表数据异常
	 */
	@RequestMapping("queryCurrentPretreatAmountBySiteId")
	@ResponseBody
	public double queryCurrentPretreatAmountBySiteId(@RequestParam("siteId") int siteId){
		log.info("调用queryCurrentPretreatAmountBySiteId,siteId:"+siteId);
		return recordService.queryCurrentPretreatAmountBySiteId(siteId);
	}
	
	@RequestMapping("updateRecordStatusById")
	@ResponseBody
	public Result updateRecordStatusById(@RequestParam("recordId") int recordId,@RequestParam("status") int status){
		log.info("updateRecordStatusById");
		try {
			 recordService.updateRecordStatusById(recordId, status);
			 return Result.SUCCESS;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return Result.ERROR;
		}
	}
}
