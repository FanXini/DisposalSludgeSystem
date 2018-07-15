package test;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import factory.dao.CarDao;
import factory.entity.Car;
import factory.entity.Record;

public class CarTest extends BaseTest{
	@Autowired
	private  CarDao carDao;
	private List<Car> carList;
	/*@Test
	public void test(){
		carList=carDao.queryAllCar();
		System.out.println(carList.size());
		for(Car car:carList){
			System.out.println(car.getDriver().getRealname());
		}
	}*/
	
	/*@Test
	public void addCar (){
		Car car=new Car();
		car.setLicense("haha");
		car.setBrand("none");
		car.setDriverId(-1);
		carDao.addCar(car);
		System.out.println(car.getId());
	}*/
	
	/*@Test
	public  void fuzzyQueryCar(){
		List<Car> carWithDriver=carDao.fuzzyQueryCarWithDriver("ÏæA");
		for(Car car:carWithDriver){
			System.out.println(car.getLicense()+"  "+car.getDriver().getRealname());
		}
		
		List<Car> carWithNoDriver=carDao.fuzzyQueryCarWithNoDriver("ÏæA");
		for(Car car:carWithNoDriver){
			System.out.println(car.getLicense());
		}
	}*/
	
	public static void main(String argrs[]){
		List<Integer> list=new ArrayList<Integer>();
		List<Integer> list2=new ArrayList<Integer>();
		list2.add(1);
		List<Integer> list3=new ArrayList<Integer>();
		list3.add(1);
		list.addAll(list2);
		list.addAll(list3);
		for(Integer num:list){
			System.out.println(num);
		}
	}
	
	@Test
	public void queryCarByLicense(){
		Car car=carDao.queryCarByLicense("ÏæA56723");
		System.out.println(carList.size());
		
	}
	
	@Test
	public void queryCarByStatus(){
		carList=carDao.queryCarByStatus(1);
		System.out.println(carList.size());
		for(Car car:carList)
		{
			System.out.println(car.getBrand());
		}
	}

}
