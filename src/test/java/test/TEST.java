package test;

import org.springframework.beans.factory.annotation.Autowired;

import factory.dao.UserDao;

public class TEST extends BaseTest{
	@Autowired
	private static UserDao userDao;
	public static void main(String agrs[]) {
		System.out.println(userDao);
	}

}
