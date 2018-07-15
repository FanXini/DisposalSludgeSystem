package factory.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
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

@Controller
@RequestMapping("user")
@SessionAttributes("user")
public class UserController {
	private static Log log = LogFactory.getLog(UserController.class);
	@Autowired
	private UserService service;
	
	@Autowired
	private SiteService siteService;
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
					map.put("result", "notverify"); //审核未通过
					return map;
				}else if(queryUser.getCheckStatus()==2){ //审核中
					map.put("result", "verifying");
					return map;
				}else {
					model.addAttribute("user",queryUser); //审核通过
					map.put("result", "success");
					map.put("roleId", String.valueOf(queryUser.getRoleId()));
					return map;
				}				
			} else {
				map.put("result", "error");
				log.info("密码错误");
				return map;
			}
		} else {
			map.put("result", "none");
			log.info("用户名不存在");
			return map;
		}

	}*/
	@RequestMapping(value = "/loginValidator")
	@ResponseBody 
	public Result checkLogin(@RequestBody User user,HttpSession session,Model model){
		try {
			User loginUser=service.loginValidation(user);
			model.addAttribute("user",loginUser);
			List<Integer> roleAutho = role_authorityService.queryAllRole_authority(loginUser.getRoleId());
			session.setAttribute("authos", roleAutho);
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
		//mian.jsp页面获取roleAutho的值
	@RequestMapping("queryAuthosAndJumpToMain")
	public ModelAndView queryAuthosAndJumpToMain(@RequestParam("roleId") int roleId, ModelAndView mv) {
		return mv;
	}
	

	@RequestMapping("/register")
	@ResponseBody
	public Result register(@RequestBody User user) {
		log.info("注册用户");
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
	
	
	//注销
	@RequestMapping("outLogin")
	@ResponseBody
    public String outLogin(HttpSession session){
        //通过session.invalidata()方法来注销当前的session
        session.invalidate();
        return "login";
    }
	
	//修改密码
		@RequestMapping("modifyPwd") 
		@ResponseBody
	    public Map<String, String> modifyPassword(@RequestBody Map<String, Object> userMap) {  
			log.info("调用modifyPwd");
			for(Map.Entry<String, Object> entry:userMap.entrySet()){
				System.out.println(entry.getKey()+"  "+entry.getValue());
			}
			Map<String, String> result=new HashMap<String, String>();
			result.putAll(service.modifyPasswordByUsername(userMap));
			return result;
	    }  
		
	//修改用户信息
	@RequestMapping("modifyUserInfo")
	@ResponseBody
	public User modifyUserInfo(@RequestBody User user,Model model){
		log.info("调用modifyUserIfno");		
		service.updateUserInfo(user);
		model.addAttribute("user",user);
		return user;
	}

	/**
	 * @description:查询所有的司机
	public List<User> queryAllDriver() {
		return service.quertAllDriver();
	}
	
	/**
	 * @description:查询所有工厂人员
	 */
	@RequestMapping("/manager")
	@ResponseBody
	public List<User> queryAllManager() {
		log.info("查询所有工厂人员");
		return service.queryAllManager();
	}
	
	@RequestMapping("queryNoCarAssignedDriverList")
	@ResponseBody
	public List<User> NoCarAssignedDriverList(){
		List<User> driversList=carService.queryNoCarAssignedDriver();
		System.out.println(driversList.size());
		for(User user:driversList){
			System.out.println(user.getRealname());
		}
		return driversList;
	}
}
