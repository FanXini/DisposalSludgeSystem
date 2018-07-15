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
	public  void test(){
		String username="fanxin";
		User user=userDao.queryUserByUsername(username);
		/*System.out.println(user.getUsername()+" "+user.getPassword());*/
		
	}
	
	@Test
	public void queryAllUser(){
		List<User> drivers=userDao.queryAllDriver();
		for(User driver:drivers){
			System.out.println(driver.getUsername());
		}
	}
	
	/*@Test
	public void queryUserIdByRealName(){
		
	}*/
}

