package factory.dao;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import factory.entity.Video;
public interface VideoDao {
	public List<Video> queryAllVideo();
	//public int count queryAllVideoNumber();
	public int queryVideoCount ();
	public void addVideo(Video video);
	public void editVideo(Video video);
	public Video queryVideoByDriverId(@Param("driverId") int driverId);
}