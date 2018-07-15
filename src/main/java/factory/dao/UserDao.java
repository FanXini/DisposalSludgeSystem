package factory.dao;

import factory.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDao{
	public User queryUserByUsername(String username);

	public User queryUserByUserId(@Param("userId") int userId);

	public User queryUserByRealName(@Param("realname") String realname);

	public void registerUser(User user);

	public List<User> queryAllDriver();
	
	public List<User> queryUserByCheckStutas(@Param("checkStatus") int checkStatus);

	public List<User> queryNoCarAssignedDriver();
	
	public List<User> queryCarAssignedDriver();

	public List<User> queryDriverServeOneFactory(@Param("siteId") int siteId);

	public int modifyPasswordByUsername(User user);

	public void updateUserInfo(User user);

	public void addUserByRealName(User user);

	public List<User> queryAllManager();

	public User queryManagerByRealName(User user);

	public List<User> queryAllUser();

	public List<User> fuzzyQueryUser(@Param("queryStr") String queryStr);

	public void delectUser(@Param("userId") int userId);

	public void deleteUserByUserId(@Param("userId") int userId);

	public void editUserByUserId(User user);

	public void checkUserByUserId(@Param("userId") int userId);

	public void checkNUserByUserId(@Param("userId") int userId);

	public void addUser(User user);
	
	public void resetPassWordByUserId(@Param("userId") int userId);
	
	public List<User> queryUserByRoleId(@Param("roleId") int roleId);
	

	public List<User> queryAllManagerSiteNull();

	public List<User> queryAllManagerBySiteId(@Param("siteId") String siteId);
	
	public List<User> queryDriverUnassign();
	
}
