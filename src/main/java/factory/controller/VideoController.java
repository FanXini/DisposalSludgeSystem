package factory.controller;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
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
		log.info("���ò�ѯ��Ƶ�ķ���");
		List<Video> videos = videoService.queryAllVideo();
		mv.addObject("videoList", videos);// ������Ҫ���ص�ֵ
		mv.setViewName("monitor/monitorCard"); // ��ת��ָ����ҳ��
		return mv; // ���ص�staffManage.jspҳ��
	}
	@RequestMapping("queryAllVideo")
	@ResponseBody
	public List<Video> queryAllVideo() {
		log.info("����queryAllVideo");
		List<Video> video=videoService.queryAllVideo();
		return video;
	}	
	@RequestMapping("addVideo")
	@ResponseBody
	public Video addVideo(@RequestBody Video videoInfo) {
		log.info("���Ӽ��");
			log.info("������ţ�"+videoInfo.getCar_id()+"���ƺţ�"+videoInfo.getLicense()+" ����ͷ��ţ�"+videoInfo.getSerial_number()+" �����ַ��"+videoInfo.getVideo_HLSid()+" �����ַ��"+videoInfo.getVideo_RTMPid());
			videoService.addVideo(videoInfo);
		return videoInfo;  
	}	
	@RequestMapping("editVideo")
	@ResponseBody
	public Map<String, String> editVideo(@RequestBody Map<String, String> videoInfo) {
		log.info("�༭���");
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
		log.info("����querycarWithoutVideo");
		List<Car> querycarWithoutVideo=carService.querycarWithoutVideo();
		return querycarWithoutVideo;
	}	
}
