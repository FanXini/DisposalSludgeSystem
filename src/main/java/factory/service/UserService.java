package factory.service;

import factory.entity.User;

import java.util.List;
import java.util.Map;

public interface UserService {

	public List<User> queryAllUser();

	public List<User> fuzzyQueryUser(String queryStr);

	public User queryUserByUsername(String username);

	public void registerUser(User user);

	public List<User> quertAllDriver();
	
	public List<User> queryUserByCheckStutas(int checkStatus);

	public User queryUserByRealName(String realname);

	/*public void removdeUser(String name);*/
	public void deleteUser(Map<String, Integer> deleteUserInfo);

	public List<User> queryDriverServeOneFactory(int siteId);

	public Map<String, String> modifyPasswordByUsername(Map<String, Object> userInfo);

	public boolean isUserExist(String username);

	public List<User> queryAllManager();

	public void updateUserInfo(User user);

	public User queryUserByUserId(int userId);

	public void deleteUserByUserId(int userId);

	public void editUserByUserId(Map<String,Integer> userInfo);

	public void checkUserByUserId(int userId);

	public void checkNUserByUserId(int userId);

	public int addUser(Map<String,String> userInfo);
	
	public List<User> queryNoCarAssignedDriver();
	
	public List<User> queryCarAssignedDriver();
	
	public void register(User user);
	
	public User loginValidation(User user);
	
	public void resetPassWordByUserId(int userId);
	
	public List<User> queryUserByRoleId(int roleId);
	
	public List<User> queryDriverUnassign();

}
