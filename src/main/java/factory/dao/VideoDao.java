package factory.dao;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import factory.entity.Car;
import factory.entity.Site;
import factory.entity.Video;
public interface VideoDao {
	public List<Video> queryAllVideo();
	public void addVideo(Video video);
	public void deleteVideo(@Param("videoId") int videoId);
	public void editVideo(Video video);
	public Video queryVideoByserial_number(@Param("serialNumber") String serial_number);
	public List<Car> queryCarWhichNotVideo();
	public List<Video> queryVideoWhichNotCar();	
	public List<Video> fuzzyqueryVideoByCarLicense(@Param("license") String license);
	public Video queryVideoByCarLicense(@Param("license") String license);
	public Video queryVideoByDriverId(@Param("driverId") int driverId);
	public Video queryVideoByCarId(@Param("carId") int carId);
	
	public List<Video> queryAllFactoryVideo();
	public void addFactoryVideo(Video videoInfo);
	public List<Site> querySiteWhichNotVideo();
	public Video queryFactoryVideoBySiteId(@Param("siteId") int siteId);
	public void editFactoryVideo(Video video);
	public Video queryVideoBySiteName(@Param("license") String license);
}