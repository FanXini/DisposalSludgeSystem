package factory.dao;
import java.util.List;
import factory.entity.Site;
import factory.entity.Video;
public interface VideoDao {
	public List<Video> queryAllVideo();
	//public int count queryAllVideoNumber();
	public int queryVideoCount ();
	public void addVideo(Video video);
	public void editVideo(Video video);
}