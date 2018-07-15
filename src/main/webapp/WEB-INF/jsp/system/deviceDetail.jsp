<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>设备详情页面</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,
initial-scale=1.0">


<link rel="shortcut icon" href="favicon.ico">
<link href="css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="css/font-awesome.css?v=4.4.0" rel="stylesheet">

<link href="css/animate.css" rel="stylesheet">
<link href="css/style.css?v=4.1.0" rel="stylesheet">

</head>

<body class="gray-bg">
	<!--  HistoryDataModel -->
	<div class="modal inmodal" id="myModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content animated bounceInRight">

				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>动态图</h5>
							<div class="ibox-tools">
								<a class="close-link" id="clearInterval"> <i
									class="fa fa-times"></i>
								</a>
							</div>
						</div>
						<div class="ibox-content">

							<div class="flot-chart">
								<div class="flot-chart-content" id="flot-line-chart-moving"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<div class="wrapper wrapper-content animated fadeInUp">
				<div class="ibox">
					<div class="ibox-content">
						<div class="row">
							<div class="col-sm-12">
								<div class="m-b-md">
									<!-- <a href="project_detail.html#"
										class="btn btn-white btn-xs pull-right">返回</a> -->
									<h2>${requestScope.location }</h2>
								</div>
							</div>
						</div>

					</div>
					<!-- 内容 -->
					<div class="wrapper wrapper-content animated fadeInRight">
						<div class="row">
							<c:forEach items="${requestScope.sensorList}" var="sensor">
								<div class="col-sm-3">
									<div class="contact-box">
										<c:if test="${sensor.status ==0}">
											<label class="label label-primary pull-right ">正常</label>
										</c:if>
										<c:if test="${sensor.status ==1}">
											<label class="label label-danger pull-right ">异常</label>
										</c:if>

										<div class="row">
											<div class="col-sm-4">
												<div class="text-center">
													<img alt="image" class="img-circle m-t-xs img-responsive"
														src="img/littercar.png">
													<div class="m-t-xs font-bold">设备照片</div>
												</div>
											</div>
											<div class="col-sm-8">
												<div>
													<label class="label">编号</label>
													<div class="h5 text-info inline">${sensor.serialNumber }</div>
												</div>
												<div>
													<label class="label">类型</label>
													<div class="h5 text-info inline">${sensor.sensorType.type}</div>
												</div>
												<c:if test="${sensor.sensorType.type=='超声波传感器' }">
													<button class="btn btn-sm btn-info"
														onclick="javascript:showRealTimeData(${sensor.id },'${sensor.sensorType.type}')">实时数据</button>

												</c:if>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>

						</div>
					</div>
				</div>
			</div>

		</div>

		<!-- 全局js -->
		<script src="js/jquery.min.js?v=2.1.4"></script>
		<script src="js/bootstrap.min.js?v=3.3.6"></script>

		<script src="js/content.js?v=1.0.0"></script>

		<script src="js/plugins/flot/jquery.flot.js"></script>
		<script src="js/plugins/flot/jquery.flot.tooltip.min.js"></script>
		<script src="js/plugins/flot/jquery.flot.resize.js"></script>
		<script src="js/plugins/flot/jquery.flot.pie.js"></script>


		<!-- 自定义js -->
		<script src="js/content.js?v=1.0.0"></script>

		<script type="text/javascript" src="js/plugins/chartJs/Chart.js"></script>


		<script>
		
			$(function() {
				//可以这样迭代函数
				$('.contact-box').each(function() {
					animationHover(this, 'pulse');
				});
			});
			var property={
					grid : {
						color : "#999999",
						tickColor : "#D4D4D4",
						borderWidth : 0,
						minBorderMargin : 20,
						labelMargin : 10,
						backgroundColor : {
							colors : [ "#ffffff", "#ffffff" ]
						},
						margin : {
							top : 8,
							bottom : 20,
							left : 20
						},
						markings : function(axes) {
							var markings = [];
							var xaxis = axes.xaxis;
							for (var x = Math.floor(xaxis.min); x < xaxis.max; x += xaxis.tickSize * 2) {
								markings.push({
									xaxis : {
										from : x,
										to : x + xaxis.tickSize
									},
									color : "#fff"
								});
							}
							return markings;
						}
					},
					colors : [ "#1ab394" ],
					xaxis : {
						tickFormatter : function() {
							return "";
						}
					},
					yaxis : {
						min : 0,
						max : 500
					},
					legend : {
						show : true
					}
				}
		
			var globalData = null;
			var interval=null;
			function showRealTimeData(sensorId, sensorType) {
				var container = $("#flot-line-chart-moving");
				globalData = sensorData(sensorId, sensorType)
				var res=[];
				for(var i=0;i<globalData.length;i++){
					res.push([i,globalData[i]])
				}
				series = [ {
					data : res,
					lines : {
						fill : true
					}
				} ];
		
				var plot = $.plot(container, series,property);
				
				$("#myModal").modal("show")
		
				// Update the random dataset at 25FPS for a smoothly-animating chart
		
				interval=setInterval(function updateRandom() {
					series[0].data = queryRealTimeValue(sensorId);
					plot.setData(series);
					plot.draw();
				}, 500);
			}
			/* 查询出10条最早的历史记录 */
			function sensorData(sensorId, sensorType) {
				var data = [];
				$.ajax({
					type : "POST",
					url : "sensor/queryHistoryData",
					data : JSON.stringify({
						sensorId : sensorId,
						sensorType : sensorType
					}),
					async : false,
					dataType : "json",
					contentType : "application/json",
					success : function(historyData) {
						data = historyData;
					}
				})
				return data;
			}
			/* 查询此时最新的数据 */
			function queryRealTimeValue(sensorId) {
			    var res=[]
				$.ajax({
					type : "POST",
					url : "sensor/queryRealTimeValue?sensorId=" + parseInt(sensorId),
					async:false,
					success : function(value) {
						globalData.shift();
						globalData.push(value)
						for (var i = 0; i < globalData.length; i++) {
							res.push([ i, globalData[i]])
						}
					}
				})
				return res;
			}
			
			$("#clearInterval").click(function(){
				$("#myModal").modal('hide');
				clearInterval(interval);
				interval=null;
			})
		</script>
</body>

</html>
