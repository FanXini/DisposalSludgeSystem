<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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

<link
	href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="shortcut icon" href="favicon.ico">
<link href="css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="css/font-awesome.css?v=4.4.0" rel="stylesheet">

<link href="css/animate.css" rel="stylesheet">
<link href="css/style.css?v=4.1.0" rel="stylesheet">
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=5TmZTw10oplDe4ZehEM6UjnY6rDgocd8"></script>

<script
	src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style type="text/css">
h5 {
	text-align: center;
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
	font-family: 微软雅黑;
	color: black;
	font-size: 15px;
	text-align: center;
	line-height: 1.2em;
	float: right;
	background: lavender;
	height: 35px;
	width: 80px;
	margin: auto auto 5px 10px;
}

.query_submit {
	border: 1px solid #555;
	padding: 0.5em;
	font-family: 微软雅黑;
	color: black;
	font-size: 15px;
	line-height: 1.2em;
	float: right;
	background: slateblue;
	height: 35px;
	width: 80px;
	text-align: center;
	margin: auto auto 5px 10px;
}

.text {
	border: 1px solid #555;
	padding: 0.5em;
	line-height: 1.2em;
	float: right;
	background: white;
	height: 35px;
	width: 200px;
	margin: auto auto 5px 10px;
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
	line-height: 20px;
	text-align: center;
}

.infowindow .line {
	display: inline-block;
	width: 30%;
	border-top: 1px solid #ccc;
}

.infowindow .txt {
	font-size: 12px;
	vertical-align: 30%;
}

.carlist {
	margin: 2px 2px 2px 2px;
	text-align: center;
}

.btn-circle.btn-xl {
	width: 130px;
	height: 130px;
	padding: 10px 10px;
	font-size: 12px;
	line-height: 1.33;
	border-radius: 65px;
	opacity: 0.8;
}
</style>
</head>

<body>
	<div id="allmap" class="map"></div>
	<div id="selectMenu" class="selectMenu">
		<input id="nowStatus" value="0" type="hidden" />
		<button id="updateCarStatusButton" type="button"
			class="btn btn-info btn-circle btn-xl" onclick="updateCarStatus()">暂无任务</button>
	</div>
	<div class="bottom_button">
		<ul class="nav navbar-top-links navbar-right">
			<li class="dropdown dropup"><a
				class="dropdown-toggle count-info" data-toggle="dropdown" href="#"
				onclick="showWareHouseTable();"><i i class="fa fa-cubes"
					style="color: #EE2C2C"></i></a>
				<ul class="dropdown-menu dropdown-messages"
					style="background: rgba(176, 196, 222, 0.8); max-height: 300px; overflow-y: auto;">
					<li>
						<table class="tablehead" border="0" cellspacing="0"
							cellpadding="0" style="width: 100%">
							<tr>
								<td>子仓</td>
								<td>存储量</td>
								<td>剩余容量</td>
								<td>总容量</td>
							</tr>
						</table>
					</li>
					<li class="divider"></li>
					<li>
						<table id="wareHouseTable" class="tablelist" border="0"
							cellspacing="0" cellpadding="0" style="width: 100%">
						</table>
					</li>
				</ul></li>
		</ul>
	</div>
