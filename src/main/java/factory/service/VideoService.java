package factory.service;
import java.util.List;
import java.util.Map;

import factory.entity.Car;
import factory.entity.Site;
import factory.entity.Video;
public interface VideoService {	
	public List<Video> queryAllVideo();
	public void addVideo(Video videoInfo);
	public void deleteVideo(int videoId); 
	public void editVideo(Video video);
	public Video queryVideoByserial_number(String serialNumber);
	public List<Car> queryCarWhichNotVideo();
	public List<Video> queryVideoWhichNotCar();
	public List<Video> fuzzyqueryVideoByCarLicense(String license);
	public Video queryVideoByCarLicense(String license);
	public Video queryVideoByDriverId(int driverId);
	public Video queryVideoByCarId(int carId);
	
	public List<Video> queryAllFactoryVideo();
	public void addFactoryVideo(Video videoInfo);
	public List<Site> querySiteWhichNotVideo();
	public Video queryFactoryVideoBySiteId(int siteId);
	public void editFactoryVideo(Video video);
	public Video queryFactoryVideoBySiteName(String license);
}
