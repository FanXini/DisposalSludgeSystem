package factory.controller;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import factory.entity.Car;
import factory.entity.Sensor;
import factory.entity.Site;
import factory.entity.Video;
import factory.enums.Result;
import factory.exception.DataNoneException;
import factory.service.SensorService;
import factory.service.VideoService;
import net.sf.json.JSONArray;
@Controller
@RequestMapping("monitor")
public class VideoController {
	@Autowired
	private VideoService videoService;
	
	@Autowired
	private SensorService sensorService;
	
	private static Log log=LogFactory.getLog(VideoController.class);	
	@RequestMapping("/jumpToVideo")
	public ModelAndView queryAllVideo(ModelAndView mv) {
		log.info("调用查询视频的方法");
		List<Video> videos = videoService.queryAllVideo();
		List<Car> cars = videoService.queryCarWhichNotVideo();
		List<Video> videosWithoutCar=videoService.queryVideoWhichNotCar();
		mv.addObject("videoList", videos);// 设置需要返回的值
		mv.addObject("carList", cars);
		mv.addObject("videoWithoutCarList", videosWithoutCar);
		JSONArray carJson = JSONArray.fromObject(cars);
		mv.setViewName("monitor/monitorCard"); // 跳转到指定的页面
		return mv; // 返回到staffManage.jsp页面
	}
	
	@RequestMapping("/jumpToFactoryVideo")
	public ModelAndView queryAllFactoryVideo(ModelAndView mv) {
		log.info("调用查询视频的方法");
		List<Video> videos = videoService.queryAllFactoryVideo();
		List<Site> sites = videoService.querySiteWhichNotVideo();
		JSONArray siteJson = JSONArray.fromObject(sites);
		mv.addObject("videoList", videos);// 设置需要返回的值
		mv.addObject("siteList", sites);
		mv.setViewName("monitor/factorymonitor"); // 跳转到指定的页面
		return mv; // 返回到staffManage.jsp页面
	}
	
	@RequestMapping("/queryAllFactoryVideo")
	@ResponseBody
	public List<Video> queryAllFactoryVideoForWX(){
		List<Video> videos = videoService.queryAllFactoryVideo();
		return videos;
	}
	
	
	@RequestMapping("queryAllVideo")
	@ResponseBody
	public List<Video> queryAllVideo() {
		log.info("调用queryAllVideo");
		List<Video> video=videoService.queryAllVideo();
		return video;
	}
	
	@RequestMapping("addVideo")
	@ResponseBody
	public Video addVideo(@RequestBody Video videoInfo) {
		/*log.info("增加监控");
			log.info("车牌号："+videoInfo.getCarId()+" 摄像头编号："+videoInfo.getSerialNumber()+" 高清地址："+videoInfo.getVideoHLSid()+" 标清地址："+videoInfo.getVideoRTMPid());*/
		log.info("增加监控");
		log.info("车牌号："+videoInfo.getLicense()+" 摄像头编号："+videoInfo.getSerialNumber()+" 高清地址："+videoInfo.getVideoHLSid()+" 标清地址："+videoInfo.getVideoRTMPid());	
		videoService.addVideo(videoInfo);
		return videoInfo;  
	}
	
	@RequestMapping("deletevideo")
	@ResponseBody
	public Result deleteVideo(@RequestParam("videoId") int videoId) {
		log.info("调用删除video");
		/*Map<String, Result> result = new HashMap<String, Result>();*/
		try {
			videoService.deleteVideo(videoId);
			return Result.SUCCESS;
		} catch (Exception e) {
			// TODO: handle exception
			return Result.ERROR;
		}
	}
	
	@RequestMapping("editVideo")
	@ResponseBody
	public Result editVideo(@RequestBody Video video) {
		log.info("调用修改监控信息的方法");
		log.info(video.getId() + " " + video.getLicense() + " " + video.getSerialNumber());
		try {
			videoService.editVideo(video);
			return Result.SUCCESS;
		} catch (DuplicateKeyException e) {
			// TODO: handle exception
			return Result.DUPLICATE;
		} catch (DataNoneException e) {
			return Result.INPUT;
		} catch (Exception e) {
			// TODO: handle exception
			return Result.ERROR;
		}
	}
	
	@RequestMapping("queryVideoByserial_number")
	@ResponseBody
	public Video queryVideoByserial_number(@RequestParam("serialNumber") String serialNumber, Model model) {
		log.info("调用queryVideoByserial_number");
		Video video = videoService.queryVideoByserial_number(serialNumber);
		return video;
	}
	
	@RequestMapping("queryCarWhichNotVideo")
	@ResponseBody
	public List<Car> queryCarWhichNotVideo(){
		log.info("queryCarWhichNotvideo");
		return videoService.queryCarWhichNotVideo();
	}
	
