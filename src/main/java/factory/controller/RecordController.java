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

import factory.entity.Record;
import factory.entity.Site;
import factory.entity.User;
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
	private SludgeService sludgeService;
	
	@Autowired
	private ThreadPoolTaskExecutor taskExecuter;
	
	@Autowired
	private  SimpleDateFormat dateFormat;
	
	private static Log log=LogFactory.getLog(RecordController.class);
	/**
	 * @description:��record���в�ѯ���м�¼
	 */
	@RequestMapping("/jumpToRecord")
	public ModelAndView querySiteAndDriver(ModelAndView mv){
		log.info("���ò�ѯ������˾���ķ���");
		List<User> assignCarDrivers=userService.queryCarAssignedDriver();
		List<User> allDrivers=userService.quertAllDriver();
		List<Site> sites=siteService.queryAllSite();		
		mv.addObject("assignCarTreatDriver",userService.queryCarAssignTreatDriver());
		mv.addObject("driverList",allDrivers);
		mv.addObject("siteList",sites);
		mv.setViewName("record/records");
		return mv;
	}
	
	@RequestMapping("queryAllRecord")
	@ResponseBody
	public List<Record> queryAllRecord(){
		log.info("����queryAllRecord");
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
		log.info("����queryRecordBySiteId");
		List<Record> records=new ArrayList<Record>();
		records.addAll(recordService.queryRecordBySiteId(siteId));
		return records;	
	}
	
	
	
	@RequestMapping("queryRecordByDriverId")
	@ResponseBody
	public List<Record> queryRecordByDriverId(@RequestParam("driverId") int driverId){
		log.info("����queryRecordByDriverId");
		List<Record> records=new ArrayList<Record>();
		records.addAll(recordService.queryRecordByDriverId(driverId));
		return records;
	}
	
	@RequestMapping("queryRecordByDate")
	@ResponseBody
	public List<Record> queryRecordByDate(@RequestParam("startDate") String startDate,@RequestParam("endDate") String endDate){
		log.info("����queryRecordByDate");
		List<Record> records=new ArrayList<Record>();
		records.addAll(recordService.queryRecordByDate(startDate, endDate));
		return records;
	}
	
	@RequestMapping("editRecord")
	@ResponseBody
	public Map<String, Object> editRecord(@RequestBody Map<String,Integer> jsonMap){
		log.info("����editRecord");
		Map<String, Object> map=new HashMap<String, Object>();
		try {
			//����ط�Ҫ���������
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
		log.info("���ò�ѯ�����ķ���");
		User user=(User) session.getAttribute("user");
		List<Site> sites=siteService.querySiteServedByOneDriver(user.getId());		
		mv.addObject("siteList",sites);
		mv.setViewName("worker/record");
		return mv;
	}
	
	@RequestMapping("queryAllRecordOfOneDriver")
	@ResponseBody
	public List<Record> queryAllRecordOfOneDisposeDriver(@RequestBody User user){
		log.info("����queryAllRecordOfOneDisposeDriver");
		System.out.println(user.getId());
		List<Record> records=recordService.queryAllRecordOfOneDriver(user.getId());
		System.out.println(records.size()+"ha");
		return records;
	}
	
	@RequestMapping("queryRecordBySiteIdOfOneDriver")
	@ResponseBody
	public  List<Record> queryRecordBySiteIdOfOneDriver(@RequestBody Map<String, Integer> condition){
		log.info("����queryRecordBySiteIdOfOneDriver");
		List<Record> records=recordService.queryRecordBySiteIdOfOneDriver(condition);
		return records;	
	}
	
	@RequestMapping("queryRecordByDateOfOneDriver")
	@ResponseBody
	public List<Record> queryRecordByDateOfOneDriver(@RequestBody Map<String, Object> condition){
		log.info("����queryRecordByDateOfOneDriver");
		List<Record> records=recordService.queryRecordByDateOfOneDriver(condition);
		return records;
	}
	
	
	@RequestMapping("/recordOfOneFactory")
	public ModelAndView recordOfOneFactory(@RequestParam("siteId") int siteId,ModelAndView mv){
		log.info("����recordOfOneFactory");
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
		log.info("����alert");
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
		log.info("���һ����¼");
		log.info(record.getSiteId()+","+record.getPretreatAmount());
		int siteId=record.getSiteId();
		record.setAllocationTime(dateFormat.format(new Date()));
		//����record״̬Ϊ������
		record.setStatus(RecordStatus.WATINGPROCESS.ordinal());
		recordService.insertRecordByAlert(record);
		//�޸Ĺ�����״̬Ϊ������
		siteService.updateSiteStatusById(siteId, SiteStatus.WATINGPROCESS.ordinal());
		System.out.println(record.getId());
		//��ѯ�����ľ�γ��
		Site site=siteService.querySiteById(siteId);
		/*double longitute=Double.valueOf(site.getLongitude());
		double latitute=Double.valueOf(site.getLatitude());
		//���ȴ���
		Car treatmentCar=carService.assignCar(siteId,longitute,latitute,0);
		//�������䳵
		Car transportCar=carService.assignCar(siteId, longitute, latitute, 1);*/
		//����һ���߳�ȥ����
		taskExecuter.submit(new AssignCarForReocrdThread(recordService, carService, sludgeService, record.getId(), site));
		return "success";
	}
	
	@RequestMapping("queryAllRecordOfOneFactory")
	@ResponseBody
	public List<Record> queryAllRecordOfOneFactory(@RequestBody Site site){
		log.info("����queryAllRecordOfOneFactory");
		List<Record> records=recordService.queryAllRecordOfOneFactory(site.getId());
		for(Record record:records) {
			System.out.println(record);
		}
		return records;
	}
	
	@RequestMapping("queryRecordByDriverIdOfOneFacotry")
	@ResponseBody
	public  List<Record> queryRecordByDriverIdOfOneFacotry(@RequestBody Map<String, Integer> condition){
		log.info("����queryRecordByDriverIdOfOneFacotry");
		List<Record> records=recordService.queryRecordByDriverIdOfOneFacotry(condition);
		for(Record record:records){
			System.out.println(record.getId());
		}
		return records;	
	}
	
	
	@RequestMapping("queryRecordByDateOfOneFactory")
	@ResponseBody
	public List<Record> queryRecordByDateOfOneFactory(@RequestBody Map<String, Object> condition){
		log.info("����queryRecordByDateOfOneFactory");
		List<Record> records=recordService.queryRecordByDateOfOneFactory(condition);
		for(Record record:records){
			System.out.println(record.getCar().getDriver().getRealname());
		}
		return records;
	}

	@RequestMapping("queryRecordOfCarNull")
	@ResponseBody
	public List<Record> queryRecordOfCarNull(){
		log.info("����queryRecordOfCarNull");
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
		log.info("����editRecordBySiteId");
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
	
	/**
	 * ����վ��Id���㵱ǰ�������
	 * @param siteId
	 * @return ���ش�����ȣ�-1���������쳣
	 */
	@RequestMapping("queryRateOfProcessBySiteId")
	@ResponseBody
	public double queryRateOfProcessBySiteId(@RequestParam("siteId") int siteId){
		log.info("����queryRateOfProcessBySiteId,siteId:"+siteId);
		return recordService.queryRateOfProcessBySiteId(siteId);
	}
	
	/**
	 * ����վ��Id���ص�ǰԤ������
	 * @param siteId
	 * @return ���ش�������-1���������쳣
	 */
	@RequestMapping("queryCurrentPretreatAmountBySiteId")
	@ResponseBody
	public double queryCurrentPretreatAmountBySiteId(@RequestParam("siteId") int siteId){
		log.info("����queryCurrentPretreatAmountBySiteId,siteId:"+siteId);
		return recordService.queryCurrentPretreatAmountBySiteId(siteId);
	}
}
