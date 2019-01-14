package factory.service;
import java.util.List;
import java.util.Map;

import factory.entity.Car;
import factory.entity.Video;
public interface VideoService {	
	public List<Video> queryAllVideo();
	public void addVideo(Video videoInfo);
	public void deleteVideo(int videoId); 
	public void editVideo(Video video);
	public Video queryVideoByserial_number(String serialNumber);
	public List<Car> queryCarWhichNotVideo();
	public List<Video> queryVideoWhichNotCar();
	public List<Video> queryVideoByCarLicense();
	public Video queryVideoByDriverId(int driverId);
}
