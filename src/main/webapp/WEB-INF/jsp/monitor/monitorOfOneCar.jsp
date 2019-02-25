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
<title>实时监控</title>
<meta charset="UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta name="viewport"
	content="width=device-width,initial-scale=1,maximum-scale=1.0" />
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="renderer" content="webkit">
<link rel="shortcut icon" href="favicon.ico">
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="shortcut icon" href="favicon.ico">
<link href="css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
<link href="css/animate.css" rel="stylesheet">
<link href="css/style.css?v=4.1.0" rel="stylesheet">
<link href="css/plugins/dataTables/dataTables.bootstrap.css"
	rel="stylesheet">
<link href="css/plugins/chosen/chosen.css" rel="stylesheet">
<!-- 全局js -->
<script src="js/jquery.min.js?v=2.1.4"></script>
<script src="js/bootstrap.min.js?v=3.3.6"></script>
<script src="js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="js/plugins/layer/layer.min.js"></script>
<!-- 自定义js -->
<script src="js/hAdmin.js?v=4.1.0"></script>
<!-- 第三方插件 -->
<script src="js/plugins/pace/pace.min.js"></script>
<style>
.body {
	height: 100%;
}

.search-content {
	margin-top: 2%;
	height: 36px;
}

.search-right {
	width: 50%;
	float: right;
}

.search-left {
	width: 50%;
	float: left;
}

.add-site-btn {
	padding: 1 1;
	float: left;
	margin: 20px auto 5px 101px;
}

.query-site-btn {
	padding: 1px;
	float: right;
}

.col-sm-12 {
	top: auto;
}

.td {
	width: 400px;
}

.form-group {
	bottom: 5px;
}

.box2 {
	width: 100px;
	float: center;
	display: inline;
	border: inherit 1px solid;
}

.box3 {
	width: 100px;
	float: center;
	display: inline;
	border: inherit 1px solid;
}

.box5 {
	width: 50px;
	height: 50px;
	float: center;
	display: inline;
	border: inherit 1px solid;
	padding: 5px 5px;
}

.box6 {
	width: 50px;
	float: center;
	display: inline;
	border: inherit 1px solid;
	padding: 5px 15px;
}

.divlicense {
	float: center;
	left: 50%;
	top: 50%;
	margin: 15px 15px 15px 15px;
	font-family: 宋体;
	font-weight: bold;
	font-size: 16px;
	vertical-align: middle;
	text-align: center;
}

#page-wrapper {
	position: relative;
	top: 10%;
	left: -10%;
}