	@RequestMapping("queryVideoWhichNotCar")
	@ResponseBody
	public List<Video> queryVideoWhichNotCar(){
		log.info("queryVideoWhichNotCar");
		return videoService.queryVideoWhichNotCar();
	}
	@RequestMapping("fuzzyqueryVideoByCarLicense")
	@ResponseBody
	public List <Video> fuzzyqueryVideoByCarLicense(@RequestParam("license") String license, Model model) {
		log.info("调用fuzzyqueryVideoByCarLicense");
		List<Video> videos = videoService.fuzzyqueryVideoByCarLicense(license);
		return videos;
	}
	
	
	@RequestMapping("queryVideoByCarLicense")
	@ResponseBody
	public Video queryVideoByCarLicense(@RequestParam("license") String license, Model model) {
		log.info("调用queryVideoByCarLicense");
		Video video = videoService.queryVideoByCarLicense(license);
		return video;
	}
	
	@RequestMapping("queryVideoByDriverId")
	public ModelAndView queryVideoByDriverId(@RequestParam ("driverId") int driverId,ModelAndView mv) {
		log.info("queryVideoByDriverId");
		System.out.println(driverId);
		Video video=videoService.queryVideoByDriverId(driverId);
		List<Sensor> sensors = sensorService.querySensorsByDriverId(driverId);
		mv.addObject("video",video);
		mv.addObject("sensorList", sensors);// 设置需要返回的值
		mv.setViewName("monitor/monitorOfOneCar");
		
		return mv;
	}
	
	@RequestMapping("queryVideoAndSensorByCarId")
	public ModelAndView queryVideoAndSensorByCarId(@RequestParam ("carId") int carId,ModelAndView mv) {
		log.info("queryVideoAndSensorByCarId");
		Video video=videoService.queryVideoByCarId(carId);
		List<Sensor> sensors = sensorService.querySensorsByCarId(carId);
		mv.addObject("video",video);
		mv.addObject("sensorList", sensors);// 设置需要返回的值
		mv.setViewName("monitor/monitorOfOneCar");
		return mv;
	}
	
	@RequestMapping("/queryVideoAndSensorByCarIdfoForWX")
	@ResponseBody
	public Map<String, Object> queryVideoAndSensorByCarIdfoForWX(@RequestParam ("carId") int carId){
		Map<String,Object> requestMap = new HashMap<String,Object>();
		Video video=videoService.queryVideoByCarId(carId);
		List<Sensor> sensors = sensorService.querySensorsByCarId(carId);
		requestMap.put("video", video);
		requestMap.put("sensorList", sensors);
		return requestMap;
	}
	
	@RequestMapping("addFactoryVideo")
	@ResponseBody
	public Video addFactoryVideo(@RequestBody Video videoInfo) {
		/*log.info("增加监控");
			log.info("车牌号："+videoInfo.getCarId()+" 摄像头编号："+videoInfo.getSerialNumber()+" 高清地址："+videoInfo.getVideoHLSid()+" 标清地址："+videoInfo.getVideoRTMPid());*/
		log.info("增加监控");
		log.info("站点ID"+videoInfo.getSiteId()+"污泥处理厂名："+videoInfo.getLicense()+" 摄像头编号："+videoInfo.getSerialNumber()+" 高清地址："+videoInfo.getVideoHLSid()+" 标清地址："+videoInfo.getVideoRTMPid());	
		videoService.addFactoryVideo(videoInfo);
		return videoInfo;  
	}
	
	@RequestMapping("querySiteWhichNotVideo")
	@ResponseBody
	public List<Site> querySiteWhichNotVideo(){
		log.info("querySiteWhichNotVideo");
		return videoService.querySiteWhichNotVideo();
	}
	
	@RequestMapping("/queryFactoryVideoBySiteId")
	public ModelAndView queryFactoryVideoBySiteId(@RequestParam ("siteId") int siteId,ModelAndView mv) {
		log.info("调用查询视频的方法");
		log.info(siteId);
		Video video = videoService.queryFactoryVideoBySiteId(siteId);		
		mv.addObject("video",video);// 设置需要返回的值		
		mv.setViewName("monitor/monitorOfOneFactory"); // 跳转到指定的页面
		return mv; // 返回到staffManage.jsp页面
	}	
	@RequestMapping("editFactoryVideo")
	@ResponseBody
	public Result editFactoryVideo(@RequestBody Video video) {
		log.info("调用修改监控信息的方法");
		log.info(video.getId() + " " + video.getSiteId() + " " + video.getSerialNumber());
		try {
			videoService.editFactoryVideo(video);
			return Result.SUCCESS;
		} catch (DuplicateKeyException e) {
			// TODO: handle exception
			return Result.DUPLICATE;
		} catch (DataNoneException e) {
			return Result.INPUT;
		} catch (Exception e) {
			// TODO: handle exception
			return Result.ERROR;
		}
	}
	@RequestMapping("queryFactoryVideoBySiteName")
	@ResponseBody
	public Video queryFactoryVideoBySiteName(@RequestParam("license") String license, Model model) {
		log.info("调用queryFactoryVideoBySiteName");
		Video video = videoService.queryFactoryVideoBySiteName(license);
		return video;
	}
	
}
