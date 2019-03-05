<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=5TmZTw10oplDe4ZehEM6UjnY6rDgocd8&s=1"></script>

<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style type="text/css">
h5{
	text-align:center;
}

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
	width:80px;
	margin:auto auto 5px 10px;
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

.infowindow {
	height: 25px;
	line-height:20px;
	text-align: center;
}
.infowindow .line {
	display: inline-block;
	width: 30%;
	border-top: 1px solid #ccc ;
}
.infowindow .txt {
	font-size:15px;
	vertical-align: 30%;
}
.carlist{
	margin:2px 2px 2px 2px;
	text-align:center;
}
.infoSize{
	font-size:15px;
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
						<select id="typeSelect" class="select">
							<option value="-1">-类型-</option>
							<option value="2">-站点-</option>
							<option value="0">-处理车-</option>
							<option value="1">-运输车-</option>
						</select>
					</td>
					<td>
						<select id="statusSelect" class="select">
							<option value="-1">-状态-</option>
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
			href="#" onclick="showSiteTable();"> <i class="fa fa-map-marker" style="color:#EE2C2C"></i> <span id="siteRedNum" class="label label-danger"></span> </a>
			<ul class="dropdown-menu dropdown-messages"
					style="background: rgba(176,196,222,0.8);max-height:300px;width:500px;overflow-y:auto;">
				<li>
					<table class="tablehead" border="0" cellspacing="0" cellpadding="0"
						style="width:100%">
						<tr>
							<td style="width:20%;font-size:20px;">编号</td>
							<td style="width:45%;font-size:20px;">站点</td>
							<td style="width:25%;font-size:20px;">状态</td>
						</tr>
					</table>
				</li>
				<li class="divider"></li>
				<li>
					<table id="siteTable" class="tablelist" border="0" cellspacing="0" cellpadding="0"
							style="width:100%">
					</table>
				</li>
			</ul>
		</li>
		<li class="dropdown dropup"><a class="dropdown-toggle count-info" data-toggle="dropdown"
			href="#" onclick="showTreatmentCarTable();"> <i i class="fa fa-truck"  style="color:#FFD700"></i><span class="label label-warning" id="treatmentCarNum"></span> </a>
			<ul class="dropdown-menu dropdown-messages"
					style="background: rgba(176,196,222,0.8);max-height:300px;width:500px;overflow-y:auto;">
				<li>
				<span style="font-weight:900;font-size:23px;text-align:center;display:block">处理车</span>
					<table class="tablehead" border="0" cellspacing="0" cellpadding="0"
						style="width:100%;">
						<tr>
							<td style="width:30%;font-size:20px;">车牌号</td>
							<td style="width:40%;font-size:20px;">目的地</td>
							<td style="width:30%;font-size:20px;">状态</td>
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
			href="#" onclick="showCarrierTable();"> <i class="fa fa-truck"  style="color:#4D4D4D"></i> <span class="label label-warning" id="carrierNum">3</span> </a>
			<ul class="dropdown-menu dropdown-messages"
					style="background: rgba(176,196,222,0.8);max-height:300px;width:500px;overflow-y:auto;">
				<li>
				<span style="font-weight:900;font-size:23px;text-align:center;display:block">运输车</span>
					<table class="tablehead" border="0" cellspacing="0" cellpadding="0"
						style="width:100%">
						<tr>
							<td style="width:30%;font-size:20px;">车牌号</td>
							<td style="width:40%;font-size:20px;">目的地</td>
							<td style="width:30%;font-size:20px;">状态</td>
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
		<li class="dropdown dropup"><a class="dropdown-toggle count-info" data-toggle="dropdown"
			href="#" onclick="showWareHouseTable();"><i i class="fa fa-cubes" style="color:#EE2C2C"></i></a>
			<ul class="dropdown-menu dropdown-messages" style="background: rgba(176,196,222,0.8);max-height:300px;overflow-y:auto;">
				<li>
					<table class="tablehead" border="0" cellspacing="0" cellpadding="0"
						style="width:100%">
						<tr>
							<td style="width:20%;font-size:20px;">子仓</td>
							<td style="width:20%;font-size:20px;">存储量</td>
							<td style="width:40%;font-size:20px;">剩余容量</td>
							<td style="width:20%;font-size:20px;">总容量</td>
						</tr>
					</table>
				</li>
				<li class="divider"></li>
				<li>
					<table id="wareHouseTable" class="tablelist" border="0" cellspacing="0" cellpadding="0"
							style="width:100%">
					</table>
				</li>
			</ul>
		</li>
	</ul>
	</div>
	
	<!-- 手动分配处理人Modal -->
	<div class="modal fade" id="dealSiteModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">分配处理人</h4>
				</div>
				<div class="modal-body">
					<!-- 用来存id -->
					<input id="dealSiteId" type="hidden"/>
					<form>
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon">处理人</span>
								<select	id="driverSelect" class="form-control col-lg-4">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-l" data-dismiss="modal">取消</button>
					<button id="saveSiteDealBtn" type="button" class="btn btn-primary">保存</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 分配站点Modal -->
	<div class="modal fade" id="dealCarModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">分配站点</h4>
				</div>
				<div class="modal-body">
					<!-- 用来存id -->
					<input id="dealCarId" type="hidden" />
					<form>
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon">站点 </span>
								<select	id="siteSelect" class="form-control col-lg-4">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-l" data-dismiss="modal">取消</button>
					<button id="saveCarDealBtn" type="button" class="btn btn-primary">保存</button>
				</div>
			</div>
		</div>
	</div>
	<script src="js/car-location.js"></script>
</body>
</html>

<script type="text/javascript">
	var map = new BMap.Map("allmap");
	window.map = map;
	//var point = new BMap.Point(112.971916, 28.197967);//长沙
	var point = new BMap.Point(113.83040,22.77615);//深圳
	//22.7761577466,113.8304040020

	map.addControl(new BMap.NavigationControl()); // 添加平移缩放控件
	map.addControl(new BMap.ScaleControl()); // 添加比例尺控件
	map.addControl(new BMap.OverviewMapControl()); //添加缩略地图控件
	map.enableScrollWheelZoom(); //启用滚轮放大缩小
	//	map.addControl(new BMap.MapTypeControl());          //添加地图类型控件
	map.disable3DBuilding();
	map.centerAndZoom(point, 12);
	map.setMapStyle({
		style : 'light'
	}); //设置地图样式
	var wareHouseName;
	var wareHousePoint;
	var wareHouseMarker;
	var wareHouseInfoWindow;
	var siteListOld=new Array();
	var roadCarListOld=new Array()
	var siteMarker = new Array();
	var sitePoint = new Array();
	var siteInfoWindow = new Array();
	var siteStatus = {NORMAL : 0,PROCESSING : 1,WATINGPROCESS : 2};
	var carMarker = new Array();
	var carPoint = new Array();
	var carInfoWindow = new Array();
	var carType = {TREATMENT : 0,CARRIER : 1,ALL : -1};
	var carStatus = {LEISURE : 0,ONTHEWAY : 1,ARRIVAL : 2,NODEPARTURE : 3,GETBACK : 4,ALL : -1};
	var leisureTreatmentCarNum = 0;
	var leisureCarrierNum = 0;
	var nodepartureTreatmentCarNum = 0;
	var nodepartureCarrierNum = 0;
	showWareHouse();
	showCarInRoad();
	showMap(-1,-1);
	var interval=setInterval("showMap(-1,-1)",10000);
	var carInterval=setInterval("showCarInRoad()",2000);
	
  	//setInterval("showMap()",3000);  //定时刷新map
  	//setInterval("showNum()",3000);  //定时刷新空闲车辆及待处理站点数量
  	
  	/***************************** 类型联动************************************* */
  	$("#typeSelect").change(function(){
  		var ts = $("#typeSelect").val();
  		if(ts==-1){
  			location.reload()
  		}	
  		map.clearOverlays();
  		clearInterval(interval);
  		clearInterval(carInterval);
  		siteListOld=[];//清空site历史记录
  		carPoint=[];// 清空car标记点
		carMarker=[];
		showMap(ts,-1);
		interval=setInterval("showMap("+ts+",-1)",5000);
  		if(ts == 2)
  		{
  			$("#statusSelect").empty();
  			$("#statusSelect").append('<option value="-1">-状态-</option><option value="0">正常</option><option value="1">正在处理</option><option value="2">待处理</option>');
  			$("#queryStr").attr("placeholder","编号/站点名/Tel");
  		}
  		else if(ts == 0)
  		{
  			$("#statusSelect").empty();
  			$("#statusSelect").append('<option value="-1">-状态-</option><option value="1">在途中</option><option value="4">返程</option>');
  			$("#queryStr").attr("placeholder","车牌号/目的地/司机/Tel");
  		}
  		else if(ts == 1)
  		{
  			$("#statusSelect").empty();
  			$("#statusSelect").append('<option value="-1">-状态-</option><option value="1">在途中</option><option value="4">运输中</option>');
  			$("#queryStr").attr("placeholder","车牌号/目的地/司机/Tel");
  		}
  		 else{
  			$("#statusSelect").empty();
  			$("#statusSelect").append('<option value="-1">-状态-</option>');
  			clearInterval(interval);
  			showMap(-1,-1);
  			interval=setInterval("showMap(-1,-1)",5000);
  		} 
  	});
    /***************************** 状态选择************************************* */
  	$("#statusSelect").change(function(){
  		map.clearOverlays(); //清空所有覆盖物
  		siteListOld=[];//清空site历史数据
  		carPoint=[];// 清空car标记点
		carMarker=[];
  		var typeS = $("#typeSelect").val();
  		var statusS = $("#statusSelect").val();
		clearInterval(interval);
		showMap(typeS, statusS);
		interval=setInterval("showMap("+typeS+","+statusS+")",5000);
  	});
  	/***************************** 输入框精确查找************************************* */
  	$("#querysubmit").click(function(){
  		map.clearOverlays(); //清空所有覆盖物
  		siteListOld=[];//清空site历史数据
  		carPoint=[];// 清空car标记点
		carMarker=[];
  		var queryStr=$("#queryStr").val();
  		var typeS =$("#typeSelect").val();
  		var statusS = $("#statusSelect").val();
  		if($.trim(queryStr)==""){
  			clearInterval(interval);
  			showMap(typeS, statusS);
  			interval=setInterval("showMap("+typeS+","+statusS+")",5000);
  			return;
  		}
  		if(typeS==2){
  			//alert("站点查找:"+queryStr);
  			clearInterval(interval);
  			showMap(-1,-1);
  			$.ajax({
  				type : "POST",
  				url : "system/queryMapSite",
  				data : {"queryStr" : queryStr},
  				success : function(siteList) {
  					if(jQuery.isEmptyObject(siteList))
  						alert("查找失败");
  					else{
  						$.each(siteList,function(i, site) {
  							siteInfo(site);
  						});
  					}
  				}
  			});
  		}
  		if(typeS == 1 || typeS == 0){
  			//alert("车辆查找:"+queryStr);
  			clearInterval(interval);
  			showMap(-1,-1);
  			$.ajax({
  				type : "POST",
  				url : "car/queryMapCar",
  				data : {"queryStr" : queryStr,
  						"carType" : typeS},
  				success : function(carList) {
  					if(jQuery.isEmptyObject(carList))
  						alert("查找失败");
  					else{
  						$.each(carList,function(i, car) {
  							if(car.status == 1){
  								siteInfo(car.site);
  							}else if(car.status == 0 || car.status == 3){
  								wareHouseInfo();
  							}
  							else{
  								carInfo(car);
  							}
  						});
  					}
  				}
  			});
  		}
  		if($("#typeSelect").val()==-1){
  			alert("请选择类型！");
  		}
  	});
  	    
  	/***************************** 查询子智慧泥仓信息************************************* */  	
  	function queryWareHouse(){
  		var minorWareHouseList;
		$.ajax({
  			type : "POST",
  			url : "mudWareHouse/queryMinorWareHouse",
			async : false,
  			success : function(list) {
  				minorWareHouseList = list;
  			}
  		});
  		return minorWareHouseList;
  	}
  	
	/***************************** 查询站点信息************************************* */
	function queryMapSite(siteId,status){
		var sites;
		$.ajax({
  			type : "POST",
  			url : "system/querySiteMapBySiteIdAndStatus",
  			data : {
  				"siteId" : siteId,
  				"status" : status
  			},
			async : false,
  			success : function(list) {
  					sites = list;
  			}
  		});
  		return sites;
  	}
	
	/***************************** 查询站点处理进度************************************* */  	
  	function queryRateOfProcess(siteId){
  		var rate;
		$.ajax({
  			type : "POST",
  			url : "record/queryRateOfProcessBySiteId",
  			data : "siteId="+siteId,
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
	
  	function queryCarInRoad(){
		var carList;
		$.ajax({
			type : "GET",
			url : "car/queryCarInRoad",
			async : false,
			success : function(list) {
				carList = list;
			}
		});
		return carList;
	}
  		
  	/***************************** 查询车辆************************************* */
	function queryMapCar(siteId,carType,status){
		var carList;
		$.ajax({
			type : "POST",
			url : "car/queryMapCarBySiteIdAndCarTypeAndStatus",
			data : {
				"siteId" : siteId,
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
  	/***************************** 显示右下角空车及待处理站点数量************************************* */
	function showNum(){
		leisureTreatmentCarNum = queryMapCar(-1,carType["TREATMENT"],carStatus["LEISURE"]).length;
		leisureCarrierNum = queryMapCar(-1,carType["CARRIER"],carStatus["LEISURE"]).length;
		nodepartureTreatmentCarNum =  queryMapCar(-1,carType["TREATMENT"],carStatus["NODEPARTURE"]).length;
		nodepartureCarrierNum =  queryMapCar(-1,carType["CARRIER"],carStatus["NODEPARTURE"]).length;
  		$("#treatmentCarNum").text(leisureTreatmentCarNum);
  		$("#carrierNum").text(leisureCarrierNum);
  		$("#siteRedNum").text(queryMapSite(-1,siteStatus["WATINGPROCESS"]).length);
	}
  	
  	/***************************** 显示主智慧泥仓************************************* */  	
  	function showWareHouse(){
		$.ajax({
  			type : "POST",
  			url : "mudWareHouse/queryMainWareHouse",
  			success : function(list) {
  				mainWareHouse = list[0];
  				wareHouseName = mainWareHouse.wareHouseName;
  				/* var carrierImg = '';
  				var treatmentImg = '';
  				if((leisureCarrierNum + nodepartureCarrierNum) > 0) carrierImg = 'C';
  				if((leisureTreatmentCarNum + nodepartureTreatmentCarNum) > 0) treatmentImg = 'T'; */
  				
  				myIcon = new BMap.Icon("img/warehouseCT.png", new BMap.Size(90, 75), {
					imageSize : new BMap.Size(90, 75)});
  				wareHousePoint = new BMap.Point(mainWareHouse.longitude,mainWareHouse.latitude);
  				wareHouseMarker = new BMap.Marker(wareHousePoint,{icon:myIcon});
				
				map.addOverlay(wareHouseMarker);
				wareHouseMarker.addEventListener("click",function(){
					wareHouseInfo()
				});
  			}
  		});
  	}
  	
	/***************************** 显示标注************************************* */
	function showMap(selectType,selectStatus) {
		//map.clearOverlays(); //清除地图上所有覆盖物
		//showWareHouse();
		/* sitePoint=[];
		siteMarker=[];
		siteInfoWindow=[];
		carPoint=[];
		carMarker=[];
		carInfoWindow=[]; */
		showNum();
		if(selectType==-1||selectType==2){
			siteList = queryMapSite(-1,selectStatus);  //查询出所有的站点信息
			if(siteListOld.length==0){
				if(!jQuery.isEmptyObject(siteList)){
					var myIcon;
					$.each(siteList,function(i, site) {
						var pngName=site.status;
						if(site.status==1){
							pngName+="T";
						}
						myIcon = new BMap.Icon("img/factory"+pngName+".png", new BMap.Size(100, 70), {
								imageSize : new BMap.Size(100, 70)});
						sitePoint[site.id] = new BMap.Point(site.longitude,site.latitude);
						siteMarker[site.id] = new BMap.Marker(sitePoint[site.id],{icon:myIcon});
						
						map.addOverlay(siteMarker[site.id]);
						/* if(site.status=="2"){
							siteMarker[site.id].setAnimation(BMAP_ANIMATION_BOUNCE);
						} */
						siteMarker[site.id].addEventListener("click",function(){
							siteInfo(site)});
					});
				}
			}
			else{
				$.each(siteList,function(i,site){
					if(site.status!=siteListOld[i].status){  //状态改变了
						var pngName=site.status;
						if(site.status==1){
							pngName+="T";
						}
						
						var myIcon = new BMap.Icon("img/factory"+pngName+".png", new BMap.Size(100, 70), {
							imageSize : new BMap.Size(100, 70)});
						sitePoint[site.id] = new BMap.Point(site.longitude,site.latitude);
						siteMarker[site.id] = new BMap.Marker(sitePoint[site.id],{icon:myIcon});
						map.addOverlay(siteMarker[site.id]);
						siteMarker[site.id].addEventListener("click",function(){
							siteInfo(site)});
					}
				})
			}
			siteListOld=siteList;	
			
		}
		if(selectType != 2 && selectType!=-1){ //查询车辆信息
			var carList;
			//状态为运输中查询时，status依然为1
			if(selectType == 1 && selectStatus == 4){
				carList=queryMapCar(-1,selectType,1);
			}else{ 
				carList=queryMapCar(-1,selectType,selectStatus);
			}
			if(!jQuery.isEmptyObject(carList)){
				$.each(carList,function(i, car) {
					if(car.status == 1 || car.status == 4){
						if(selectStatus == -1 || !((car.carType == 1 && car.siteId != null && car.siteId != '' && selectStatus == 4)
								|| (car.carType == 1 && (selectStatus == 1) && (car.siteId == null || car.siteId == '')))){
							if(car.carType == 0){
								var carIcon = new BMap.Icon("img/car.png", new BMap.Size(35, 24), 
												{imageSize : new BMap.Size(35, 24)});
							}else{
								var carIcon = new BMap.Icon("img/transportCar.png", new BMap.Size(35, 35), 
												{imageSize : new BMap.Size(35, 35)});
							}
							var deviceId=car.cloudDeviceId;
							//更新位置
							getLocation(car.cloudDeviceId,car.cloudDeviceSerial);
							var location=locationMap[deviceId];
							if(location!=null){
								console.log(location.longitude+" "+location.latitude);
								carPoint[car.id] = new BMap.Point(location.longitude,location.latitude);
								carMarker[car.id] = new BMap.Marker(carPoint[car.id],{icon:carIcon});
								map.addOverlay(carMarker[car.id]);					
								//鼠标悬停动作
								carMarker[car.id].addEventListener("mouseover",function(){
									carInfo(car)});
							}
						
						}
					}
				});
			}
		}
	}
	/* var longitute=parseFloat(114.349081);
	var latitude=parseFloat(22.732652); */
	function showCarInRoad(){
		if(roadCarListOld.length!=0){
			console.log("clearCarMark")
			$.each(roadCarListOld,function(i, car) {
				map.removeOverlay(carMarker[car.id]);
			})
		}
		carPoint=[]; //清空
		carMarker=[]; //清空
		map.addOverlay(carMarker)
		var roadCarList=queryCarInRoad();
		console.log(roadCarList);
		if(!jQuery.isEmptyObject(roadCarList)){
			/* longitute-=0.004;
			latitude-=0.004; */
			$.each(roadCarList,function(i, car) {
				console.log(car)
				if(car.carType == 0){
					var carIcon = new BMap.Icon("img/car.png", new BMap.Size(35, 24), 
						         {imageSize : new BMap.Size(35, 24)});
				}else{
					var carIcon = new BMap.Icon("img/transportCar.png", new BMap.Size(35, 35), 
								{imageSize : new BMap.Size(35, 35)});
				}
				var deviceId=car.cloudDeviceId;
				carPoint[car.id] = new BMap.Point(car.longitude,car.latitude);
				carMarker[car.id] = new BMap.Marker(carPoint[car.id],{icon:carIcon});
				map.addOverlay(carMarker[car.id]);					
				//鼠标悬停动作
				carMarker[car.id].addEventListener("mouseover",function(){
				carInfo(car)});
				//更新位置
				/* getLocation(car.cloudDeviceId,car.cloudDeviceSerial);
				var location=locationMap[deviceId];
				if(location!=null){
					console.log(location)
					carPoint[car.id] = new BMap.Point(location.longitude,location.latitude);
					carMarker[car.id] = new BMap.Marker(carPoint[car.id],{icon:carIcon});
					map.addOverlay(carMarker[car.id]);					
					//鼠标悬停动作
					carMarker[car.id].addEventListener("mouseover",function(){
					carInfo(car)});
				} */			
			});
		}
		roadCarListOld=roadCarList;
	}
	
	/***************************** 泥仓信息框显示************************************* */
	function wareHouseInfo(){
		var opts = {width : 130, }// 信息窗口宽度
		minorWareHouseList = queryWareHouse();
		var lid = '<div class="carlist"><a class="infoSize" href='+"mudWareHouse/jumpTomudwarehouse"+'>'+wareHouseName+'</a><ul class="list-unstyled infoSize" style="color:#777;"';
		$.each(minorWareHouseList,function(i, minorWareHouse){
			lid += '<li class="infoSize">'+minorWareHouse.serialNumber+'号仓:'+minorWareHouse.remainCapacity+'/'+minorWareHouse.capacity+'</li>';
		});
		lid += '</ul>' + '</div>';
		if(leisureTreatmentCarNum > 0){
			var treatmentCarList = queryMapCar(-1,carType["TREATMENT"],carStatus["LEISURE"]);
			lid += '<div class="infowindow"></span><span class="txt" style="color:#0000FF;">'+treatmentCarList.length+'辆空闲处理车</span></span></div><div class="carlist">';
			lid += '<ul class="list-inline" style="font-size:11px;color:#777;">' ;
			$.each(treatmentCarList,function(i, treatmentCar) {
				lid += '<li style="color:#0000FF; font:bold;"><a class="infoSize" href="monitor/queryVideoAndSensorByCarId?carId='+treatmentCar.id+'">'+treatmentCar.license+'</a></li>';
			});
			lid += "</ul></div>"
		}
		if(leisureCarrierNum > 0){ /* 横线</span><span class="line"> */
			var carrierList = queryMapCar(-1,carType["CARRIER"],carStatus["LEISURE"]);
			lid += '<div class="infowindow"><span class="txt" style="color:#B22222;">'+carrierList.length+'辆空闲运输车</span></div><div class="carlist">';
			lid += '<ul class="list-inline" style="font-size:11px;color:#777;">';
			$.each(carrierList,function(i, carrier) {
				/* lid += '<li style="color:#B22222"><a class="infoSize" href="monitor/queryVideoAndSensorByCarId?driverId='+carrier.driverId+'">'+carrier.license+'</a></li>'; */
				lid += '<li class="infoSize" style="color:#B22222">'+carrier.license+'</li>';
			});
			lid += "</ul></div>"
		}
		if((nodepartureTreatmentCarNum+nodepartureCarrierNum) > 0){
			var nodepartureCarList = queryMapCar(-1,carType["ALL"],carStatus["NODEPARTURE"]);
			lid += '<div class="infowindow"><span class="txt" style="color:	#FF3030;">'+nodepartureCarList.length+'辆待出发</span></div><div class="carlist">';
			lid += '<ul class="list-inline" style="font-size:11px;color:#777;">';
			$.each(nodepartureCarList,function(i, nodepartureCar) {
				if(nodepartureCar.carType == carType["TREATMENT"]){
					lid += '<li style="color:#0000FF;"><a class="infoSize" href="monitor/queryVideoAndSensorByCarId?carId='+nodepartureCar.id+'">'+nodepartureCar.license+'(处)</a></li>';
					
				}else{
					//lid += '<li style="color:#B22222;"><a class="infoSize" href="monitor/queryVideoAndSensorByCarId?driverId='+nodepartureCar.driverId+'">'+nodepartureCar.license+'(运)</a></li>';
					lid += '<li class="infoSize" style="color:#B22222;">'+nodepartureCar.license+'(运)</li>';
					}
			});
			lid += "</ul></div>"
		}
		wareHouseInfoWindow = new BMap.InfoWindow(lid,opts); // 创建信息窗口对象 
		map.openInfoWindow(wareHouseInfoWindow, wareHousePoint);
		}
	
	/***************************** 站点信息框显示************************************* */
	function siteInfo(site){
		var value=-1;
		var opts = {width : 230, }// 信息窗口宽度
		var status;
		var currentTreatmentCarList = [];
		var currentCarrierList = queryMapCar(site.id,carType["CARRIER"],carStatus["ARRIVAL"]);//在站点正在装箱的车辆
		if (site.status== "0")
			status="正常";
		else if (site.status== "1"){
			status="正在处理";
			currentTreatmentCarList = queryMapCar(site.id,carType["TREATMENT"],carStatus["ARRIVAL"]);
		}
		else if (site.status== "2"){
			var carNum = queryMapCar(site.id,0,1).length;//在途中的车辆数
			carNum += queryMapCar(site.id,0,3).length;//已派单未出发的车辆数
			if(carNum==0)
				status="待处理(未分配)";
			else
				status="待处理(已分配处理车"+carNum+"辆)";
			}
		var lid = '<div class="carlist"><a class="infoSize" href="monitor/queryFactoryVideoBySiteId?siteId='+site.id+'">'+site.siteName+'</a><ul class="list-unstyled" style="font-size:11px;color:#777;">';
		if(site.status=="1"){
			var rate = queryRateOfProcess(site.id);
			if(rate == -1){
				lid += '<li class="infoSize">处理进度：<span style="color: #1874CD; font-weight: bold;">数据异常</span></li>';	
				}else{
				//处理进度
				rate = 100*rate;
				lid += '<li class="infoSize">处理进度：<span style="color: #1874CD; font-weight: bold;">'+rate.toFixed(2)+'%</span></li>';
			}
		}else if(site.status=="2"){
			var value = queryPretreatAmount(site.id);
			if(value == -1){
				lid += '<li class="infoSize">预处理量：<span style="color: #1874CD; font-weight: bold;">数据异常</span></li>';	
				}else if(value == 0){
					lid += '<li class="infoSize">预处理量：<span style="color: #1874CD; font-weight: bold;">未设置</span></li>';
				}else{
					//预处理量
					lid += '<li class="infoSize">预处理量：<span style="color: #1874CD; font-weight: bold;">'+value+'</span></li>';
				}
		}
		lid += '<li class="infoSize">Tel:'+site.telephone+'</li>';
		lid += '<li class="infoSize" style="color:#FF4500;">状态:'+status+'</li>';
		lid += '</ul>' + '</div>';
		if(currentTreatmentCarList.length != 0){
			lid += '<div class="infowindow"><span class="line"></span><span class="txt" style="color:#0000FF;">'+currentTreatmentCarList.length+'辆车处理中</span><span class="line"></span></div><div class="carlist">';
			lid += '<ul class="list-inline" style="font-size:11px;color:#0000FF;"';
			$.each(currentTreatmentCarList,function(i, treatmentCar) {
				lid += '<li><a class="infoSize" href="monitor/queryVideoAndSensorByCarId?carId='+treatmentCar.id+'" style="color: #0000FF;">'+treatmentCar.license+'</a></li>';
			});
			lid += "</ul></div>"
		}
		if(currentCarrierList.length != 0){
			lid += '<div class="infowindow"></span><span class="txt" style="color:#B22222;">'+currentCarrierList.length+'辆车正在装箱</span></div><div class="carlist">';
			lid += '<ul class="list-inline" style="font-size:11px;color:#B22222;"';
			$.each(currentCarrierList,function(i, carrier) {
				//lid += '<li><a class="infoSize" href="monitor/queryVideoAndSensorByCarId?driverId='+carrier.driverId+'" style="color: #0000FF;">'+carrier.license+'</a></li>';
				lid += '<li><span class="infoSize">'+carrier.license+'</span></li>';
			});
			lid += "</ul></div>"
		}
		siteInfoWindow[site.id] = new BMap.InfoWindow(lid,opts); // 创建信息窗口对象 
		map.openInfoWindow(siteInfoWindow[site.id], sitePoint[site.id]);
	}
		
	/***************************** 车辆信息框显示************************************* */
	function carInfo(car){
		var opts = {width : 230,} // 信息窗口宽度
		if(car.status==4){
			if(car.carType==0){
				var lid = '<div><h5 h5 class="infoSize"><a href="monitor/queryVideoAndSensorByCarId?carId='+car.id+'">'+car.license+'-处(返程中)</a></h5><table style="font-size:12px;">';
			}
			else{
				var lid = '<div><h5 class="infoSize">'+car.license+'-运(返程中)</h5><table style="font-size:12px;">';
			}
		}
		else if(car.status==1 && (car.siteId == null || car.siteId == ''))
			var lid = '<div><h5 class="infoSize">'+car.license+'(运输中)</h5><table style="font-size:12px;">';
		else if (car.carType == 1)
			var lid = '<div><h5 class="infoSize">'+car.license+'(运)</h5><table style="font-size:12px;">';
		else
			var lid = '<div><h5><a class="infoSize" href="monitor/queryVideoAndSensorByCarId?carId='+car.id+'">'+car.license+'(处)</a></h5><table style="font-size:12px;">';
								
		lid	+= '<tr><td class="infoSize" style="width:40%;text-align: left;">司机：</td><td class="infoSize" style="text-align: left;">'+car.driver.realname+'</td>'
			+ '</tr>'
			+ '<tr>'
			+ '<td class="infoSize" style="width:40%;text-align: left;">Tel:</td><td class="infoSize" style="text-align: left;">'+car.driver.telephone+'</td>'
			+ '</tr>';
		if(car.status==1 && car.siteId != null && car.siteId != ''){
			var pointSite = new BMap.Point(car.site.longitude,car.site.latitude);
			var driving = new BMap.DrivingRoute(map,
				{onSearchComplete:function(results){
					var plan=results.getPlan(0);
					lid += '<tr style="color:#FF4500;"><td class="infoSize" style="width:40%;text-align: left;">目的地:</td><td class="infoSize" style="text-align: left;">'+car.site.siteName+'</td></tr>';
					lid += '<tr><td class="infoSize" style="width:40%;text-align: left;">预计到达:</td><td class="infoSize" style="text-align: left;">'+plan.getDuration(true)+'</td></tr>';
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
	
	/***************************** 右下角查询所有站点************************************* */
	function showSiteTable(){
		$("#siteTable").empty();
		var siteList = queryMapSite(-1,-1);
		var table;
		$.each(siteList,function(i, site) {
			var status;
			if (site.status== "0"){
				table='<tr id="'+ site.id +'" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showSiteInfo('+JSON.stringify(site).replace(/\"/g,"'")+')">';
				status="正常";
			}
			else if (site.status== "1"){
				table='<tr id="'+ site.id +'" style="color:#FFFF00;" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showSiteInfo('+JSON.stringify(site).replace(/\"/g,"'")+')">';
				var rate = queryRateOfProcess(site.id);
				status="正在处理";
				if(rate == -1){
					status=status + "(数据异常)";	
					}else{
					//处理进度
					rate = 100*rate;
					status = status + "(" + rate.toFixed(2)+"%)";
				}
			}
			else if (site.status== "2"){
				table='<tr id="'+ site.id +'" style="color:#FF0000;font-weight: 700;" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showSiteInfo('+JSON.stringify(site).replace(/\"/g,"'")+')">';
				var carNum = queryMapCar(site.id,0,1).length;//在途中的车辆数
				carNum += queryMapCar(site.id,0,3).length;//已派单未出发的车辆数
				if(carNum==0)
					status="待处理(未分配)";
				else
					status="待处理(已分配处理车"+carNum+"辆)";
			}				
			table += '<td style="width:20%;font-size:15px;">' + site.serialNumber + '</td>';
			table += '<td style="width:45%;font-size:15px;">' + site.siteName + '</td>';
			table += '<td style="width:25%;font-size:15px;">' + status + '</td>';
			table += '</tr>';
			$("#siteTable").append(table);
		});
	}
	
	/***************************** 右下角查询所有处理车************************************* */
	function showTreatmentCarTable(){
		$("#treatmentCarTable").empty();
		var table;
		carList = queryMapCar(-1,0,-1);
		$.each(carList,function(i, car){
			var status;
			if (car.status== "0"){
				table='<tr id="'+ car.id +'" style="color:#FF0000;font-weight: 700;" onmouseover="sel(this)" onmouseout="cle(this)" onclick="wareHouseInfo();">';
				status="空闲";
			}
			else if (car.status== "1"){
				table='<tr id="'+ car.id +'" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showCarInfo('+JSON.stringify(car).replace(/\"/g,"'")+')">';
				status="在途中";
			}
			else if (car.status== "2"){
				table='<tr id="'+ car.id +'" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showSiteInfo('+JSON.stringify(car.site).replace(/\"/g,"'")+')">';
				status="正在处理";
			}
			else if (car.status== "3"){
				table='<tr id="'+ car.id +'" onmouseover="sel(this)" onmouseout="cle(this)" onclick="wareHouseInfo();">';
				status="已派单";
			}
			else if (car.status== "4"){
				table='<tr id="'+ car.id +'" style="color:#FFFF00;font-weight: 700;" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showCarInfo('+JSON.stringify(car).replace(/\"/g,"'")+')">';
				status="返程中";
			}
			table += '<td style="width:30%;font-size:15px;">' + car.license + '</td>';
			if (!jQuery.isEmptyObject(car.site)){
				table += '<td style="width:40%;font-size:15px;">' + car.site.siteName + '</td>';
			}
			else table += '<td style="width:40%;font-size:15px;">' + status + '</td>';
			table += '<td style="width:30%;font-size:15px;">' + status + '</td>';
			table += '</tr>';
			$("#treatmentCarTable").append(table);
		});
	}
	
	/***************************** 右下角查询所有运输车************************************* */
	function showCarrierTable(){
		$("#carrierTable").empty();
		var table;
		carList = queryMapCar(-1,1,-1);
		$.each(carList,function(i, car){
			var status;
			if (car.status== "0"){
				table='<tr id="'+ car.id +'" style="color:#FF0000;font-weight: 700;" onmouseover="sel(this)" onmouseout="cle(this)" onclick="wareHouseInfo();">';
				status="空闲";
			}
			else if (car.status== "1"){
				if(car.siteId != null && car.siteId != ""){
					table='<tr id="'+ car.id +'" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showCarInfo('+JSON.stringify(car).replace(/\"/g,"'")+')">';
					status="在途中";
				}else{
					table='<tr id="'+ car.id +'" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showCarInfo('+JSON.stringify(car).replace(/\"/g,"'")+')">';
					status="运输中";
				}
			}
			else if (car.status== "2"){
				table='<tr id="'+ car.id +'" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showSiteInfo('+JSON.stringify(car.site).replace(/\"/g,"'")+')">';
				status="正在装\卸箱";
			}
			else if (car.status== "3"){
				table='<tr id="'+ car.id +'" onmouseover="sel(this)" onmouseout="cle(this)" onclick="wareHouseInfo();">';
				status="已派单";
			}
			else if (car.status== "4"){
				table='<tr id="'+ car.id +'" style="color:#FFFF00;font-weight: 700;" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showCarInfo('+JSON.stringify(car).replace(/\"/g,"'")+')">';
				status="返程中";
			}
			table += '<td style="width:30%;font-size:15px;">' + car.license + '</td>';
			if (!jQuery.isEmptyObject(car.site)){
				table += '<td style="width:40%;font-size:15px;">' + car.site.siteName + '</td>';
			}
			else table += '<td style="width:40%;font-size:15px;">' + status + '</td>';
			table += '<td style="width:30%;font-size:15px;">' + status + '</td>';
			table += '</tr>';
			$("#carrierTable").append(table);
		});
	}
	
	/***************************** 右下角智慧泥仓信息显示************************************* */
	function showWareHouseTable(){
		wareHouseInfo();
		$("#wareHouseTable").empty();
		var table;
		minorWareHouseList = queryWareHouse();
		$.each(minorWareHouseList,function(i, minorWareHouse){
			table='<tr id="'+ minorWareHouse.id +'" onmouseover="sel(this)" onmouseout="cle(this)")">';
			table += '<td style="font-size:15px;">' + minorWareHouse.serialNumber + '号仓</td>';
			table += '<td style="font-size:15px;">' + minorWareHouse.moistrueDegree*100 + '%</td>';
			table += '<td style="font-size:15px;">' + minorWareHouse.remainCapacity + '</td>';
			table += '<td style="font-size:15px;">' + minorWareHouse.capacity + '</td>';
			table += '</tr>';
			$("#wareHouseTable").append(table);
		});
	}
	
	/***************************** 列表鼠标响应************************************* */
	function showSiteInfo(site){
		clearInterval(interval);
		showMap(-1,-1);
		siteInfo(site);
	}
	function showCarInfo(car){
		clearInterval(interval);
		showMap(-1,-1);
		carInfo(car);
	}
	
	function sel(obj){
		obj.style.backgroundColor="rgba(70,130,180,0.3)";
	}
	function cle(obj){
		obj.style.backgroundColor="rgba(0, 0, 0, 0)";
	}
	
	/***************************** 手动任务分配（暂无此功能）************************************* */	
	function dealSite(siteId){
		$("#dealSiteId").val(siteId);
		$.ajax({
  				type : "POST",
  				url : "car/queryTreatmentCarUnassign",
  				success : function(carList) {
  					if(jQuery.isEmptyObject(carList))
  						alert("暂无空闲车辆");
  					else{
  						$("#driverSelect").empty();
  						$.each(carList,function(i, car) {
  							$("#driverSelect").append('<option id="'+car.id+'" value="'+car.id+'">'+car.driver.realname+'</option>')
  						});
  						$('#dealSiteModal').modal('show');
  					}
  				}
  			});
	}
	
	$("#saveSiteDealBtn").click(function (){
		var dealSiteId=$("#dealSiteId").val();
		var driverSelect=$("#driverSelect").val();
		$.ajax({
  			type : "POST",
  			url : "record/editRecordCarIdBySiteId",
  			data : {"siteId" : dealSiteId,
  					"carId" : driverSelect
  			},
  			success : function(result) {
				if(result.result=="success"){
 					alert("分配成功");
 					showNum();
 				}
  				else{
  					alert("分配失败");
				}
  			}
  		});
		$('#dealSiteModal').modal('hide');
	});
	
	function dealCar(carId){
	$("#dealCarId").val(carId);
		$.ajax({
  			type : "POST",
  			url : "record/queryRecordOfCarNull",
 			success : function(recordList) {
  				if(jQuery.isEmptyObject(recordList))
 					alert("暂无待处理站点");
  				else{
  					$("#siteSelect").empty();
  					$.each(recordList,function(i, record) {
  						$("#siteSelect").append('<option id="'+record.site.id+'" value="'+record.siteId+'">'+record.site.siteName+'</option>')
  					});
 					$('#dealCarModal').modal('show');
  				}
  			}
  		});
	}
	
	$("#saveCarDealBtn").click(function (){
		var dealSiteId=$("#siteSelect").val();
		var driverSelect=$("#dealCarId").val();
		$.ajax({
  			type : "POST",
  			url : "record/editRecordCarIdBySiteId",
  			data : {"siteId" : dealSiteId,
  					"carId" : driverSelect
  			},
  			success : function(result) {
				if(result.result=="success"){
 					alert("分配成功");
 					showNum();
 				}
  				else{
  					alert("分配失败");
				}
  			}
  		});
		$('#dealCarModal').modal('hide');
	});
	
</script>

