package factory.controller;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.runners.Parameterized.Parameter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import factory.entity.Car;
import factory.entity.Site;
import factory.entity.User;
import factory.entity.Video;
import factory.service.CarService;
import factory.service.VideoService;
@Controller
@RequestMapping("monitor")
public class VideoController {
	@Autowired
	private VideoService videoService;
	@Autowired
	private CarService carService;
	private static Log log=LogFactory.getLog(VideoController.class);	
	@RequestMapping("/jumpToVideo")
	public ModelAndView queryAllVideo(ModelAndView mv) {
		log.info("调用查询视频的方法");
		List<Video> videos = videoService.queryAllVideo();
		mv.addObject("videoList", videos);// 设置需要返回的值
		mv.setViewName("monitor/monitorCard"); // 跳转到指定的页面
		return mv; // 返回到staffManage.jsp页面
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
		log.info("增加监控");
			log.info("车辆编号："+videoInfo.getCar_id()+"车牌号："+videoInfo.getLicense()+" 摄像头编号："+videoInfo.getSerial_number()+" 高清地址："+videoInfo.getVideo_HLSid()+" 标清地址："+videoInfo.getVideo_RTMPid());
			videoService.addVideo(videoInfo);
		return videoInfo;  
	}	
	@RequestMapping("editVideo")
	@ResponseBody
	public Map<String, String> editVideo(@RequestBody Map<String, String> videoInfo) {
		log.info("编辑监控");
		Map<String, String> result = new HashMap<String, String>();
		try {
			log.info(videoInfo.toString());
			videoService.editVideo(videoInfo);
			result.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result.put("result", "failure");
		}
		return result;
	}
	
	@RequestMapping("querycarWithoutVideo")
	@ResponseBody
	public List<Car> querycarWithoutVideo() {
		log.info("调用querycarWithoutVideo");
		List<Car> querycarWithoutVideo=carService.querycarWithoutVideo();
		return querycarWithoutVideo;
	}
	
	@RequestMapping("queryVideoByDriverId")
	public ModelAndView queryVideoByDriverId(@RequestParam ("driverId") int driverId,ModelAndView mv) {
		log.info("queryVideoByDriverId");
		System.out.println(driverId);
		Video video=videoService.queryVideoByDriverId(driverId);
		mv.addObject("video",video);
		mv.setViewName("monitor/monitorOfOneCar");
		return mv;
	}
}
