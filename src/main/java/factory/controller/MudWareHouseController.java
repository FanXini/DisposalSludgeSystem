package factory.controller;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import factory.entity.MudWareHouse;
import factory.service.MudWareHouseService;

@Controller
@RequestMapping("mudWareHouse")
public class MudWareHouseController {

	@Autowired
	private MudWareHouseService mudWareHouseService;
	
	private static Log log = LogFactory.getLog(CarController.class);
	@RequestMapping("jumpTomudwarehouse")
	public String jumpTomudwarehouse() {
		return "mudwarehouse/mudwarehouse";
	}
	@ResponseBody
	@RequestMapping("queryWareHouse")
	public MudWareHouse queryWareHouse(){
		log.info("调用查询智慧工厂的方法");
		return mudWareHouseService.queryWareHouse();
	}
	
}
