package factory.util;

import java.util.List;
import java.util.concurrent.Callable;

import factory.dao.CarDao;
import factory.entity.Car;

//调度车辆的线程
public class AssignCarThread implements Callable<List<Car>>{

	private CarDao carDao;
	private int carType; //0表示处理车，1表示运输车
	
	public AssignCarThread() {
		
	}
	
	public AssignCarThread(CarDao carDao,int carType) {
		this.carDao=carDao;
		this.carType=carType;
	}
	
	@Override
	public List<Car> call() throws Exception {
		System.out.println("调用车辆调度算法");
		if(carType==0) {
			while(true) { //查询空闲污泥处理车
				List<Car> treatmentCarUnassign=carDao.queryTreatmentCarUnassign();
				if(treatmentCarUnassign.size()!=0) {
					System.out.println("有车");
					return treatmentCarUnassign;
				}
				System.out.println("没车,5秒再次调度");
				Thread.sleep(5000); //5秒调度一次
			}
		}
		else if (carType==1) {  //查询空闲污泥运输车
			while(true) {
				List<Car> transportCarUnassign=carDao.queryCarrierUnassign();
				if(transportCarUnassign.size()!=0) {
					System.out.println("有车");
					return transportCarUnassign;
				}
				System.out.println("没车,5秒后再次调度");
				Thread.sleep(5000); //5秒调度一次
			}
		}
		return null;
	}

	
	public CarDao getCarDao() {
		return carDao;
	}
	public void setCarDao(CarDao carDao) {
		this.carDao = carDao;
	}
	public int getCarType() {
		return carType;
	}
	public void setCarType(int carType) {
		this.carType = carType;
	}


}
