package factory.controller;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
import factory.enums.Result;
import factory.exception.DataNoneException;
import factory.service.VideoService;
import net.sf.json.JSONArray;
@Controller
@RequestMapping("monitor")
public class VideoController {
	@Autowired
	private VideoService videoService;
	
	private static Log log=LogFactory.getLog(VideoController.class);	
	@RequestMapping("/jumpToVideo")
	public ModelAndView queryAllVideo(ModelAndView mv) {
		log.info("���ò�ѯ��Ƶ�ķ���");
		List<Video> videos = videoService.queryAllVideo();
		List<Car> cars = videoService.queryCarWhichNotVideo();
		List<Video> videosWithoutCar=videoService.queryVideoWhichNotCar();
		mv.addObject("videoList", videos);// ������Ҫ���ص�ֵ
		mv.addObject("carList", cars);
		mv.addObject("videoWithoutCarList", videos);
		JSONArray carJson = JSONArray.fromObject(cars);
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
		/*log.info("���Ӽ��");
			log.info("���ƺţ�"+videoInfo.getCarId()+" ����ͷ��ţ�"+videoInfo.getSerialNumber()+" �����ַ��"+videoInfo.getVideoHLSid()+" �����ַ��"+videoInfo.getVideoRTMPid());*/
		log.info("���Ӽ��");
		log.info("���ƺţ�"+videoInfo.getLicense()+" ����ͷ��ţ�"+videoInfo.getSerialNumber()+" �����ַ��"+videoInfo.getVideoHLSid()+" �����ַ��"+videoInfo.getVideoRTMPid());	
		videoService.addVideo(videoInfo);
		return videoInfo;  
	}
	
	@RequestMapping("deletevideo")
	@ResponseBody
	public Result deleteVideo(@RequestParam("videoId") int videoId) {
		log.info("����ɾ��video");
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
		log.info("�����޸ļ����Ϣ�ķ���");
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
		log.info("����queryVideoByserial_number");
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
	
	/*@RequestMapping("queryVideoWhichNotCar")
	@ResponseBody
	public List<Video> queryVideoByCarLicense(){
		log.info("queryVideoByCarLicense");
		return videoService.queryVideoByCarLicense();
	}*/
	
}
