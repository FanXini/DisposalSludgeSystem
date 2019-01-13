package test;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import factory.dao.CarDao;
import factory.dao.VideoDao;
import factory.entity.Car;
import factory.entity.Video;

public class VideoTest extends BaseTest {
	@Autowired
	private VideoDao videoDao;
	@Autowired
	private CarDao carDao;
/*	@Test
	public void queryAllvideo(){
		List<Video> videos=videoDao.queryAllVideo();
		for(int i=0;i<videos.size();i++)
		{
			System.out.println("*���ƺţ�"+videos.get(i).getCar().getLicense()+"  *������ţ�"+videos.get(i).getCar_id()+"  *����ͷ��ţ�"+videos.get(i).getSerial_number()+"  *���岥�ŵ�ַ��"+videos.get(i).getVideo_HLSid()
					+"  *���岥�ŵ�ַ��"+videos.get(i).getVideo_RTMPid());
		}
	}*/
	@Test
	public void carWithoutVideo(){
		
		List<Car> carWithoutVideo=carDao.querycarWithoutVideo();
		for(int i=0;i<carWithoutVideo.size();i++)
		{
			System.out.println("*������ţ�"+carWithoutVideo.get(i).getId()+"���ƺţ�"+carWithoutVideo.get(i).getLicense());
		}
	}
	/*@Test
	public void queryVideoCount(){
		int n;
		n=videoDao.queryVideoCount();
		System.out.println("����"+n+"����¼");
	
	}*/
	/*@Test
	
	public void addVideo (){
		Video video=new Video();
		video.setCar_id(25);
		video.setLicense("��L45142");
		video.setSerial_number("c0002");
		video.setVideo_HLSid("http://hls.open.ys7.com/openlive/f01018a141094b7fa138b9d0b856507b.m3u8");
		video.setVideo_RTMPid("rtmp://rtmp.open.ys7.com/openlive/f01018a141094b7fa138b9d0b856507b");
		video.setDel_status(0);
		videoDao.addVideo(video);
		System.out.println(video.getId());
	}*/
}
