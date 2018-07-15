package factory.controller;

import factory.entity.Site;
import factory.entity.User;
import factory.enums.Result;
import factory.exception.DataNoneException;
import factory.service.SiteService;
import factory.service.UserService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "system")
public class StaffController {
	@Autowired
	private UserService userService;
	
	@Autowired
	private SiteService siteService;

	private static Log log = LogFactory.getLog(StaffController.class);

	@RequestMapping("/jumpToStaff")
	public ModelAndView queryAllStaff(ModelAndView mv) {
		log.info("调用查询人员的方法");
		List<User> users = userService.queryAllUser();
		List<Site> sites= siteService.queryAllSite();
		mv.addObject("userList", users);// 设置需要返回的值
		mv.addObject("siteList", sites);// 设置需要返回的值
		mv.setViewName("system/staffManageCardStyle"); // 跳转到指定的页面
		return mv; // 返回到staffManage.jsp页面
	}

	@RequestMapping("queryAllUser")
	@ResponseBody
	public List<User> queryAllUser() {
		log.info("调用queryAllUser");
		List<User> user = userService.queryAllUser();
		return user;
	}

	@RequestMapping("fuzzyQueryUser")
	@ResponseBody
	public List<User> fuzzyQueryUser(@RequestParam("queryStr") String queryStr) {
		log.info("调用 fuzzyQueryUser:" + queryStr);
		List<User> user = userService.fuzzyQueryUser(queryStr);
		return user;
	}

	@RequestMapping("queryUserByCheckStatus")
	@ResponseBody
	public List<User> queryUserByCheckStatus(@RequestParam("checkStatus") int checkStatus) {
		log.info("调用 queryUserByCheckStatus:" + checkStatus);
		return userService.queryUserByCheckStutas(checkStatus);
	}
	
	@RequestMapping("queryUserByRoleId")
	@ResponseBody
	public List<User> queryUserByRoleId(@RequestParam("roleId") int roleId) {
		log.info("调用 queryUserByRoleId:" + roleId);
		return userService.queryUserByRoleId(roleId);
	}

	@RequestMapping("queryUserByUserName")
	@ResponseBody
	public User queryUserByUsername(@RequestParam("username") String username, Model model) {
		log.info("调用 queryUserByUserName");
		User user = userService.queryUserByUsername(username);
		return user;
	}

	@RequestMapping("queryUserByRealName")
	@ResponseBody
	public User queryUserByRealName(@RequestParam("realname") String realname, Model model) {
		log.info("调用 queryUserByRealName");
		User user = userService.queryUserByUsername(realname);
		return user;
	}

	@RequestMapping("deleteUserByUserId")
	@ResponseBody
	public void deleteUserByUserId(@RequestParam("userId") int userId) {
		log.info("删除用户id=" + userId + "的用户记录");
		userService.deleteUserByUserId(userId);
	}

	@RequestMapping("editUserByUserId")
	@ResponseBody
	public Map<String, String> editUserByUserId(@RequestBody Map<String, Integer> userInfo) {
		Map<String, String> result = new HashMap<String, String>();
		try {
			log.info("修改用户信息" + userInfo.toString());
			userService.editUserByUserId(userInfo);
			log.info("修改用户信息成功");
			result.put("result", "success");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", "failure");
		}
		return result;
	}

	@RequestMapping("checkUserByUserId")
	@ResponseBody
	public void checkUserByUserId(@RequestParam("userId") int userId) {
		log.info("审核通过用户的id=" + userId);
		userService.checkUserByUserId(userId);
	}

	@RequestMapping("checkNUserByUserId")
	@ResponseBody
	public void checkNUserByUserId(@RequestParam("userId") int userId) {
		log.info("审核不通过用户的id=" + userId);
		userService.checkNUserByUserId(userId);
	}

	@RequestMapping("addUser")
	@ResponseBody
	public Map<String, Object> addUser(@RequestBody Map<String, String> userInfo) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			log.info("增加用户信息" + userInfo.toString());
			int userId = userService.addUser(userInfo);
			result.put("id", userId);
			result.put("result", Result.SUCCESS);
		} catch (DataNoneException e) {
			result.put("result", Result.INPUT);
		}catch (DuplicateKeyException e) {
			// TODO: handle exception
			result.put("result", Result.DUPLICATE);
		}
		return result;
	}
	@RequestMapping("resetPassWord")
	@ResponseBody
	public Result resetPassWord(@RequestParam("userId") int userId) {
		
		try {
			userService.resetPassWordByUserId(userId);
			return Result.SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return Result.ERROR;
		}
	}
}