#box {
	margin: 20px auto;
	width: 600px;
	height: 150px;
	padding: 5px;
}
</style>
<script>	
		/**
		 * 将对象编码成请求字符串
		 * @param {any} obj 要编码的对象
		 */
		function encodeRequestParams(obj) {
		    if (!obj) {
		        return ''
		    }
		    const params = []
		
		    Object.keys(obj).forEach((key) => {
		        let value = obj[key]
		        if (value !== null && value !== undefined && value !== '') {
		            params.push([key, encodeURIComponent(value)].join('='))
		        }
		    })
		    let paramsString = params.join('&')
		    if (paramsString.length == 0) {
		        return ""
		    }
		    return paramsString;
		}		
		/**
		 * get请求，返回Promise
		 * @param {string} url 请求地址
		 */
		function get(url) {
		    return new Promise((resolve, reject) => {
		        const xhr = new XMLHttpRequest();
		        xhr.onreadystatechange = () => {
		            if (xhr.readyState === 4) {
		                if (xhr.status >= 200 && (xhr.status < 300 || xhr.status === 304)) {
		                    if (xhr.responseText) {
		                        resolve(JSON.parse(xhr.responseText));
		                    } else {
		                        resolve(xhr.responseText);
		                    }
		                } else {
		                    reject(`XHR unsuccessful:${xhr.status}`);
		                }
		            }
		        };
		        xhr.open('get', url, true);
		        xhr.setRequestHeader('content-type', 'application/x-www-form-urlencoded');
		        xhr.send(null);
		    });
		};
		
		/**
		 * post请求
		 * @param {string} url 请求地址
		 * @param {any} data 请求参数
		 */
		function post(url, data) {
		    return new Promise((resolve, reject) => {
		        const xhr = new XMLHttpRequest();
		        xhr.onreadystatechange = () => {
		            if (xhr.readyState === 4) {
		                if (xhr.status >= 200 && (xhr.status < 300 || xhr.status === 304)) {
		                    resolve(JSON.parse(xhr.responseText));
		                } else {
		                    reject(`XHR unsuccessful:${xhr.status}`);
		                }
		            }
		        };
		        xhr.open('post', url, true);
		        xhr.setRequestHeader('content-type', 'application/x-www-form-urlencoded');
		        xhr.send(encodeRequestParams(data));
		    });
		}		
		// accessToken会自动失效，需要通过后端请求刷新。详见 https://open.ys7.com/doc/zh/book/index/user.html
		const ACCESS_TOKEN = "at.7a9efc6w4apudpcxcz0dfwo9b1cwqkyb-1vwccihfsn-1ema48b-ejz5ohwfa";		
		/* const DEVICE_SERIAL = "C29134495"; */
		const CHANNEL_NO = 1;
		const START_PTZ_URL = "https://open.ys7.com/api/lapp/device/ptz/start";
		const STOP_PTZ_URL = "https://open.ys7.com/api/lapp/device/ptz/stop";
		const LIVE_LIST_URL = "https://open.ys7.com/api/lapp/live/video/list"		
		/**
		 * 停止云台
		 * @param {int} direction 方向，不必须：0-上，1-下，2-左，3-右，4-左上，5-左下，6-右上，7-右下，8-放大，9-缩小，10-近焦距，11-远焦距
		 * @param {string} accessToken 访问Token，必须
		 * @param {int} deviceSerial 设备序列号，必须
		 * @param {int} channelNo 通道，必须
		 */
		function stopPtz(direction, deviceSerial, accessToken = ACCESS_TOKEN, channelNo = CHANNEL_NO) {
		 
		    return post(STOP_PTZ_URL, { direction, accessToken, deviceSerial, channelNo })
		        .then(response => {
		            if (response.code != 200) {
		                throw response;
		            }
		            console.log("停止成功");
		        })
		        .catch(error => {
		            throw error;
		        })
		}		
		/**
		/**
		 * 启动云台
		 * @param {int} direction 方向，必须：0-上，1-下，2-左，3-右，4-左上，5-左下，6-右上，7-右下，8-放大，9-缩小，10-近焦距，11-远焦距
		 * @param {*} speed 云台速度，必须：0-慢，1-适中，2-快
		 * @param {string} accessToken 访问Token，必须
		 * @param {int} deviceSerial 设备序列号，必须
		 * @param {int} channelNo 通道，必须
		 */
		function startPtz(direction, speed, deviceSerial, accessToken = ACCESS_TOKEN, channelNo = CHANNEL_NO) {
		    // 要启动，需要先停止
		    
		    return stopPtz(direction, deviceSerial)
		        .then(_ => {
		            post(START_PTZ_URL, { direction, speed, accessToken, deviceSerial, channelNo })
		                .then(response => {
		                    if (response.code != 200) {
		                        throw response;
		                    }
		                    console.log("启动成功");
		                })
		                .catch(error => {
		                    throw error;
		                });
		        })
		        .catch(error => {
		            throw error;
		        })
		}				
		/**
		 * 获取播放地址列表
		 * @param {int} page 页
		 * @param {int} count 页大小，最大50
		 * @param {string} accessToken 
		 */
		function requestLiveList(page = 0, count = 50, accessToken = ACCESS_TOKEN) {
		    return post(LIVE_LIST_URL, { page, count, accessToken })
		        .then(response => {
		            if (response.code != 200) {
		                throw response;
		            }
		            console.log("获取直播列表成功");
		            return response;
		        })
		        .catch(error => {
		            throw error;
		        });
		}
		

