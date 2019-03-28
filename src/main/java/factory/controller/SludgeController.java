package factory.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import factory.entity.Sludge;
import factory.entity.MinorMudWareHouse;
import factory.entity.Site;
import factory.entity.SludgeFunction;
import factory.entity.User;
import factory.enums.Result;
import factory.service.MudWareHouseService;
import factory.service.SiteService;
import factory.service.SludgeService;
import factory.service.UserService;



@Controller
@RequestMapping("sludge")
public class SludgeController {
	private Log log=LogFactory.getLog(SludgeController.class);
	
	@Autowired
	private SludgeService sludgeService;
	
	@Autowired
	private SiteService siteService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private MudWareHouseService mudWareHouseService;
	
		@RequestMapping("/transportsludgeofonedriver")
		@ResponseBody
		public ModelAndView transportsludgeofonedriver(@RequestParam("driverId") int driverId, ModelAndView mv){
			log.info("transportsludgeofonedriver");
			List<Sludge> sludges=sludgeService.transportsludgeofonedriver(driverId);
			/*log.info(sludges.size());
			for(Sludge item:sludges){
				System.out.println(item.getTranscarId()+","+item.getCar().getLicense());

			};*/
			if (sludges==null&&sludges.size()<0) {
				sludges =null;
			} 
			List<MinorMudWareHouse> minorMudWareHouses=mudWareHouseService.queryMinorWareHouse();

			mv.addObject("sludgeList",sludges);
			mv.addObject("minorMudWareHouseList",minorMudWareHouses);
			mv.setViewName("worker/transportsludge");
			return mv;
		}
		
		@RequestMapping("updateSludgeVirtualToRealByDriver")
		@ResponseBody
		public Result updateSludgeVirtualToRealByDriver(@RequestBody Sludge sludge) {
			log.info("updateSludgeVirtualToRealByDriver");
			try {
				sludgeService.insertSludgeByDriver(sludge);
				return Result.SUCCESS;
			} catch (Exception e) {
				e.printStackTrace();
				return Result.ERROR;
			}
		}
		
		@RequestMapping("querysludgebydriverIdAndStatus")
		@ResponseBody
		public List<Sludge> querysludgebydriverIdAndStatus(@RequestParam("driverId") int driverId,@RequestParam("status") String status){
			log.info("querysludgebydriverIdAndStatus");
			List<Sludge> sludge = sludgeService.querysludgebydriverIdAndStatus(driverId,status);
			return sludge;
		}
		
		@RequestMapping("fussyQuerysludgebyTransDriver")
		@ResponseBody
		public List<Sludge> fussyQuerysludgebyTransDriver(@RequestParam("condition") String condition,@RequestParam("driverId") int driverId){
			log.info("fussyQuerysludgebyTransDriver");
			log.info(condition);
			List<Sludge> sludges = new ArrayList<Sludge>();
				sludges.addAll(sludgeService.fussyQuerysludgebyTransDriver(condition,driverId));
				log.info(sludges.size());
				for(Sludge item:sludges){
					System.out.println(item.getRecordId());
				};
			return sludges;
		}
	
	@RequestMapping("jumpToSludge")
	public ModelAndView querySludgeFunctionsAndJumpToSludge(ModelAndView mv){
		log.info("querySludgeFunctionsAndJumpToSludge");
		List<User> assignCarTransportDriver=new ArrayList<User>();
		List<Site> sites=new ArrayList<Site>();
		assignCarTransportDriver.addAll(userService.queryCarAssignTranSportDriver());
		sites.addAll(siteService.queryAllSite());
		List<MinorMudWareHouse> minorMudWareHouses=mudWareHouseService.queryMinorWareHouse();
		mv.addObject("minorMudWareHouses",minorMudWareHouses);
		mv.addObject("assignCarTransportDriver",assignCarTransportDriver);
		mv.addObject("siteList",sites);
		mv.setViewName("mudwarehouse/sludge");
		return mv;
	}
	
	/*@RequestMapping("queryAllSite")
	@ResponseBody
	public List<Site> queryAllSite(){
		log.info("queryAllSite");
		return siteService.queryAllSite();
	}*/
	
	@RequestMapping("assignCarTransportDriver")
	@ResponseBody
	public List<User> queryassignCarTransportDriver(){
		log.info("assignCarTransportDriver");
		return userService.queryCarAssignTranSportDriver();
	}
	
	@RequestMapping("queryAllFunc")
	@ResponseBody
	public List<SludgeFunction> queryAllFunc(){
		log.info("queryAllFunc");
		return sludgeService.queryAllSludgeFunction();
	}
	@RequestMapping("queryAllSludgeByInOutFlagAndWareHouseSerial")
	@ResponseBody
	public List<Sludge> queryAllSludgeByInOutFlagAndWareHouseSerial(@RequestBody Map<String, Integer> map){
		int inOutFlag=map.get("inOutFlag");
		int minorWareHouseId=map.get("minorWareHouseId");
		List<Sludge> sludges=new ArrayList<Sludge>();
		sludges.addAll(sludgeService.queryAllSludgeByInOutFlagWithMinorWareHouseId(inOutFlag, minorWareHouseId));
		return sludges;
	}
	
