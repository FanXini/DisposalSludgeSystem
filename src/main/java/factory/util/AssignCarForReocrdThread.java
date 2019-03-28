package factory.util;
import java.util.List;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Logger;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.transaction.annotation.Transactional;

import factory.entity.Car;
import factory.entity.Record;
import factory.entity.Site;
import factory.entity.Sludge;
import factory.enums.CarStatus;
import factory.enums.RecordStatus;
import factory.enums.SludgeStatus;
import factory.service.CarService;
import factory.service.RecordService;
import factory.service.SludgeService;

public class AssignCarForReocrdThread implements Runnable{
	
	private RecordService recordService;
	
	private CarService carService;
	
	private SludgeService sludgeService;
	
	private int recordId;
	
	private Site site;
	
	private  RedisTemplate<String, Object> redisTemplate; 
	
	private static Logger log=Logger.getLogger(AssignCarForReocrdThread.class);
	
	public  AssignCarForReocrdThread() {
		// 默认构造器
	}
	public AssignCarForReocrdThread(RedisTemplate<String, Object> redisTemplate,RecordService recordService,CarService carService,SludgeService sludgeService,int recordId,Site site) {
		this.redisTemplate=redisTemplate;
		this.recordService=recordService;
		this.carService=carService;
		this.sludgeService=sludgeService;
		this.recordId=recordId;
		this.site=site;
	}

	@Override
	public void run() {
		//先分配处理车
		assinTreatmentCar();
		//再分配运输车
		assignCarrier();
		
	}
	@Transactional
	public  void assinTreatmentCar() { //如果两个事件同时分配给这个司机怎么办？
		while(true) {
			log.info("开始为事件"+recordId+"分配处理车");
			List<Car> unAssinTreatmentCar=carService.queryTreatmentCarUnassign();
			if(unAssinTreatmentCar.size()!=0) { //如果存在空闲的处理车
				//选择最近的处理车
				Car disPacherTreatmentCar=selectMinDistanceCar(unAssinTreatmentCar);
				//将分配车id存到record记录中
				recordService.insertRecordTreatcar(recordId, disPacherTreatmentCar.getId());
				//修改车的状态为已分配还未出发,并将car的siteId设置为0
				carService.editWorkerCarStatusAndSiteId(disPacherTreatmentCar.getId(), CarStatus.NODEPARTURE.ordinal(), site.getId());
				deleteByPrex("car*");
				log.info("为"+recordId+"：请求分配处理车:"+disPacherTreatmentCar.getId()+" "+disPacherTreatmentCar.getLicense());
				break;
			}
			log.info("暂无空闲处理车,3秒后重新分配");
			try {
				Thread.sleep(3000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}		
		}
	}
	@Transactional
	public void assignCarrier(){
		while(true) {
			log.info("开始为事件"+recordId+"分配运输车");
			List<Car> unAssignCarrier=carService.queryCarrierUnassign();
			if(unAssignCarrier.size()!=0) { //如果存在空闲的运输车
				Car disPacherCarrier=selectMinDistanceCar(unAssignCarrier);
				log.info("为"+recordId+"：请求 分配运输车:"+disPacherCarrier.getId()+" "+disPacherCarrier.getLicense());
				//修改运输车的状态
				carService.editWorkerCarStatusAndSiteId(disPacherCarrier.getId(), CarStatus.NODEPARTURE.ordinal(), site.getId());
				deleteByPrex("car*");
				//先为sludge绑定recordId
				Sludge sludge=new Sludge();
				sludge.setRecordId(recordId);
				//设置sludge的状态为虚拟状态，还未产出
				sludge.setStatus(SludgeStatus.VIRTUAL.ordinal());
				sludge.setTranscarId(disPacherCarrier.getId());
				sludgeService.addSludge(sludge);
				break;
			}
			log.info("暂为空闲运输车,3秒后重新分配");
			try {
				Thread.sleep(3000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 
	 * @param cars
	 * 根据距离选择最近的车辆
	 * @return
	 */
	public Car selectMinDistanceCar(List<Car> cars) {
		double minDistance = Double.MAX_VALUE;
		Car car = new Car();
		for(int i = 0; i < cars.size();i++){
			double dis = GpsUtil.getDistance(Double.valueOf(site.getLongitude()),Double.valueOf(site.getLatitude()),cars.get(i).getLongitude(),cars.get(i).getLatitude());
			if(dis < minDistance){
				minDistance = dis;
				car = cars.get(i);
			}
		}
		return car;
	}
	
	public void deleteByPrex(String prex) {
        Set<String> keys = redisTemplate.keys(prex);
        for(String key:keys) {
        	redisTemplate.delete(key);
        }
    }


}
