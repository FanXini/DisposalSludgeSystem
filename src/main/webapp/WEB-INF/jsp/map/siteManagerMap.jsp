<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'map.jsp' starting page</title>

<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf8">

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link rel="shortcut icon" href="favicon.ico">
<link href="css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="css/font-awesome.css?v=4.4.0" rel="stylesheet">

<link href="css/animate.css" rel="stylesheet">
<link href="css/style.css?v=4.1.0" rel="stylesheet">
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=5TmZTw10oplDe4ZehEM6UjnY6rDgocd8"></script>

<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<style type="text/css">
.map {
	position: relative;
	color: #000;
	width: 100%;
	height: 100%;
	overflow: auto;
}

.selectMenu {
	position: absolute;
	right: 20px;
	top: 5px;
}
.select {
    border: 1px solid #555;
    font-family : 微软雅黑;
    color:black;
    font-size: 15px;
    text-align: center;
    line-height: 1.2em;
	float: right;
	background: lavender;
	height:35px;
	width:110px;
}
.query_submit {
	border: 1px solid #555;
    padding: 0.5em;
    font-family : 微软雅黑;
    color:black;
    font-size: 15px;
    line-height: 1.2em;
	float: right;
	background: slateblue;
	height:35px;
	width:80px;
	text-align: center;
	margin:auto auto 5px 10px;
}
.text{
	border: 1px solid #555;
    padding: 0.5em;
    line-height: 1.2em;
	float: right;
	background: white;
	height:35px;
	width:200px;
	margin:auto auto 5px 10px;
}
.bottom_button {
	position: absolute;
	right: 2px;
	bottom: 0px;
}

.tablehead td {
	height: 10px;
	width: 10%;
	text-align: center;
	font-size: 12px;
	font-weight: 700;
	color: #4A708;
}

.tablelist td {
	height: 20px;
	width: 10%;
	text-align: center;
	font-size: 11px;
	font-weight: 600;
	color: #4A708;
}

.tablelist tr {
	cursor: pointer;
}
</style>
</head>

<body>
	<div id="allmap" class="map"></div>
	<div id="selectMenu" class="selectMenu">
			<table class="tb2" height="100%" cellspacing="0" cellpadding="0" width="100%" border="0"
				style=" margin-left: 0px;">
				<tr>
					<td>
						<select id="typeSelect" class="select" style:"">
							<option value="-1">-车辆类型-</option>
							<option value="0">-污泥处理车-</option>
							<option value="1">-污泥运输车-</option>
						</select>
					</td>
					<td><input id="queryStr" type="text" placeholder="" class="text"> <span
						class="input-group-btn"></span>
					</td>
					<td align="center">
						<button type="button" class="query_submit" id="querysubmit">确认</button>
					</td>
				</tr>
			</table>
	</div>
	<div class="bottom_button">
	<ul class="nav navbar-top-links navbar-right">
		<li class="dropdown dropup"><a class="dropdown-toggle count-info" data-toggle="dropdown"
			href="#" onclick="showTreatmentCarTable();"> <i i class="fa fa-truck" style="color:#FFD700"></i> <span class="label label-warning" id="treatmentCarNum"></span> </a>
			<ul class="dropdown-menu dropdown-messages"
					style="background: rgba(176,196,222,0.8);max-height:300px;overflow-y:auto;">
					<li>
							<table class="tablehead" border="0" cellspacing="0" cellpadding="0"
								style="width:100%">
								<tr>
									<td>车牌号</td>
									<td>预计到达</td>
								</tr>
							</table>
					</li>
					<li class="divider"></li>
					<li>
						<table id="treatmentCarTable" class="tablelist" border="0" cellspacing="0" cellpadding="0"
								style="width:100%">
						</table>
					</li>
				</ul>
			</li>
		<li class="dropdown dropup"><a class="dropdown-toggle count-info" data-toggle="dropdown"
			href="#" onclick="showCarrierTable();"> <i class="fa fa-truck" style="color:#4D4D4D""></i> <span id="carrierNum" class="label label-warning"></span> </a>
			<ul class="dropdown-menu dropdown-messages"
					style="background: rgba(176,196,222,0.8);max-height:300px;overflow-y:auto;">
				<li>
					<table class="tablehead" border="0" cellspacing="0" cellpadding="0" style="width:100%">
						<tr>
							<td>车牌号</td>
							<td>预计到达</td>
						</tr>
					</table>
				</li>
				<li class="divider"></li>
				<li>
					<table id="carrierTable" class="tablelist" border="0" cellspacing="0" cellpadding="0"
							style="width:100%">
					</table>
				</li>
			</ul>
		</li>
	</ul>
	</div>
