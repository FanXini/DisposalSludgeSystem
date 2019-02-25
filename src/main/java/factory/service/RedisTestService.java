package factory.service;

import factory.entity.User;

public interface RedisTestService {
	public User getUserInfo(String username);

	public void deleteUser(String username);

	public User updateUser(User user);

}
