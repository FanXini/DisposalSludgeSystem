package factory.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/main")
public class JspJumps {
	/**
	 * @description:跳转到analyse文件夹中的jsp
	 */
	@RequestMapping("analyse/{formName}")
	public String loginForm(@PathVariable String formName){
		return "analyse/"+formName;
	}
	
	@RequestMapping("map/{formName}")
	public String mapForm(@PathVariable String formName){
		return "map/"+formName;
	}
	
	@RequestMapping("monitor/{formName}")
	public String monitorForm(@PathVariable String formName){
		return "monitor/"+formName;
	}
	
	@RequestMapping("record/{formName}")
	public String recordForm(@PathVariable String formName){
		return "record/"+formName;
	}
	
	@RequestMapping("system/{formName}")
	public String deviceForm(@PathVariable String formName){
		return "system/"+formName;
	}

}