</body>
</html>
<script type="text/javascript">
	var map = new BMap.Map("allmap");
	window.map = map;
	//var point = new BMap.Point(112.971916, 28.197967);//长沙
	var point = new BMap.Point(114.126588, 22.608209);//深圳

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

	var siteMarker;
	var sitePoint;
	var siteInfoWindow;
	var carMarker;
	var carPoint;
	var carInfoWindow;
	var wareHouseName;
	var wareHousePoint;
	var wareHouseMarker;
	var wareHouseInfoWindow;

	var userId = ${sessionScope.user.id};
	var carStatus = -1;

	show();
	flushCarStatus();
	function flushCarStatus() {
		$.ajax({
			type : "POST",
			url : "car/flushCarStatus",
			data : "driverId=" + userId,
			success : function(car) {
				if (car.status == 0) { //空闲状态
					$("#updateCarStatusButton").html("暂无任务");
					$("#nowStatus").val(0);
					$("#updateCarStatusButton").attr("disabled", true);
				} else if (car.status == 1) { //在途中
					if (car.siteId != 0) {
						$("#updateCarStatusButton").html("已到达工厂");
					} else {
						$("#updateCarStatusButton").html("已到达目的地");
					}
					$("#nowStatus").val(1);
					$("#updateCarStatusButton").attr("disabled", false);
				} else if (car.status == 2) { //已经到达状态
					if (car.carType == 0) { //如果是处理车
						$("#updateCarStatusButton").html("处理完成,返程");
					} else if (car.carType == 1) { //如果是运输车
						if (car.siteId != 0) { //!=0
							$("#updateCarStatusButton").html("运往目的地");
						} else {
							$("#updateCarStatusButton").html("卸货完成,返程");
						}
					}
					$("#nowStatus").val(2);
					$("#updateCarStatusButton").attr("disabled", false);
				} else if (car.status == 3) { //如果是分配但是为出发状态
					$("#updateCarStatusButton").html("前往工厂");
					$("#nowStatus").val(3);
					$("#updateCarStatusButton").attr("disabled", false);
				} else if (car.status == 4) { //返程状态
					$("#updateCarStatusButton").html("到达仓库");
					$("#updateCarStatusButton").attr("disabled", false);
					$("#nowStatus").val(4);
				}
			}
		})
	}

	function updateCarStatus() {
		var nowStatus = parseInt($("#nowStatus").val())
		$.ajax({
			type : "POST",
			url : "car/updateCarStatusByButton",
			data : JSON.stringify({
				driverId : userId,
				nowStatus : nowStatus
			}),
			dataType : "JSON",
			contentType : "application/json",
			success : function(car) {
				//alert(car.status + " " + car.carType);
				if (car.status == 0) { //空闲状态
					$("#updateCarStatusButton").html("暂无任务");
					$("#nowStatus").val(0);
					$("#updateCarStatusButton").attr("disabled", true);
				} else if (car.status == 1) { //在途中
					if (car.siteId != 0) {
						$("#updateCarStatusButton").html("已到达工厂");
					} else {
						$("#updateCarStatusButton").html("已到达目的地");
					}
					$("#nowStatus").val(1);
					$("#updateCarStatusButton").attr("disabled", false);
				} else if (car.status == 2) { //已经到达状态
					if (car.carType == 0) { //如果是处理车
						$("#updateCarStatusButton").html("处理完成,返程");
					} else if (car.carType == 1) { //如果是运输车
						if (car.siteId != 0) { //!=0
							$("#updateCarStatusButton").html("运往目的地");
						} else {
							$("#updateCarStatusButton").html("卸货完成,返程");
						}
					}
					$("#updateCarStatusButton").attr("disabled", false);
					$("#nowStatus").val(2);
				} else if (car.status == 3) { //如果是分配但是为出发状态
					$("#updateCarStatusButton").html("前往工厂");
					$("#nowStatus").val(3);
					$("#updateCarStatusButton").attr("disabled", false);
				} else if (car.status == 4) { //返程状态
					$("#updateCarStatusButton").html("到达仓库");
					$("#updateCarStatusButton").attr("disabled", false);
					$("#nowStatus").val(4);
				}
			}
		})
	}

	/***************************** 查询子智慧泥仓信息************************************* */
	function queryWareHouse() {
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

	/***************************** 查询站点处理进度************************************* */
	function queryRateOfProcess(siteId) {
		var rate;
		$.ajax({
			type : "POST",
			url : "record/queryRateOfProcessBySiteId",
			data : "siteId=" + siteId,
			async : false,
			success : function(result) {
				rate = result;
			}
		});
		return rate;
	}

	/***************************** 查询站点预处理量************************************* */
	function queryPretreatAmount(id) {
		var value;
		$.ajax({
			type : "POST",
			url : "record/queryCurrentPretreatAmountBySiteId",
			data : "siteId=" + id,
			async : false,
			success : function(result) {
				value = result;
			}
		});
		return value;
	}

	function show() {
		$.ajax({
			type : "POST",
			url : "car/queryWorkerMapCar",
			data : "userId=" + userId,
			success : function(carList) {
				if (jQuery.isEmptyObject(carList)) {
					map.clearOverlays(); //清除地图上所有覆盖物
					alert("暂未分配车辆");
				} else {
					showMap(carList[0]);
				}
			}
		});
	}

	setInterval("flushCarStatus()", 3000);
	setInterval("show()", 3000); //定时刷新map
	//setInterval("showNum()",3000);  //定时刷新空闲车辆及待处理站点数量

	/***************************** 显示主智慧泥仓************************************* */
	function showWareHouse() {
		$.ajax({
			type : "POST",
			url : "mudWareHouse/queryMainWareHouse",
			success : function(list) {
				mainWareHouse = list[0];
				wareHouseName = mainWareHouse.wareHouseName;

				myIcon = new BMap.Icon("img/warehouse.png", new BMap.Size(90,
						75), {
					imageSize : new BMap.Size(90, 75)
				});
				wareHousePoint = new BMap.Point(mainWareHouse.longitude,
						mainWareHouse.latitude);
				wareHouseMarker = new BMap.Marker(wareHousePoint, {
					icon : myIcon
				});

				map.addOverlay(wareHouseMarker);
				wareHouseMarker.addEventListener("mouseover", function() {
					wareHouseInfo()
				});
			}
		});
	}

	/***************************** 泥仓信息框显示************************************* */
	function wareHouseInfo() {
		var opts = {
			width : 130,
		}// 信息窗口宽度
		minorWareHouseList = queryWareHouse();
		var lid = '<div class="carlist"><h5>'
				+ wareHouseName
				+ '</h5><ul class="list-unstyled" style="font-size:11px;color:#777;"';
		$.each(minorWareHouseList, function(i, minorWareHouse) {
			lid += '<li>' + minorWareHouse.serialNumber + '号仓:'
					+ minorWareHouse.remainCapacity + '/'
					+ minorWareHouse.capacity + '</li>';
		});
		lid += '</ul>' + '</div>';
		wareHouseInfoWindow = new BMap.InfoWindow(lid, opts); // 创建信息窗口对象 
		map.openInfoWindow(wareHouseInfoWindow, wareHousePoint);
	}

	/***************************** 显示标注************************************* */
	function showMap(car) {
		map.clearOverlays(); //清除地图上所有覆盖物
		showWareHouse();
		if (!jQuery.isEmptyObject(car.site)) {
			var myIcon;
			myIcon = new BMap.Icon("img/factory" + car.site.status + ".png",
					new BMap.Size(100, 70), {
						imageSize : new BMap.Size(100, 70)
					});

			sitePoint = new BMap.Point(car.site.longitude, car.site.latitude);
			siteMarker = new BMap.Marker(sitePoint, {
				icon : myIcon
			});

			map.addOverlay(siteMarker);

			if (car.site.status == "2") {
				siteMarker.setAnimation(BMAP_ANIMATION_BOUNCE);
			}
			siteMarker.addEventListener("mouseover", function() {
				siteInfo(car.site);
			});
		}

		if (car.carType == 0) {
			var carIcon = new BMap.Icon("img/car.png", new BMap.Size(35, 24), {
				imageSize : new BMap.Size(35, 24)
			});
		} else {
			var carIcon = new BMap.Icon("img/transportCar.png", new BMap.Size(
					35, 35), {
				imageSize : new BMap.Size(35, 35)
			});
		}
		carPoint = new BMap.Point(car.longitude, car.latitude);
		carMarker = new BMap.Marker(carPoint, {
			icon : carIcon
		});
		map.addOverlay(carMarker);
		//鼠标悬停动作
		carMarker.addEventListener("mouseover", function() {
			carInfo(car);
		});
	}

	/***************************** 站点信息框显示************************************* */
	function siteInfo(site) {
		var value = -1;
		var opts = {
			width : 230,
		}// 信息窗口宽度
		var status;
		if (site.status == "0")
			status = "正常";
		else if (site.status == "1") {
			status = "正在处理";
		} else if (site.status == "2") {
			status = "待处理"
		}
		var lid = '<div class="carlist"><h5>'
				+ site.siteName
				+ '</h5><ul class="list-unstyled" style="font-size:11px;color:#777;">';
		if (site.status == "1") {
			var rate = queryRateOfProcess(site.id);
			if (rate == -1) {
				lid += '<li>处理进度：<span style="color: #1874CD; font-weight: bold;">数据异常</span></li>';
			} else {
				//处理进度
				rate = 100 * rate;
				lid += '<li>处理进度：<span style="color: #1874CD; font-weight: bold;">'
						+ rate.toFixed(2) + '%</span></li>';
			}
		} else if (site.status == "2") {
			var value = queryPretreatAmount(site.id);
			if (value == -1) {
				lid += '<li>预处理量：<span style="color: #1874CD; font-weight: bold;">数据异常</span></li>';
			} else if (value == 0) {
				lid += '<li>预处理量：<span style="color: #1874CD; font-weight: bold;">未设置</span></li>';
			} else {
				//预处理量
				lid += '<li>预处理量：<span style="color: #1874CD; font-weight: bold;">'
						+ value + '</span></li>';
			}
		}
		lid += '<li>Tel:' + site.telephone + '</li>';
		lid += '<li style="color:#FF4500;">状态:' + status + '</li>';
		lid += '</ul>' + '</div>';

		siteInfoWindow = new BMap.InfoWindow(lid, opts); // 创建信息窗口对象 
		map.openInfoWindow(siteInfoWindow, sitePoint);
	}

	/***************************** 车辆信息框显示************************************* */
	function carInfo(car) {
		var opts = {
			width : 230,
		} // 信息窗口宽度
		if (car.status == 4)
			var lid = '<div><h5><a href="monitor/queryVideoByDriverId?driverId='
					+ car.driverId
					+ '">'
					+ car.license
					+ '(返程中)</a></h5><table style="font-size:12px;">';
		else if (car.status == 1 && (car.siteId == null || car.siteId == ''))
			var lid = '<div><h5>' + car.license
					+ '(运输中)</h5><table style="font-size:12px;">';
		else if (car.carType == 1)
			var lid = '<div><h5>' + car.license
					+ '</h5><table style="font-size:12px;">';
		else
			var lid = '<div><h5><a href="monitor/queryVideoByDriverId?driverId='
					+ car.driverId
					+ '">'
					+ car.license
					+ '</a></h5><table style="font-size:12px;">';

		lid += '<tr><td style="width:40%;text-align: left;">司机：</td><td style="text-align: left;">'
				+ car.driver.realname
				+ '</td>'
				+ '</tr>'
				+ '<tr>'
				+ '<td style="width:40%;text-align: left;">Tel:</td><td style="text-align: left;">'
				+ car.driver.telephone + '</td>' + '</tr>';
		if (car.status == 1 && car.siteId != null && car.siteId != '') {
			var pointSite = new BMap.Point(car.site.longitude,
					car.site.latitude);
			var driving = new BMap.DrivingRoute(
					map,
					{
						onSearchComplete : function(results) {
							var plan = results.getPlan(0);
							lid += '<tr style="color:#FF4500;"><td style="width:40%;text-align: left;">目的地:</td><td style="text-align: left;">'
									+ car.site.siteName + '</td></tr>';
							lid += '<tr><td style="width:40%;text-align: left;">预计到达:</td><td style="text-align: left;">'
									+ plan.getDuration(true) + '</td></tr>';
							lid += '</table>' + '</div>';
							carInfoWindow = new BMap.InfoWindow(lid, opts); // 创建信息窗口对象 
							map.openInfoWindow(carInfoWindow, carPoint);
						}
					});
			driving.search(carPoint, pointSite);
			//alert("目的地:"+car.site.longitude+","+car.site.latitude);
		} else {
			lid += '</table>' + '</div>';
			carInfoWindow = new BMap.InfoWindow(lid, opts); // 创建信息窗口对象 
			map.openInfoWindow(carInfoWindow, carPoint);
		}
	}

	/***************************** 右下角智慧泥仓信息显示************************************* */
	function showWareHouseTable() {
		wareHouseInfo();
		$("#wareHouseTable").empty();
		var table;
		minorWareHouseList = queryWareHouse();
		$.each(minorWareHouseList, function(i, minorWareHouse) {
			table = '<tr id="' + minorWareHouse.id
					+ '" onmouseover="sel(this)" onmouseout="cle(this)")">';
			table += '<td>' + minorWareHouse.serialNumber + '号仓</td>';
			table += '<td>' + minorWareHouse.moistrueDegree * 100 + '%</td>';
			table += '<td>' + minorWareHouse.remainCapacity + '</td>';
			table += '<td>' + minorWareHouse.capacity + '</td>';
			table += '</tr>';
			$("#wareHouseTable").append(table);
		});
	}

	function sel(obj) {
		obj.style.backgroundColor = "rgba(70,130,180,0.3)";
	}
	function cle(obj) {
		obj.style.backgroundColor = "rgba(0, 0, 0, 0)";
	}

	function go(siteName) {
		$("#destination").text("目的地：" + siteName);
		$("#editContext").text("确定出发?");
		$("#myModal").modal('show');
	}

	function arrive(siteName) {
		$("#destination").text("目的地：" + siteName);
		$("#editContext").text("确定到达?");
		$("#myModal").modal('show');
	}

	$("#submitBtn").click(function() {
		var editStatus = -1;
		if (carStatus == 1)
			editStatus = 2;
		if (carStatus == 3)
			editStatus = 1;
		$.ajax({
			type : "POST",
			url : "car/editWorkerCarStatus",
			data : "userId=" + userId + "&status=" + editStatus,
			success : function(result) {
				if (result.result == "success") {
					if (carStatus == 1)
						alert("已到达");
					if (carStatus == 3)
						alert("已出发");
					$("#myModal").modal('hide');
					show();
				} else {
					alert("状态更改失败");
				}
			}
		});
	});
</script>