</body>
</html>
<script type="text/javascript">
	var map = new BMap.Map("allmap");
	window.map = map;

	map.addControl(new BMap.NavigationControl()); // 添加平移缩放控件
	map.addControl(new BMap.ScaleControl()); // 添加比例尺控件
	map.addControl(new BMap.OverviewMapControl()); //添加缩略地图控件
	map.enableScrollWheelZoom(); //启用滚轮放大缩小
	//	map.addControl(new BMap.MapTypeControl());          //添加地图类型控件
	map.disable3DBuilding();
	map.centerAndZoom("深圳市", 11);
	map.setMapStyle({
		style : 'light'
	}); //设置地图样式
	var siteMarker;
	var sitePoint;
	var siteInfoWindow;
	var carMarker = new Array();
	var carPoint = new Array();
	var carInfoWindow = new Array();
	var siteId=${sessionScope.user.siteId};
	var carStatus=-1;
	
	show()
  	setInterval("show()",3000);  //定时刷新map
	
  	function show(){
  		showMap(siteId,-1,-1);
  		showNum();
  	}
  	
	/***************************** 查询站点信息************************************* */
	function queryMapSite(id){
		var site;
		$.ajax({
  			type : "POST",
  			url : "system/querySiteMapBySiteIdAndStatus",
  			data : {
  				"siteId" : id,
  				"status" : -1,
  			},
			async : false,
  			success : function(result) {
  				if(!jQuery.isEmptyObject(result)){
  					site = result[0];
  				}
  			}
  		});
  		return site;
  	}
	
	/***************************** 查询站点处理进度************************************* */
  	function queryRateOfProcess(id){
  		var rate;
		$.ajax({
  			type : "POST",
  			url : "record/queryRateOfProcessBySiteId",
  			data : "siteId="+id,
			async : false,
  			success : function(result) {
  				rate = result;
  			}
  		});
  		return rate;
  	}
	
	/***************************** 查询站点预处理量************************************* */
  	function queryPretreatAmount(id){
  		var value;
		$.ajax({
  			type : "POST",
  			url : "record/queryCurrentPretreatAmountBySiteId",
  			data : "siteId="+id,
			async : false,
  			success : function(result) {
  				value = result;
  			}
  		});
  		return value;
  	}
  		
  	/***************************** 查询车辆************************************* */
	function queryMapCar(id,carType,status){
		var carList;
		$.ajax({
			type : "POST",
			url : "car/queryMapCarBySiteIdAndCarTypeAndStatus",
			data : {
				"siteId" : id,
				"carType" : carType,
				"status" : status
				},
			async : false,
			success : function(list) {
				carList = list;
			}
		});
		return carList;
	}

	/***************************** 显示标注************************************* */
	function showMap(id,carType,status) {
		map.clearOverlays(); //清除地图上所有覆盖物
		carPoint=[];
		carMarker=[];
		carInfoWindow=[];
		site = queryMapSite(id);
		if(!jQuery.isEmptyObject(site)){
			if (site.status== "0") {
				myIcon = new BMap.Icon("img/factory(green).png", new BMap.Size(100, 70), {
				imageSize : new BMap.Size(100, 70)});
			}else if (site.status== "1") {
				myIcon = new BMap.Icon("img/factory(yellow).png", new BMap.Size(100, 70), {
				imageSize : new BMap.Size(100, 70)});
			} else if (site.status== "2") {
				myIcon = new BMap.Icon("img/factory(red).png", new BMap.Size(100, 70), {
				imageSize : new BMap.Size(100, 70)});
			}
			sitePoint = new BMap.Point(site.longitude,site.latitude);
			siteMarker = new BMap.Marker(sitePoint,{icon:myIcon});
			map.addOverlay(siteMarker);
			if(site.status=="2")
				siteMarker.setAnimation(BMAP_ANIMATION_BOUNCE);
			
			siteMarker.addEventListener("mouseover",function(){
				siteInfo(site);
			});
			
			carList = queryMapCar(id,carType,status);
			$.each(carList,function(i, car) {
				if(car.carType == 0){
					var carIcon = new BMap.Icon("img/car.png", new BMap.Size(35, 24), 
									{imageSize : new BMap.Size(35, 24)});
				}else{
					var carIcon = new BMap.Icon("img/transportCar.png", new BMap.Size(35, 35), 
									{imageSize : new BMap.Size(35, 35)});
					}
				if(car.status==1){
				    carPoint[car.id] = new BMap.Point(car.longitude,car.latitude);
					carMarker[car.id] = new BMap.Marker(carPoint[car.id],{icon:carIcon});
					map.addOverlay(carMarker[car.id]);
					//鼠标悬停动作
					carMarker[car.id].addEventListener("mouseover",function(){
						carInfo(car);
					});
				}
			});
		}
	}
	
	/***************************** 站点信息框显示************************************* */
	function siteInfo(site){
			var opts = {width : 230, }// 信息窗口宽度
			var status;
			if (site.status== "0")
				status="正常";
			else if (site.status== "1")
				status="处理中";
			else if (site.status== "2"){
				$.ajax({
					type : "POST",
					url : "system/countRecordOfCarNullBySiteId",
					async: false,
					data : {"siteId" : site.id},
					success : function(result) {
						if(result==0)
							status="待处理(已分配)";
						else
							status="待处理(未分配)";
					}
				});
			}
			var lid = '<div><h5>'+site.siteName+'</h5><table style="font-size:12px;">';
			if(site.status=="1"){
				var rate = queryRateOfProcess(site.id);
				if(rate == -1){
					lid += '<tr><td style="width:40%;text-align: left;">处理进度：</td><td style="text-align: left;">数据异常</td></tr>';	
					}else{
					//处理进度
					rate = 100*rate;
					lid += '<tr><td style="width:40%;text-align: left;">处理进度：</td><td style="text-align: left; color: #1874CD; font-weight: bold;">'+rate.toFixed(2)+'%</td></tr>';
				}
			}else if(site.status=="2"){
				var value = queryPretreatAmount(site.id);
				if(value == -1){
					lid += '<tr><td style="width:40%;text-align: left;">预处理量：</td><td style="text-align: left;">数据异常</td></tr>';	
					}else if(value == 0){
						lid += '<tr><td style="width:40%;text-align: left;">预处理量：</td><td style="text-align: left; color: #1874CD; font-weight: bold;">未设置</td></tr>';
					}else{
						//预处理量
						lid += '<tr><td style="width:40%;text-align: left;">预处理量：</td><td style="text-align: left; color: #1874CD; font-weight: bold;">'+value+'</td></tr>';
					}
			}
			lid += '<tr><td style="width:40%;text-align: left;">Tel:</td><td style="text-align: left;">'+site.telephone+'</td></tr>';
			if(site.status=="2")
				lid += '<tr onclick="dealSite('+site.id+');" style="color:#FF4500;cursor:pointer;"><td style="width:40%;text-align: left;">状态:</td><td style="text-align: left;">'+status+'</td></tr>'
			else
				lid += '<tr style="color:#FF4500;"><td style="width:40%;text-align: left;">状态:</td><td style="text-align: left;">'+status+'</td></tr>';
			lid += '</table>' + '</div>';
			siteInfoWindow = new BMap.InfoWindow(lid,opts); // 创建信息窗口对象 
			map.openInfoWindow(siteInfoWindow, sitePoint);
			
	}
	/***************************** 车辆信息框显示************************************* */
	function carInfo(car){
			var opts = {width : 230,} // 信息窗口宽度
			if(car.status==4)
				var lid = '<div><h5>'+car.license+'(返程中)</h5><table style="font-size:12px;">';
			else
				var lid = '<div><h5>'+car.license+'</h5><table style="font-size:12px;">';
									
			lid	+= '<tr><td style="width:40%;text-align: left;">司机：</td><td style="text-align: left;">'+car.driver.realname+'</td>'
				+ '</tr>'
				+ '<tr>'
				+ '<td style="width:40%;text-align: left;">Tel:</td><td style="text-align: left;">'+car.driver.telephone+'</td>'
				+ '</tr>';
			if(car.status==1){
				var pointSite = new BMap.Point(car.site.longitude,car.site.latitude);
				var driving = new BMap.DrivingRoute(map,
					{onSearchComplete:function(results){
						var plan=results.getPlan(0);
						lid += '<tr style="color:#FF4500;"><td style="width:40%;text-align: left;">目的地:</td><td style="text-align: left;">'+car.site.siteName+'</td></tr>';
						lid += '<tr><td style="width:40%;text-align: left;">预计到达:</td><td style="text-align: left;">'+plan.getDuration(true)+'</td></tr>';
						lid += '</table>' + '</div>';
						carInfoWindow[car.id] = new BMap.InfoWindow(lid,opts); // 创建信息窗口对象 
						map.openInfoWindow(carInfoWindow[car.id], carPoint[car.id]);
					}});		
				driving.search(carPoint[car.id],pointSite);
				//alert("目的地:"+car.site.longitude+","+car.site.latitude);
			}
			else{
				lid += '</table>' + '</div>';
				carInfoWindow[car.id] = new BMap.InfoWindow(lid,opts); // 创建信息窗口对象 
				map.openInfoWindow(carInfoWindow[car.id], carPoint[car.id]);
			}
		}
	
	/***************************** 显示右下角车辆数量************************************* */
	function showNum(){
		$("#treatmentCarNum").text(queryMapCar(siteId,0,-1).length);
		$("#carrierNum").text(queryMapCar(siteId,1,-1).length);
		};
	/***************************** 右下角查询站点所有处理车************************************* */
	function showTreatmentCarTable(){
		$("#treatmentCarTable").empty();
		var table;
		carList = queryMapCar(siteId,0,-1);
		$.each(carList,function(i, car){
			if(car.status == 1){
				var pointSite = new BMap.Point(car.site.longitude,car.site.latitude);
				var carPoint = new BMap.Point(car.longitude,car.latitude);
				var driving = new BMap.DrivingRoute(map,
					{onSearchComplete:function(results){
						var plan=results.getPlan(0);
						table='<tr id="'+ car.id +'" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showCarInfo('+JSON.stringify(car).replace(/\"/g,"'")+')">';
						table += '<td style="width:20%;">' + car.license + '</td>';
						table += '<td style="width:20%;">'+plan.getDuration(true)+'</td>';
						table += '</tr>';
						$("#treatmentCarTable").append(table);
					}});		
				driving.search(carPoint,pointSite);
			}
			if(car.status == 2){
				table='<tr id="'+ car.id +'" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showCarInfo('+JSON.stringify(car).replace(/\"/g,"'")+')">';
				table += '<td style="width:20%;">' + car.license + '</td>';
				table += '<td style="width:20%;">处理中</td>';
				table += '</tr>';
				$("#treatmentCarTable").append(table);
			}
			if(car.status == 3){
				table='<tr id="'+ car.id +'" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showCarInfo('+JSON.stringify(car).replace(/\"/g,"'")+')">';
				table += '<td style="width:20%;">' + car.license + '</td>';
				table += '<td style="width:20%;">未出发</td>';
				table += '</tr>';
				$("#treatmentCarTable").append(table);
			}
		});
	}
	
	/***************************** 右下角查询站点所有运输车************************************* */
	function showCarrierTable(){
		$("#carrierTable").empty();
		var table;
		carList = queryMapCar(siteId,1,-1);
		$.each(carList,function(i, car){
			if(car.status == 1){
				var pointSite = new BMap.Point(car.site.longitude,car.site.latitude);
				var carPoint = new BMap.Point(car.longitude,car.latitude);
				var driving = new BMap.DrivingRoute(map,
					{onSearchComplete:function(results){
						var plan=results.getPlan(0);
						table='<tr id="'+ car.id +'" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showCarInfo('+JSON.stringify(car).replace(/\"/g,"'")+')">';
						table += '<td style="width:20%;">' + car.license + '</td>';
						table += '<td style="width:20%;">'+plan.getDuration(true)+'</td>';
						table += '</tr>';
						$("#carrierTable").append(table);
					}});		
				driving.search(carPoint,pointSite);
			}
			if(car.status == 2){
				table='<tr id="'+ car.id +'" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showCarInfo('+JSON.stringify(car).replace(/\"/g,"'")+')">';
				table += '<td style="width:20%;">' + car.license + '</td>';
				table += '<td style="width:20%;">装箱中</td>';
				table += '</tr>';
				$("#carrierTable").append(table);
			}
			if(car.status == 3){
				table='<tr id="'+ car.id +'" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showCarInfo('+JSON.stringify(car).replace(/\"/g,"'")+')">';
				table += '<td style="width:20%;">' + car.license + '</td>';
				table += '<td style="width:20%;">未出发</td>';
				table += '</tr>';
				$("#carrierTable").append(table);
			}
		});
	}
	
	/***************************** 列表鼠标响应************************************* */
	function showCarInfo(car){
		if(car.status == 1){
			carInfo(car);
		}
		if(car.status == 2){
			site = queryMapSite(siteId);
			siteInfo(site);
		}
	}
	
	function sel(obj){
		obj.style.backgroundColor="rgba(70,130,180,0.3)";
	}
	function cle(obj){
		obj.style.backgroundColor="rgba(0, 0, 0, 0)";
	}
	
</script>

