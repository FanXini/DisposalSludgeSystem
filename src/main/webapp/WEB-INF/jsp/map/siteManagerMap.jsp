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
	height: 530px;
	overflow: auto;
}

.selectMenu {
	position: absolute;
	right: 20px;
	top: 5px;
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
	<div class="modal inmodal fade" id="myModal" tabindex="-1" role="dialog"  aria-hidden="true">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h6 style="font-size:16px;font-weight:bold;" id="destination" class="modal-title"></h6>
                    </div>
                    <div class="modal-body">
                        <p id="editContext"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
                        <button id="submitBtn" type="button" class="btn btn-primary">确定</button>
                    </div>
                </div>
            </div>
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
	var siteMarker = new Array();
	var sitePoint = new Array();
	var siteInfoWindow = new Array();
	var carMarker = new Array();
	var carPoint = new Array();
	var carInfoWindow = new Array();
	var siteId=${sessionScope.user.siteId};
	var carStatus=-1;
	show();
	
	function show(){
		$.ajax({
  			type : "POST",
  			url : "system/querySiteMapBySiteId",
  			data : "siteId="+siteId,
  			success : function(site) {
  				if(!jQuery.isEmptyObject(site)){
  					showMap(site);
  				}
  			}
  		});
  	}
	
  	//setInterval("showMap()",3000);  //定时刷新map
  	//setInterval("showNum()",3000);  //定时刷新空闲车辆及待处理站点数量
	/***************************** 显示标注************************************* */
	function showMap(site) {
		map.clearOverlays(); //清除地图上所有覆盖物
		carPoint=[];
		carMarker=[];
		carInfoWindow=[];
		
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
		siteMarker.addEventListener("mouseover",function(){
			siteInfo(site);
		});
		$.ajax({
				type : "POST",
				url : "car/queryMapCarBySiteId",
				data : "siteId="+site.id,
				success : function(carList) {
					$.each(carList,function(i, car) {
						if(car.carType == 0){
							var carIcon = new BMap.Icon("img/car.png", new BMap.Size(35, 24), {
									imageSize : new BMap.Size(35, 24)});
						}else{
							var carIcon = new BMap.Icon("img/transportCar.png", new BMap.Size(35, 35), {
									imageSize : new BMap.Size(35, 35)});
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
			});
	}
	
	/***************************** 站点信息框显示************************************* */
	function siteInfo(site){
			var value=-1;
			var opts = {width : 230, }// 信息窗口宽度
			$.ajax({
				type : "POST",
				url : "system/queryUltrasonicValueBySite",
				data : {"sensorIdSet" : site.sensorIdSet},
				success : function(sensors) {
					var status;
					if (site.status== "0")
						status="正常";
					else if (site.status== "1")
						status="处理中";
					else if (site.status== "2")
						status="待处理";
					var lid = '<div><h5>'+site.siteName+'</h5><table style="font-size:12px;">';
					if(!jQuery.isEmptyObject(sensors)){
						{
							$.each(sensors,function(i, sensor) {
								if(sensor.typeId==3){
									var v=sensor.sensorValue.value;
									//alert(result.value);
									//污泥量
									value=100*(site.depth-v)/site.depth;
									lid += '<tr><td style="width:40%;text-align: left;">污泥量：</td><td style="text-align: left; color: #1874CD; font-weight: bold;">'+value.toFixed(2)+'%</td></tr>';
									return false;
								}
							});
						}
					}
					else if(jQuery.isEmptyObject(sensors) || value==-1)
						lid += '<tr><td style="width:40%;text-align: left;">污泥量：</td><td style="text-align: left;">无数据</td></tr>';	
					lid += '<tr><td style="width:40%;text-align: left;">Tel:</td><td style="text-align: left;">'+site.telephone+'</td>'
						+ '</tr><tr style="color:#FF4500;">'
						+ '<td style="width:40%;text-align: left;">状态:</td><td style="text-align: left;">'+status+'</td>'
						+ '</tr>' + '</table>' + '</div>';
					siteInfoWindow = new BMap.InfoWindow(lid,opts); // 创建信息窗口对象 
					map.openInfoWindow(siteInfoWindow, sitePoint);
					}
				}); 
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
	
</script>

