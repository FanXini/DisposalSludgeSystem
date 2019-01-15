package factory.controller;


import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import factory.entity.MainMudWareHouse;
import factory.entity.MinorMudWareHouse;
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
	@RequestMapping("queryMinorWareHouse")
	public List<MinorMudWareHouse> queryMinorWareHouse(){
		log.info("调用查询子智慧工厂泥仓的方法");
		return mudWareHouseService.queryMinorWareHouse();
	}
	
	@ResponseBody
	@RequestMapping("queryMainWareHouse")
	public List<MainMudWareHouse> queryMainWareHouse(){
		log.info("调用查询主智慧工厂泥仓的方法");
		return mudWareHouseService.queryMainWareHouse();
	}
	
}
