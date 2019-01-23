package test;


import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import factory.dao.VideoDao;
import factory.entity.Car;
import factory.entity.Site;
import factory.entity.Video;

public class VideoTest extends BaseTest {
	@Autowired
	private  VideoDao videoDao;
	private List<Video> videoList;
	private List<Car> carList;
	private List<Site> siteList;
	/**删除监控**/
/*	@Test
	public void addVideo(){
		Video video=new Video();
		video.setId(31);
		video.setCarId(26);
		video.setLicense("豫66666");
		video.setSerialNumber("C0018");
		video.setVideoRTMPid("rtmp://rtmp.open.ys7.com/openlive/c5fca4a038634347a5b856ad89ebc35b.hd");
		video.setVideoHLSid("http://hls.open.ys7.com/openlive/c5fca4a038634347a5b856ad89ebc35b.hd.m3u8");
		video.setDelStatus(0);
		videoDao.addVideo(video);
		System.out.println("新增成功");
	}*/
	/*@Test
	public void deleteVideo( ){		
		videoDao.deleteVideo(15);
		System.out.println("删除成功");
	}
	*/
	/*@Test
	public void editVideo(){
		Video video=new Video();
		video.setId(23);
		video.setSerialNumber("C0012");
		video.setLicense("湘462342");
		videoDao.editVideo(video);		
	}*/
	
	/*@Test
	public void queryVideoByserial_number(){
		Video video=videoDao.queryVideoByserial_number("C0012");
		System.out.println(video.getSerialNumber()+" "+video.getCarId()+" "+video.getLicense());
	}*/
	
	/*@Test
	public void test(){
		carList=videoDao.queryCarWhichNotVideo();
		System.out.println(carList.size());
		for(Car car:carList){
			System.out.println(car.getLicense());
		}
	}*/
	/*@Test
	public void queryVideoByCarLicense(){
		Video video=videoDao.queryVideoByCarLicense("C0012");
		System.out.println(video.getSerialNumber()+" "+video.getCarId()+" "+video.getLicense());
	}*/
/*	
	@Test
	public void queryAllFactoryVideo(){
		List<Video> video=videoDao.queryAllFactoryVideo();
		System.out.println(video.get(0).getSerialNumber());
	}*/
	
	/*@Test
	public void test(){
		siteList=videoDao.querySiteWhichNotVideo();
		System.out.println(siteList.size());
		for(Site site:siteList){
			System.out.println(site.getSiteName());
		}
	}*/
	
	/*	@Test
	public void addFactoryVideo(){
		Video video=new Video();
		video.setSiteId(55);
		video.setLicense("滨河污水处理厂");
		video.setSerialNumber("C29134497");
		video.setVideoRTMPid("rtmp://rtmp.open.ys7.com/openlive/c5fca4a038634347a5b856ad89ebc35b.hd");
		video.setVideoHLSid("http://hls.open.ys7.com/openlive/c5fca4a038634347a5b856ad89ebc35b.hd.m3u8");
		video.setDelStatus(0);
		videoDao.addFactoryVideo(video);
		System.out.println("新增成功");
	}*/
		/*@Test
		public void queryVideoBySiteName(){
			Video video=videoDao.queryVideoBySiteName("湖南大学");
			System.out.println(video.getSerialNumber()+" "+video.getSiteId()+" "+video.getLicense());
		}*/
		
		@Test
		public void queryFactoryVideoBySiteId(){
			Video video=videoDao.queryFactoryVideoBySiteId(1);
			System.out.println(video.getSerialNumber()+" "+video.getSiteId()+" "+video.getLicense());
		}
		
}
