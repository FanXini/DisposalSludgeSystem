package factory.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.scheduling.config.IntervalTask;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import factory.entity.Car;
import factory.entity.Role;
import factory.entity.Site;
import factory.entity.User;
import factory.enums.Result;
import factory.exception.AuditIngException;
import factory.exception.DataNoneException;
import factory.exception.LoginInfoErrorException;
import factory.exception.RefuseLoginException;
import factory.service.CarService;
import factory.service.Role_authorityService;
import factory.service.SiteService;
import factory.service.UserService;
import redis.clients.jedis.JedisPoolConfig;

@Controller
@RequestMapping("user")
@SessionAttributes("user")
public class UserController {
	private static Logger log=Logger.getLogger(UserController.class);
	@Autowired
	private UserService service;
	
	@Autowired
	private Role_authorityService role_authorityService;
	
	@Autowired
	private CarService carService;

	@RequestMapping("private/{formName}")
	public String loginForm(@PathVariable String formName) {
		return "admin/" + formName;
	}

	/*@RequestMapping(value = "/loginValidator")
	@ResponseBody
	public Map<String, String> checkLogin(HttpSession session, @RequestParam("loginUsername") String loginUsername,
			@RequestParam("loginPassword") String loginPassword,Model model) {
		Map<String, String> map = new HashMap<String, String>();
		log.info(loginUsername + " " + loginPassword);
		if (loginUsername == null || loginUsername.length() == 0 || loginPassword == null
				|| loginPassword.length() == 0) {
			map.put("result", "input");
			return map;
		}
		User queryUser = service.queryUserByUsername(loginUsername);
		if (queryUser != null) {
			System.out.println(queryUser.getUsername());
			if (loginPassword.equals(queryUser.getPassword())) {
				if(queryUser.getCheckStatus()==0){
					map.put("result", "notverify"); //���δͨ��
					return map;
				}else if(queryUser.getCheckStatus()==2){ //�����
					map.put("result", "verifying");
					return map;
				}else {
					model.addAttribute("user",queryUser); //���ͨ��
					map.put("result", "success");
					map.put("roleId", String.valueOf(queryUser.getRoleId()));
					return map;
				}				
			} else {
				map.put("result", "error");
				log.info("�������");
				return map;
			}
		} else {
			map.put("result", "none");
			log.info("�û���������");
			return map;
		}

	}*/
	@RequestMapping(value = "/loginValidator")
	@ResponseBody 
	public Result checkLogin(@RequestBody User user,HttpSession session,Model model){
		log.info("loginValidator");
		try {
			User loginUser=service.loginValidation(user);
			model.addAttribute("user",loginUser);
			List<Integer> roleAutho = role_authorityService.queryAllRole_authority(loginUser.getRoleId());
			String authString="";
			for(Integer auth:roleAutho) {
				authString+="au"+auth.toString()+"th#";
			}
			session.setAttribute("authos", authString);
			return Result.SUCCESS;
		} catch (RefuseLoginException e) {
			// TODO: handle exception
			return Result.FORBID;
		}catch (AuditIngException e) {
			// TODO: handle exception
			return Result.AUDING;
		}catch (LoginInfoErrorException e) {
			// TODO: handle exception
			return Result.ERROR;
		}
		
	}
	
	@RequestMapping(value = "/loginValidatorForWx")
	@ResponseBody 
	public Map<String, Object> checkLogin(@RequestBody User user){
		Map<String, Object> result=new HashMap<>();
		log.info("loginValidator");
		try {
			User loginUser=service.loginValidation(user);
			result.put("result", "SUCCESS");
			result.put("user", loginUser);
			List<Integer> roleAutho = role_authorityService.queryAllRole_authority(loginUser.getRoleId());
			result.put("roleList", roleAutho);
			return result;
		} catch (RefuseLoginException e) {
			// TODO: handle exception
			result.put("result", "FORBID");
			return result;
		}catch (AuditIngException e) {
			result.put("result", "AUDING");
			return result;
		}catch (LoginInfoErrorException e) {
			result.put("result", "ERROR");
			return result;
		}
		
	}
		//mian.jspҳ���ȡroleAutho��ֵ
	@RequestMapping("queryAuthosAndJumpToMain")
	public ModelAndView queryAuthosAndJumpToMain(@RequestParam("roleId") int roleId, ModelAndView mv) {
		return mv;
	}
	

	@RequestMapping("/register")
	@ResponseBody
	public Result register(@RequestBody User user) {
		log.info("register");
		log.info(user.getUsername()+" "+user.getPassword()+" "+user.getRoleId()+" "+user.getSiteId());
		try {
			service.register(user);
			return Result.SUCCESS;
		} catch (DuplicateKeyException e) {
			// TODO: handle exception
			e.printStackTrace();
			return Result.DUPLICATE;
		} catch (DataNoneException e) {
			// TODO: handle exception
			e.printStackTrace();
			return Result.INPUT;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return Result.ERROR;
		}
		
	}
	
	
	@RequestMapping("outLogin")
	@ResponseBody
    public String outLogin(HttpSession session){
        session.invalidate();
        return "login";
    }
	
		@RequestMapping("modifyPwd") 
		@ResponseBody
	    public Map<String, String> modifyPassword(@RequestBody Map<String, Object> userMap) {  
			Map<String, String> result=new HashMap<String, String>();
			result.putAll(service.modifyPasswordByUsername(userMap));
			return result;
	    }  
		
	@RequestMapping("modifyUserInfo")
	@ResponseBody
	public User modifyUserInfo(@RequestBody User user,Model model){
		log.info("modifyUserInfo");		
		service.updateUserInfo(user);
		model.addAttribute("user",user);
		return user;
	}

	@RequestMapping("modifyUserInfoForWX")
	@ResponseBody
	public User modifyUserInfo(@RequestBody User user){
		log.info("modifyUserInfoForWX");		
		service.updateUserInfo(user);
		return user;
	}
	
	@RequestMapping("queryUserByUserId")
	@ResponseBody
	public User queryUserByUserId(@RequestParam("userId") int userId){
		log.info("查找userId="+userId+"的用户");
		return service.queryUserByUserId(userId);
	}

	@RequestMapping("/manager")
	@ResponseBody
	public List<User> queryAllManager() {
		log.info("queryAllManager");
		return service.queryAllManager();
	}
	
	@RequestMapping("queryNoCarAssignedDriverList")
	@ResponseBody
	public List<User> NoCarAssignedDriverList(){
		List<User> driversList=carService.queryNoCarAssignedDriver();
		return driversList;
	}
	
	@RequestMapping("/transactionTest")
	@ResponseBody
	public void redisTest() {
		service.testTransaction();
	}
}
