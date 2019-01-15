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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import factory.entity.Car;
import factory.entity.Record;
import factory.entity.Site;
import factory.entity.User;
import factory.enums.Result;
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
	private SludgeService sludgeService;
	
	@Autowired
	private ThreadPoolTaskExecutor taskExecuter;
	private static SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	
	private static Log log=LogFactory.getLog(RecordController.class);
	/**
	 * @description:从record表中查询所有记录
	 */
	@RequestMapping("/jumpToRecord")
	public ModelAndView querySiteAndDriver(ModelAndView mv){
		log.info("调用查询工厂和司机的方法");
		List<User> assignCarDrivers=userService.queryCarAssignedDriver();
		List<User> allDrivers=userService.quertAllDriver();
		List<Site> sites=siteService.queryAllSite();		
		mv.addObject("assignCarDriverList",assignCarDrivers);
		mv.addObject("driverList",allDrivers);
		mv.addObject("siteList",sites);
		mv.setViewName("record/records");
		return mv;
	}
	
	@RequestMapping("queryAllRecord")
	@ResponseBody
	public List<Record> queryAllRecord(){
		log.info("调用queryAllRecord");
		List<Record> records=new ArrayList<Record>();
		records.addAll(recordService.queryAllRecord());
		for(Record record:records){
			System.out.println(record.getCar().getBrand());
		}
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
		List<User> drivers=userService.queryDriverServeOneFactory(siteId);
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
	public String insertRecordByAlert(@RequestBody Record record) {
		log.info("添加一条记录");
		log.info(record.getSiteId()+","+record.getPretreatAmount());
		int siteId=record.getSiteId();
		record.setAllocationTime(dateFormat.format(new Date()));
		recordService.insertRecordByAlert(record);
		System.out.println(record.getId());
		//查询出车的经纬度
		Site site=siteService.querySiteById(siteId);
		/*double longitute=Double.valueOf(site.getLongitude());
		double latitute=Double.valueOf(site.getLatitude());
		//调度处理车
		Car treatmentCar=carService.assignCar(siteId,longitute,latitute,0);
		//调度运输车
		Car transportCar=carService.assignCar(siteId, longitute, latitute, 1);*/
		//创建一个线程去调度运输车和传输车辆
		taskExecuter.submit(new AssignCarForReocrdThread(recordService, carService, sludgeService, record.getId(), site));
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
		for(Record record:records){
			System.out.println(record.getCar().getDriver().getRealname());
		}
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
	
	@RequestMapping("editRecordCarIdBySiteId")
	@ResponseBody
	public Map<String,String> editRecordCarIdBySiteId(@RequestParam("siteId") int siteId,@RequestParam("carId") int carId){
		log.info("调用editRecordBySiteId");
		Map<String, String> result=new HashMap<String, String>();
		try {
			recordService.editRecordCarIdBySiteId(siteId,carId);
			result.put("result", "success");
		}catch (Exception e) {
			// TODO: handle exception
			log.info(e);
			result.put("result", "failure");
		}
		return result;
	}
		
}
