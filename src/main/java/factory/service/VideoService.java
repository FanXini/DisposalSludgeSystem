package factory.service;
import java.util.List;
import java.util.Map;
import factory.entity.Video;
public interface VideoService {	
	public List<Video> queryAllVideo();
	public int queryVideoCount ();
	public void editVideo(Map<String, String> videoInfo);
	public void addVideo(Video videoInfo);
}
