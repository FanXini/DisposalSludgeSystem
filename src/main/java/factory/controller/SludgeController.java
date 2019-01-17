package factory.controller;

import static org.hamcrest.CoreMatchers.nullValue;

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
import org.springframework.web.servlet.tags.EditorAwareTag;

import factory.entity.Sludge;
import factory.dao.MudWareHouseDao;
import factory.entity.MinorMudWareHouse;
import factory.entity.Site;
import factory.entity.SludgeFunction;
import factory.entity.User;
import factory.enums.Result;
import factory.service.MudWareHouseService;
import factory.service.SiteService;
import factory.service.SludgeService;
import factory.service.UserService;
import net.sf.json.JSONArray;



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
	
	//污泥运输车司机工作记录
		@RequestMapping("/transportsludgeofonedriver")
		@ResponseBody
		public ModelAndView transportsludgeofonedriver(@RequestParam("driverId") int driverId, ModelAndView mv){
			log.info("调用transportsludgeofonedriver");
			List<Sludge> sludges=sludgeService.transportsludgeofonedriver(driverId);
			/*log.info(sludges.size());
			for(Sludge item:sludges){
				System.out.println(item.getTranscarId()+","+item.getCar().getLicense());

			};*/
			if (sludges==null&&sludges.size()<0) {
				sludges =null;
			} 

			};
			List<MinorMudWareHouse> minorMudWareHouses=mudWareHouseService.queryMinorWareHouse();

			mv.addObject("sludgeList",sludges);
			mv.addObject("minorMudWareHouseList",minorMudWareHouses);
			mv.setViewName("worker/transportsludge");
			return mv;
		}
		
		//污泥运输车司机插入一条污泥记录
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
		
		//查询污泥运输车司机未处理的污泥（污泥status=6）
		@RequestMapping("querysludgebydriverIdAndStatus")
		@ResponseBody
		public Sludge querysludgebydriverIdAndStatus(@RequestParam("driverId") int driverId){
			log.info("调用querysludgebydriverIdAndStatus");
			Sludge sludge = sludgeService.querysludgebydriverIdAndStatus(driverId);
			return sludge;
		}
		
		//运输司机界面模糊查询
		@RequestMapping("fussyQuerysludgebyTransDriver")
		@ResponseBody
		public List<Sludge> fussyQuerysludgebyTransDriver(@RequestParam("condition") String condition,@RequestParam("driverId") int driverId){
			log.info("进入fussyQuerysludgebyTransDriver");
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
		log.info("调用进入sludge.jsp的方法");
		List<User> drivers=new ArrayList<User>();
		List<Site> sites=new ArrayList<Site>();
		drivers.addAll(userService.quertAllDriver());
		sites.addAll(siteService.queryAllSite());
		List<MinorMudWareHouse> minorMudWareHouses=mudWareHouseService.queryMinorWareHouse();
		mv.addObject("minorMudWareHouses",minorMudWareHouses);
		mv.addObject("driverList",drivers);
		mv.addObject("siteList",sites);
		mv.addObject("assignCarTransportDriver",userService.queryCarAssignTranSportDriver());
		mv.setViewName("mudwarehouse/sludge");
		log.info(minorMudWareHouses.size());
		return mv;
	}
	@RequestMapping("queryAllFunc")
	@ResponseBody
	public List<SludgeFunction> queryAllFunc(){
		log.info("查询所有污泥的功能");
		return sludgeService.queryAllSludgeFunction();
	}
	@RequestMapping("queryAllSludgeByInOutFlagAndWareHouseSerial")
	@ResponseBody
	public List<Sludge> queryAllSludgeByInOutFlagAndWareHouseSerial(@RequestBody Map<String, Integer> map){
		int inOutFlag=map.get("inOutFlag");
		int minorWareHouseId=map.get("minorWareHouseId");
		if(inOutFlag==0) {
			log.info("查询所有入仓污泥块记录");
		}
		else if (inOutFlag==1){
			log.info("查询所有出仓污泥块记录");
		}
		else if (inOutFlag==2){
			log.info("查询所有未入仓污泥块记录");
		}
		else if (inOutFlag==3){
			log.info("所有种类");
		}
		System.out.println(minorWareHouseId+"号");
		List<Sludge> sludges=new ArrayList<Sludge>();
		sludges.addAll(sludgeService.queryAllSludgeByInOutFlagWithMinorWareHouseId(inOutFlag, minorWareHouseId));
		return sludges;
	}
	
	@RequestMapping("deleteSludge")
	@ResponseBody
	public Result deleteSludge(@RequestParam("sludgeId") int sludgeId){
		log.info("删除污泥块");
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
		log.info("新增出仓污泥块记录");
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
		log.info("调用修改污泥块方法");
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
		log.info("调用querySludgeBySiteIdAndInOutFlag");
		int siteId=map.get("siteId");
		int inOutFlag=map.get("inOutFlag");
		int minorWareHouseId=map.get("minorWareHouseId");
		log.info("要查询的siteId:"+map.get("siteId"));
		
		List<Sludge> sludges=sludgeService.querySludgeBySiteIdAndInOutFlagWithMinorWareHouseId(siteId, inOutFlag, minorWareHouseId);
		return sludges;	
	}
	
	
	
	@RequestMapping("querySludgeByDriverId")
	@ResponseBody
	public List<Sludge> querySludgeByDriverId(@RequestParam("driverId") int driverId){
		log.info("调用querySludgeByDriverId");
		List<Sludge> sludges=sludgeService.querySludgeByDriverId(driverId);
		return sludges;
	}
	
	@RequestMapping("querySludgeByDriverIdAndInOutFlag")
	@ResponseBody
	public List<Sludge> querySludgeByDriverIdAndInOutFlag(@RequestBody Map<String, Integer> map){
		log.info("调用querySludgeByDriverIdAndInOutFlag");
		int driverId=(int) map.get("driverId");
		int inOutFlag=(int) map.get("inOutFlag");
		int minorWareHouseId=map.get("minorWareHouseId");
		List<Sludge> sludges=sludgeService.querySludgeByDriverIdAndInOutFlagWithMinorWareHouseId(driverId,inOutFlag,minorWareHouseId);
		return sludges;
	}
	
	@RequestMapping("querySludgeByDateAndInOutFlag")
	@ResponseBody
	public List<Sludge> querySludgeByDateAndInOutFlag(@RequestBody Map<String, String> map){
		log.info("调用querySludgeByDateAndInOutFlag");
		String startDate=map.get("startDate");
		String endDate=map.get("endDate");
		int inOutFlag=Integer.valueOf(map.get("inOutFlag"));
		int minorWareHouseId=Integer.valueOf(map.get("minorWareHouseId"));
		List<Sludge> sludges=sludgeService.querySludgeByDateAndInOutFlagWithMinorWareHouseId(startDate, endDate, inOutFlag,minorWareHouseId);
		return sludges;
	}
	
	@RequestMapping("jumpToSludgeOfOneFactory")
	public ModelAndView querySludgeFunctionsAndJumpToSludgeOfOneFactroy(@RequestParam("siteId") int siteId,ModelAndView mv){
		log.info("调用进入sludge.jsp的方法");
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
		log.info("调用queryAllSludgeOfOneFactory");
		return sludgeService.queryAllSludgeOfOneFactory(site.getId());
	}
	
	@RequestMapping("querySludgeByDriverIdOfOneFactory")
	@ResponseBody
	public  List<Sludge> querySludgeByDriverIdOfOneFactory(@RequestBody Map<String, Integer> condition){
		log.info("调用querySludgeByDriverIdOfOneFactory");
		return sludgeService.querySludgeByDriverIdOfOneFacotry(condition);	
	}
	
	@RequestMapping("querySludgeByDateOfOneFactory")
	@ResponseBody
	public List<Sludge> querySludgeByDateOfOneFactory(@RequestBody Map<String,Object> condition){
		log.info("调用querySludgeByDateOfOneFactory");
		for(Map.Entry<String, Object> entry:condition.entrySet()){
			System.out.print(entry.getKey()+"   "+entry.getValue());
		}
		return sludgeService.querySludegByDateOfOneFactory(condition);
	}

}
