package factory.serviceimpl;

import factory.dao.CarDao;
import factory.dao.UserDao;
import factory.entity.User;
import factory.exception.AuditIngException;
import factory.exception.DataNoneException;
import factory.exception.LoginInfoErrorException;
import factory.exception.RefuseLoginException;
import factory.service.RedisTestService;
import factory.service.UserService;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static org.hamcrest.CoreMatchers.nullValue;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserDao userDao;

	@Autowired
	private CarDao carDao;
	private static Log log = LogFactory.getLog(UserServiceImpl.class);

	@Override
	public User queryUserByUsername(String username) {
		return userDao.queryUserByUsername(username);
	}
	

	/**
	 * 注册用户
	 */
	@Override
	public void registerUser(User user) {
		userDao.registerUser(user);

	}

	/**
	 * 查询所有司机
	 */
	@Override
	public List<User> quertAllDriver() {

		return userDao.queryAllDriver();
	}

	/**
	 * 通过真实姓名查询用户
	 */
	@Override
	public User queryUserByRealName(String realname) {
		// TODO Auto-generated method stub
		return userDao.queryUserByRealName(realname);
	}

	@Override
	public void deleteUser(Map<String, Integer> deleteUserInfo) {
		int sensorId = deleteUserInfo.get("userId");
		System.out.println(sensorId);
		userDao.delectUser(sensorId);
	}

	@Override
	public List<User> queryTreatDriverServeOneFactory(int siteId) {
		List<User> drivers = new ArrayList<User>();
		drivers.addAll(userDao.queryTreatDriverServeOneFactory(siteId));
		return drivers;
	}
	
	@Override
	public List<User> queryTransDriverServeOneFactory(int siteId) {
		List<User> drivers = new ArrayList<User>();
		drivers.addAll(userDao.queryTransDriverServeOneFactory(siteId));
		return drivers;
	}

	// 判断用户是否存在
	public boolean isUserExist(String username) {
		if (userDao.queryUserByUsername(username) == null) {
			return false;
		} else {
			return true;
		}
	}

	// 根据提供的用户名拿密码
	public String getPasswordByUsername(String username) {
		return userDao.queryUserByUsername(username).getPassword();
	}

	@Override
	public Map<String, String> modifyPasswordByUsername(Map<String, Object> userMap) {
		Map<String, String> result = new HashMap<String, String>();
		int userId = (int) userMap.get("userId");
		String originPwd = String.valueOf(userMap.get("originPwd"));
		String newPwd = String.valueOf(userMap.get("newPwd"));
		User user = userDao.queryUserByUserId(userId);
		System.out.print("原始用户密码" + user.getPassword());
		if (user.getPassword().equals(originPwd)) {
			user.setPassword(newPwd);
			userDao.modifyPasswordByUsername(user);
			result.put("msg", "success");
		} else {
			result.put("msg", "error");
		}

		System.out.print(result);
		return result;
	}

	@Override
	public List<User> queryAllManager() {
		// TODO Auto-generated method stub
		return userDao.queryAllManager();
	}

	@Override
	public void updateUserInfo(User user) {
		userDao.updateUserInfo(user);
	}

	@Override
	public User queryUserByUserId(int userId) {
		// TODO Auto-generated method stub
		return userDao.queryUserByUserId(userId);
	}

	@Override
	//@Cacheable(value="user",key="'allUser'")
	public List<User> queryAllUser() {
		return userDao.queryAllUser();
	}

	@Override
	public List<User> fuzzyQueryUser(String queryStr) {
		System.out.println("query str is:" + queryStr);
		return userDao.fuzzyQueryUser(queryStr);
	}

	@Override
	//@CacheEvict(value="user",key="'allUser'")
	public void deleteUserByUserId(int userId) {
		// TODO Auto-generated method stub
		userDao.deleteUserByUserId(userId);
	}

	@Override
	//@CacheEvict(value="user",key="'allUser'")
	public void editUserByUserId(Map<String, Integer> userInfo) {
		// TODO Auto-generated method stub
		User user = new User();
		int userId = userInfo.get("userId");
		int roleId = userInfo.get("roleId");
		int siteId = userInfo.get("siteId");
		int carId = userInfo.get("carId");
		if (roleId == 2) {// 工厂
			user.setId(userId);
			user.setSiteId(siteId);
			userDao.editUserByUserId(user);
		} else if (roleId == 3) { // 司机
			if (carId != 0) {
				carDao.setDriverIdToNUll(userId);//先把之前分配的车的司机置为NULL
				carDao.updateDriverId(carId, userId);
			}
			else{ //为0说明不为司机分配车辆
				carDao.setDriverIdToNUll(userId);
			}
		}
	}

	@Override
	//@CacheEvict(value="user",key="'allUser'")
	public void checkUserByUserId(int userId) {
		userDao.checkUserByUserId(userId);
	}

	@Override
	//@CacheEvict(value="user",key="'allUser'")
	public void checkNUserByUserId(int userId) {
		userDao.checkNUserByUserId(userId);
	}

	@Override
	//@CacheEvict(value="user",key="'allUser'")
	public int addUser(Map<String, String> userInfo) {
		// TODO Auto-generated method stub
		String username = userInfo.get("username");
		String password = userInfo.get("password");
		if (username == null || username.equals("") || password == null || password.equals("")) {
			throw new DataNoneException("用户表单信息为空！");
		}
		User user = new User();
		user.setRealname(userInfo.get("realname"));
		user.setUsername(username);
		user.setPassword(password);
		user.setEmail(userInfo.get("email"));
		user.setTelephone(userInfo.get("telephone"));
		user.setRoleId(Integer.valueOf(userInfo.get("roleId")));
		user.setCheckStatus(1);// 管理员增加用户默认审核通过
		userDao.addUser(user);
		return user.getId();
	}

	@Override
	public List<User> queryUserByCheckStutas(int checkStatus) {
		List<User> users = new ArrayList<User>();
		users.addAll(userDao.queryUserByCheckStutas(checkStatus));
		return users;
	}
	@Override
	public List<User> queryCarAssignTranSportDriver(){
		List<User> transportDrivers = new ArrayList<User>();
		transportDrivers.addAll(userDao.queryCarAssignTranSportDriver());
		return transportDrivers;
	}
	
	public List<User> queryCarAssignTranSportDriverInLeisureStatus(){
		List<User> transportDriversInLeisureStatus = new ArrayList<User>();
		transportDriversInLeisureStatus.addAll(userDao.queryCarAssignTranSportDriverInLeisureStatus());
		return transportDriversInLeisureStatus;
	}
	
	@Override
	public List<User> queryCarAssignTreatDriver(){
		List<User> transportDrivers = new ArrayList<User>();
		transportDrivers.addAll(userDao.queryCarAssignTreatDriver());
		return transportDrivers;
	}

	@Override
	public List<User> queryNoCarAssignedDriver() {
		List<User> users = new ArrayList<User>();
		users.addAll(userDao.queryNoCarAssignedDriver());
		return users;
	}

	@Override
	public List<User> queryCarAssignedDriver() {
		List<User> drivers = new ArrayList<User>();
		drivers.addAll(userDao.queryCarAssignedDriver());
		return drivers;
	}

	@Override
	public void register(User user) {
		if (user.getUsername() == null || user.getUsername().length() == 0 || user.getPassword() == null
				|| user.getPassword().length() == 0) {
			throw new DataNoneException("注册用户信息不全");

		}
		User recpUser = userDao.queryUserByUsername(user.getUsername());
		if (recpUser != null) {
			throw new DuplicateKeyException("已经被注册");
		} else {
			if (user.getRoleId() == 3) { // 申请的是司机
				user.setSiteId(0);
			}
			user.setTelephone(user.getUsername());// 手机号码就是用户名
			userDao.registerUser(user);
		}

	}

	@Override
	public User loginValidation(User user) {
		// TODO Auto-generated method stub
		log.info(user.getUsername() + " " + user.getPassword());
		String username = user.getUsername();
		String password = user.getPassword();
		if (username == null || username.equals("") || password == null || password.equals("")) {
			throw new DataNoneException("登陆信息不完善");
		}
		User loginUser = userDao.queryUserByUsername(username);
		if (loginUser != null) {
			System.out.println(loginUser.getUsername());
			if (password.equals(loginUser.getPassword())) {
				if (loginUser.getCheckStatus() == 0) {
					throw new RefuseLoginException("审核不通过,禁止登陆！");
				} else if (loginUser.getCheckStatus() == 2) { // 审核中
					throw new AuditIngException("审核中,暂不能登陆");
				} else {
					if(user.getNickname()!=null||!("").equals(user.getNickname())) {
						userDao.setNickNameToNull(user.getNickname());
						userDao.setNickNameByUserId(loginUser.getId(), user.getNickname());
					}
					return loginUser;
				}
			} else {
				throw new LoginInfoErrorException("密码错误");
			}
		} else {
			throw new LoginInfoErrorException("用户不存在");
		}

	}

	@Override
	public void resetPassWordByUserId(int userId) {
		userDao.resetPassWordByUserId(userId);
		
	}

	@Override
	public List<User> queryUserByRoleId(int roleId) {
		List<User> users=new ArrayList<User>();
		users.addAll(userDao.queryUserByRoleId(roleId));
		return users;
	}

	@Override
	public List<User> queryDriverUnassign() {
		List<User> drivers=new ArrayList<User>();
		drivers.addAll(userDao.queryDriverUnassign());
		for(User user:drivers){
			System.out.println(user.getRealname());
		}
		return drivers;
	}


	@Override
	public User queryUserByNickName(String nickname) {
		return userDao.queryUserByNickName(nickname);
	}


	@Override
	public User queryUserById(int userId) {
		return userDao.queryUserById(userId);
	}


}