</script>
</head>
<body>
	<script src="https://open.ys7.com/sdk/js/1.3/ezuikit.js"></script>
	<!-- 摄像头-->
	<!-- Example Pagination -->
	<div id="box" class="container-fluid">
		<div class="row clearfix video">
			<div class="col-md-12 column">
				<div class="" id="${requestScope.video.id}">
					<div>
						<video class="box5" id='myPlayer${requestScope.video.id}'
							name="play" poster="" controls playsInline webkit-playsinline
							autoplay> <source src="${requestScope.video.videoRTMPid}"
							type=" " /> <source src="${requestScope.video.videoHLSid}"
							type="application/x-mpegURL" /> </video>
					</div>
					<div class="divlicense">
						<button type="button" class="btn btn-primary"
							onMouseover="startPtz(0,0,'${requestScope.video.serialNumber }');"
							onMouseout="stopPtz(0,'${video.serialNumber }');">向上</button>
						<button type="button" class="btn btn-primary"
							onMouseover="startPtz(1,0,'${requestScope.video.serialNumber }');"
							onMouseout="stopPtz(1,'${video.serialNumber }');">向下</button>
						<button type="button" class="btn btn-primary"
							onMouseover="startPtz(2,0,'${requestScope.video.serialNumber }');"
							onMouseout="stopPtz(2,'${video.serialNumber }');">向左</button>
						<button type="button" class="btn btn-primary"
							onMouseover="startPtz(3,0,'${requestScope.video.serialNumber }');"
							onMouseout="stopPtz(3,'${video.serialNumber }');">向右</button>
						<br /> <img class="box5" alt="140x140" src="img/littercar.png"
							width="10%" height="10%" />
						<p class="box6" style="text-align: center;">${video.car.license}</p>
					</div>
				</div>
			</div>
		</div>


	</div>
	<div class="col-sm-12">	
	<div class="ibox">
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
									<!-- <div class="text-center">
													<img alt="image" class="img-circle m-t-xs img-responsive"
														src="img/littercar.png">
													<div class="m-t-xs font-bold">设备照片</div>
												</div> -->
									<div>
										<label class="label">监测值</label>
										<div class="h5 text-info inline">
											<input class="form-control" id='${sensor.id}' name="sensorId"
												style="width: 135%;" readonly />
											<c:if
												test="${sensor.sensorType.type=='GPS传感器'||sensor.sensorType.type=='温湿度传感器' }">
												<input class="form-control" id='${sensor.id}value2'
													style="width: 135%;" readonly />
											</c:if>
										</div>
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
									<c:if
										test="${sensor.sensorType.type=='氨气传感器'||sensor.sensorType.type=='硫化氢传感器' }">
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
	<!--  HistoryDataModel -->
	<div class="modal inmodal" id="myModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content animated bounceInRight">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>监测中</h5>
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

	<!-- End Example Pagination -->
	<!-- 全局js -->
	<script src="js/jquery.min.js?v=2.1.4"></script>
	<script src="js/bootstrap.min.js?v=3.3.6"></script>
	<!-- 自定义js -->
	<script src="js/content.js?v=1.0.0"></script>
	<!-- Bootstrap table -->
	<script src="js/plugins/jeditable/jquery.jeditable.js"></script>
	<!-- Data Tables -->
	<script src="js/plugins/dataTables/jquery.dataTables.js"></script>
	<script src="js/plugins/dataTables/dataTables.bootstrap.js"></script>
	<!-- 自定义js -->
	<script src="js/content.js?v=1.0.0"></script>
	<!-- jQuery Validation plugin javascript-->
	<script src="js/plugins/validate/jquery.validate.min.js"></script>
	<script src="js/plugins/validate/messages_zh.min.js"></script>
	<script src="js/system/form-validate-siteManage.js"></script>
	<!-- distpicker -->
	<script src="js/distpicker/distpicker.data.js"></script>
	<script src="js/distpicker/distpicker.js"></script>
	<script src="js/distpicker/main.js"></script>
	<!-- Chosen -->
	<script src="js/plugins/chosen/chosen.jquery.js"></script>
	<!-- 全局js -->
	<script src="js/plugins/flot/jquery.flot.js"></script>
	<script src="js/plugins/flot/jquery.flot.tooltip.min.js"></script>
	<script src="js/plugins/flot/jquery.flot.resize.js"></script>
	<script src="js/plugins/flot/jquery.flot.pie.js"></script>
	<!-- 自定义js -->
	<script src="js/content.js?v=1.0.0"></script>
	<script type="text/javascript" src="js/plugins/chartJs/Chart.js"></script>
	<script>   
		$(document).ready(function(){
			 var player=new EZUIPlayer('myPlayer'+${requestScope.video.id});
		    	player.on('error', function(){
		        console.log('error');
		    	});
		   		player.on('play', function(){
		    	    console.log('play');
		    	});
		    	player.on('pause', function(){
		        	console.log('pause');
		    	});
		})
  
	</script>
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
						max : 3
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
					series[0].data = queryRealTimeValue(sensorId); //只更新最前的数据
					plot.setData(series);
					plot.draw();
				}, 1000);
			}
			/* 查询出10条最早的历史记录 */
			function sensorData(sensorId, sensorType) {
				var data = [];
				var carId = $("#queryVideoByCarLicense").val();
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
			interval=setInterval(queryRealTimeValueToText,1000);
			var sensorList=document.getElementsByName("sensorId");
			var sensorNum=sensorList.length;
			function queryRealTimeValueToText(){
				for(var i=0;i<sensorNum;i++){
					var sensorId=sensorList[i].getAttribute("id");
					$.ajax({
						type : "POST",
						url : "sensor/queryRealTimeValue?sensorId=" + parseInt(sensorId),
						async:false,
						success : function(sensorValue) {
							//$("#"+sensorId).val(value)
							if(sensorValue.value2!=0){
								var testRandowValue1=(21+Math.random()*2).toFixed(2)
								var testRandowValue2=(35+Math.random()*2).toFixed(2)
								$("#"+sensorId).val(testRandowValue1)
								$("#"+sensorId+"value2").val(testRandowValue2)
							}else{
								var testRandowValue=(1+Math.random()*0.5).toFixed(2)
								$("#"+sensorId).val(testRandowValue)
							}
						}
					})
				}
			}
			
			/* 查询此时最新的数据 */
			function queryRealTimeValue(sensorId) {
			    var res=[]
				$.ajax({
					type : "POST",
					url : "sensor/queryRealTimeValue?sensorId=" + parseInt(sensorId),
					async:false,
					success : function(sensorValue) {
						globalData.shift();
						var testRandowValue=(1+Math.random()*0.5).toFixed(2)
						globalData.push(sensorValue.value1)
						globalData.push(testRandowValue)
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
