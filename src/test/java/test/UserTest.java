package test;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import factory.dao.UserDao;
import factory.entity.User;



public class UserTest extends BaseTest{
	@Autowired
	private UserDao userDao;
	
	@Test
	public void hah() {
		List<User> driver=userDao.queryTransDriverServeOneFactory(53);
		for(User user:driver) {
			System.out.println(user.getRealname());
		}
	}
	
	@Test
	public  void test(){
		String username="fanxin";
		User user=userDao.queryUserByUsername(username);
		/*System.out.println(user.getUsername()+" "+user.getPassword());*/
		
	}
	
	@Test
	public void queryAllUser(){
		List<User> drivers=userDao.queryCarAssignTranSportDriver();
		for(User driver:drivers){
			System.out.println(driver.getId()+" "+driver.getRealname()+" "+driver.getCar().getId());
		}
	}
	/*@Test
	public void queryUserIdByRealName(){
		
	}*/
	
	@Test
	public void queryAllManager(){
		System.out.println("testManage");
		List<User> managers=userDao.queryAllManager();
		for(User manager:managers){
			System.out.print(manager.getUsername());
		}
	}
}

