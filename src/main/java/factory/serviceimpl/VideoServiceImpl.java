package factory.serviceimpl;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import factory.dao.CarDao;
import factory.dao.VideoDao;
import factory.entity.Site;
import factory.entity.User;
import factory.entity.Video;
import factory.service.VideoService;
@Service
public class VideoServiceImpl implements VideoService {
	@Autowired
	private VideoDao videodao;
	private CarDao cardao;
	public List<Video> queryAllVideo() {
		// TODO Auto-generated method stub
		return videodao.queryAllVideo();
	}
	@Override
	public int queryVideoCount() {
		// TODO Auto-generated method stub
		return videodao.queryVideoCount();
	}
	@Override
	public void editVideo(Map<String, String> videoInfo) {
		// TODO Auto-generated method stub
		Video video=new Video();
		video.setId(Integer.valueOf(videoInfo.get("id")));
		video.setCar_id(Integer.valueOf(videoInfo.get("car_id")));
		video.setSerial_number(videoInfo.get("serial_number"));
		video.setVideo_RTMPid(videoInfo.get("video_RTMPid"));
		video.setVideo_HLSid(videoInfo.get("video_HLSid"));
		video.setDel_status(Integer.valueOf(videoInfo.get("del_status")));
		videodao.editVideo(video);
		
	}
	@Override
	public void addVideo(Video videoInfo) {
		// TODO Auto-generated method stub
		videodao.addVideo(videoInfo);
	}
}
