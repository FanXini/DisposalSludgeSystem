package RedisTest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import factory.config.TestConfig;
import factory.entity.User;
import factory.service.UserService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes=TestConfig.class)
public class RedisTest {
	@Autowired
	private UserService userService;
	@Test
	public void RedisTest() {
		User user=userService.queryUserByUsername("root");
		System.out.println(user.getUsername());
	}

}
