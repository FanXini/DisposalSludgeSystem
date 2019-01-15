package factory.serviceimpl;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import factory.dao.CarDao;
import factory.dao.VideoDao;
import factory.entity.Car;
import factory.entity.Site;
import factory.entity.User;
import factory.entity.Video;
import factory.exception.DataNoneException;
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
	public void addVideo(Video videoInfo) {
		// TODO Auto-generated method stub
		videodao.addVideo(videoInfo);
	}

	public void deleteVideo(int videoId) {
		// TODO Auto-generated method stub
		videodao.deleteVideo(videoId);
	}
	
	@Override
	public void editVideo(Video video) {
		// TODO Auto-generated method stub
		if (video.getSerialNumber().equals("") || video.getSerialNumber() == null) {
			throw new DataNoneException("没有数据");
		}
		videodao.editVideo(video);	
	}
	
	@Override
	public Video queryVideoByserial_number(String serial_number) {
		return videodao.queryVideoByserial_number(serial_number);
	}
	
	@Override
	public List<Car> queryCarWhichNotVideo() {
		List<Car>  cars=new ArrayList<Car>();
		cars.addAll(videodao.queryCarWhichNotVideo());
		return cars;
	}
	
	@Override
	public List<Video> queryVideoWhichNotCar() {
		List<Video>  videos=new ArrayList<Video>();
		videos.addAll(videodao.queryVideoWhichNotCar());
		return videos;
	}
	
	@Override
	public List<Video> fuzzyqueryVideoByCarLicense(String license) {
		List<Video>  videos=new ArrayList<Video>();
		videos.addAll(videodao.fuzzyqueryVideoByCarLicense(license));
		return videos;
	}
	@Override
	public Video queryVideoByCarLicense(String license) {
		return videodao.queryVideoByCarLicense(license);
	}
	
	@Override
	public Video queryVideoByDriverId(int driverId) {
		return videodao.queryVideoByDriverId(driverId);
	}
	
}