	@RequestMapping("deleteSludge")
	@ResponseBody
	public Result deleteSludge(@RequestParam("sludgeId") int sludgeId){
		log.info("deleteSludge");
		System.out.println(sludgeId);
		try {
			sludgeService.deleteSludge(sludgeId);
			return Result.SUCCESS;
		} catch (Exception e) {
			return Result.ERROR;
		}
	}
	
	@RequestMapping("addOutSludge")
	@ResponseBody
	public Result addOutSludge(@RequestBody Sludge sludge) {
		log.info("addOutSludge");
		try {
			sludgeService.addOutSludge(sludge);
			return Result.SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return Result.ERROR;
		}
		
	}
	@RequestMapping("editSludge")
	@ResponseBody
	public Result editSludge(@RequestBody Sludge sludge){
		log.info("editSludge");
		System.out.println(sludge.getId()+" "+sludge.getDestinationAddress()+sludge.getSludgeFunction().getFunction());
		try {
			sludgeService.editSludge(sludge);
			return Result.SUCCESS;
		} catch (Exception e) {
			// TODO: handle exception
			return Result.ERROR;
		}
	}
	
	@RequestMapping("querySludgeBySiteIdAndInOutFlag")
	@ResponseBody
	public  List<Sludge> querySludgeBySiteIdAndInOutFlag(@RequestBody Map<String, Integer> map){
		log.info("querySludgeBySiteIdAndInOutFlag");
		int siteId=map.get("siteId");
		int inOutFlag=map.get("inOutFlag");
		int minorWareHouseId=map.get("minorWareHouseId");
		
		List<Sludge> sludges=sludgeService.querySludgeBySiteIdAndInOutFlagWithMinorWareHouseId(siteId, inOutFlag, minorWareHouseId);
		return sludges;	
	}
	
	
	
	@RequestMapping("querySludgeByDriverId")
	@ResponseBody
	public List<Sludge> querySludgeByDriverId(@RequestParam("driverId") int driverId){
		log.info("querySludgeByDriverId");
		List<Sludge> sludges=sludgeService.querySludgeByDriverId(driverId);
		return sludges;
	}
	
	@RequestMapping("querySludgeByDriverIdAndInOutFlag")
	@ResponseBody
	public List<Sludge> querySludgeByDriverIdAndInOutFlag(@RequestBody Map<String, Integer> map){
		log.info("querySludgeByDriverIdAndInOutFlag");
		int driverId=(int) map.get("driverId");
		int inOutFlag=(int) map.get("inOutFlag");
		int minorWareHouseId=map.get("minorWareHouseId");
		List<Sludge> sludges=sludgeService.querySludgeByDriverIdAndInOutFlagWithMinorWareHouseId(driverId,inOutFlag,minorWareHouseId);
		return sludges;
	}
	
	@RequestMapping("querySludgeByDateAndInOutFlag")
	@ResponseBody
	public List<Sludge> querySludgeByDateAndInOutFlag(@RequestBody Map<String, String> map){
		log.info("querySludgeByDateAndInOutFlag");
		String startDate=map.get("startDate");
		String endDate=map.get("endDate");
		int inOutFlag=Integer.valueOf(map.get("inOutFlag"));
		int minorWareHouseId=Integer.valueOf(map.get("minorWareHouseId"));
		List<Sludge> sludges=sludgeService.querySludgeByDateAndInOutFlagWithMinorWareHouseId(startDate, endDate, inOutFlag,minorWareHouseId);
		return sludges;
	}
	
	@RequestMapping("jumpToSludgeOfOneFactory")
	public ModelAndView querySludgeFunctionsAndJumpToSludgeOfOneFactroy(@RequestParam("siteId") int siteId,ModelAndView mv){
		log.info("querySludgeFunctionsAndJumpToSludgeOfOneFactroy");
		List<SludgeFunction> sludgeFunctions=new ArrayList<SludgeFunction>();
		List<User> drivers=new ArrayList<User>();
		sludgeFunctions.addAll(sludgeService.queryAllSludgeFunction());
		drivers.addAll(userService.queryTransDriverServeOneFactory(siteId));	
		mv.addObject("sludgeFunctions",sludgeFunctions);
		mv.addObject("driverList",drivers);
		mv.setViewName("factory/sludge");
		return mv;
	}
	
	@RequestMapping("queryAllSludgeOfOneFactory")
	@ResponseBody
	public List<Sludge> queryAllSludgeOfOneFactory(@RequestBody Site site){
		log.info("queryAllSludgeOfOneFactory");
		return sludgeService.queryAllSludgeOfOneFactory(site.getId());
	}
	
	@RequestMapping("querySludgeByDriverIdOfOneFactory")
	@ResponseBody
	public  List<Sludge> querySludgeByDriverIdOfOneFactory(@RequestBody Map<String, Integer> condition){
		log.info("querySludgeByDriverIdOfOneFactory");
		return sludgeService.querySludgeByDriverIdOfOneFacotry(condition);	
	}
	
	@RequestMapping("querySludgeByDateOfOneFactory")
	@ResponseBody
	public List<Sludge> querySludgeByDateOfOneFactory(@RequestBody Map<String,Object> condition){
		log.info("querySludgeByDateOfOneFactory");
		for(Map.Entry<String, Object> entry:condition.entrySet()){
			System.out.print(entry.getKey()+"   "+entry.getValue());
		}
		return sludgeService.querySludegByDateOfOneFactory(condition);
	}

}
