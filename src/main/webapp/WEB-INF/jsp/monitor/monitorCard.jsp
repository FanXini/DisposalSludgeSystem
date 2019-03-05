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
<title>污泥处理车实时监控</title>
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
	width: 100px;
	height: 100px;
	float: center;
	display: inline;
	border: inherit 1px solid;
	padding: 5px 5px;
}

.videodiv {
	width: 50%;
	height: 50%;
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
	text-align: left;
}

.divpage {
	height: 60%;
	width: 40%;
	border-style: solid;
	border-color: blue;
	border-width: 2px;
	position: relative;
}

.sensordata0 {
	left: 50%;
	top: 50%;
	margin: 15px 15px 15px 15px;
	font-family: 宋体;
	font-weight: bold;
	font-size: 18px;
	color: #00F;
	vertical-align: middle;
	text-align: left;
}

#page-wrapper {
	position: relative;
	top: 10%;
	left: -10%;
}

.table {
	width: 600px;
}

.th {
	font-size: 90%;
	text-align: left;
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
				params.push([ key, encodeURIComponent(value) ].join('='))
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
	}
	;

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
	const ACCESS_TOKEN = "at.7vyqnxx4dc9xyra93bqxm90pbb82autv-5mljjkln0k-0hugok7-xlsvhlxd9";
	/* $.ajax({
		type:'POST',
		url:"https://open.ys7.com/api/lapp/token/get",
		//?appkey=db5f7ae9b48c430491eb921a776e4844&appSecret=2f3ee69a08cdb92566154ee837195adf
		data:JSON.stringify({
			appkey:"db5f7ae9b48c430491eb921a776e4844&appSecret",
			appSecret:"2f3ee69a08cdb92566154ee837195adf"
		}),
		//data:"appkey=db5f7ae9b48c430491eb921a776e4844&appSecret=2f3ee69a08cdb92566154ee837195adf",
		json:"jsonp",
		success:function(data){
			alert(data.code)
		}
		
	}) */
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
		return post(STOP_PTZ_URL, {
			direction ,
			accessToken ,
			deviceSerial ,
			channelNo
		})
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
				post(START_PTZ_URL, {
					direction ,
					speed ,
					accessToken ,
					deviceSerial ,
					channelNo
				})
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
		return post(LIVE_LIST_URL, {
			page ,
			count ,
			accessToken
		})
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
	<!-- 模态框   增加监控 -->
	<div class="modal inmodal" id="addModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content animated bounceInRight">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
					</button>
					<img alt="140x140" src="img/littercar.png" width="10%" height="10%" />
					<h4 class="modal-title">新增监控</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-sm-6">
							<div class="form-group">
								<label for="addSerialNumber">序&nbsp;&nbsp;列&nbsp;&nbsp;号</label>
								<input type="text" placeholder="请输入摄像头序列号" id="serialNumber"
									class="form-control m-b control-label">
							</div>

							<div class="form-group">
								<label for="video_RTMPid">RTMP&nbsp;&nbsp;地&nbsp;&nbsp;址</label>
								<input type="text" placeholder="请输入视频RTMP播放地址" id="videoRTMPid"
									class="form-control m-b control-label">
							</div>
							<div class="form-group">
								<label for="video_HLSid">HLS&nbsp;&nbsp;地&nbsp;&nbsp;址</label> <input
									type="text" placeholder="请输入视频RTMP播放地址" id="videoHLSid"
									class="form-control m-b control-label">
							</div>
						</div>
						<div class="col-sm-6">
							<div class="form-group">
								<label for="del_status">工&nbsp;&nbsp;作&nbsp;&nbsp;状&nbsp;&nbsp;态</label>
								<select class="form-control m-b" name="account" id="delStatus">
									<option value="-1">工作状态</option>
									<option value="0">在线</option>
									<option value="1">离线</option>
								</select>
							</div>

							<div class="form-group">
								<label for="license">车&nbsp;&nbsp;牌&nbsp;&nbsp;号</label> <select
									class="form-control m-b" name="account" id="addCarId">
									<option value="0">--请选择车牌号--</option>
									<c:forEach items="${requestScope.carList }" var="car">
										<option value=${car.id}>${car.license}</option>
									</c:forEach>
								</select>
								<!-- <input type="text" placeholder="请输入车牌号" id="license" class="form-control m-b control-label"> -->
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-white" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal"
						id="addVideo">保存</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 编辑监控 -->
	<!-- 修改监控信息模态框 -->
	<div class="modal fade" id="editVideoModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content animated bounceInRight">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
					</button>
					<img alt="140x140" src="img/littercar.png" width="10%" height="10%" />
					<h4 class="modal-title" id="myModalLabel">
						修改监控<input id="editId" type="hidden" />
					</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="editCarLicense">车&nbsp;&nbsp;牌&nbsp;&nbsp;号</label> <select
							class="form-control m-b" name="account" id="editCarLicense">
							<option value="0">--请选择修改监控的车牌号--</option>
							<c:forEach items="${requestScope.videoList }" var="video">
								<option value=${video.car.license}>${video.car.license}</option>
							</c:forEach>
						</select>
					</div>
					<div class="form-group">
						<label for="editSerialNumber">序&nbsp;&nbsp;列&nbsp;&nbsp;号</label>
						<input id="editSerialNumber" type="text" class="form-control"
							placeholder="请输入监控序列号">
						<%-- <select class="form-control m-b" name="account" id="editSerialNumber">										
										<option value="0">--请选修改的监控序列号--</option>
										<c:forEach items="${requestScope.videoWithoutCarList}" var="video">
											<option value=${video.serialNumber}>${video.serialNumber}</option>
										</c:forEach>
									</select>	 --%>
					</div>

					<div class="form-group">
						<label for="editvideo_RTMPid">RTMP&nbsp;&nbsp;地&nbsp;&nbsp;址</label>
						<input type="text" placeholder="请输入视频RTMP播放地址"
							id="editvideoRTMPid" class="form-control m-b control-label">
					</div>
					<div class="form-group">
						<label for="editvideo_HLSid">HLS&nbsp;&nbsp;地&nbsp;&nbsp;址</label>
						<input type="text" placeholder="请输入视频RTMP播放地址" id="editvideoHLSid"
							class="form-control m-b control-label">
					</div>

					<div class="form-group" id="editModalContent"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal"
						id="editSubmit">保存</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 删除监控 -->
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content animated bounceInRight">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
					</button>
					<img alt="140x140" src="img/littercar.png" width="10%" height="10%" />

					<h4 class="modal-title" id="myModalLabel">
						删除监控<input id="delId" type="hidden" />
					</h4>
				</div>
				<div class="modal-body" id="delModalContent">
					<!-- <p style='text-align:center;font-size:28px;color:red'>确定删除监控？</p> -->
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">否</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal"
						id="delSubmit">是</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 新增栏 -->

	<div class="add-site-btn">
		<button type="button" class="btn btn-primary" data-toggle="modal"
			data-target="#addModal">+ 新增监控</button>
	</div>
	<!-- 	查询栏 -->
	<div class="row" style="margin-top: 2%">
		<div class="search-right">
			<div class="col-xs-offset-5 col-xs-4 query-department">
				<!-- <form method="get" class="form-horizontal"> -->
				<div class="form-group">
					<div>
						<!-- <input id="queryVideoByCarLicense" type="text" class="form-control"
								placeholder="请输入车牌号/监控编号,不输入则查询所有车辆"> -->
						<select class="form-control m-b" name="account"
							id="queryVideoByCarLicense">
							<option value="0">--请选择监控所在车牌号--</option>
							<c:forEach items="${requestScope.videoList }" var="video">
								<option value=${video.car.license}>${video.car.license}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="col-xs-1 query-department">
				<button id="queryButton" class="btn btn-primary" type="button">查询</button>
			</div>
		</div>
	</div>


	<!-- 监控列表 -->
	<!-- Example Pagination -->
	<div class="page-wrapper">

		<c:forEach items="${requestScope.videoList }" var="video">
			<p
				style="text-align: center; font-family: 宋体; font-weight: bold; font-size: 24px; color: #00F">车辆${video.car.license }工作环境实时数据</p>
			<div class="row" style="margin-top: 2%">

				<div class="videodiv" id="${video.id}">
					<div class="col-sm-12">
						<p align="center">
							<video width="500px" height="300px" id='myPlayer${video.id}'
								name="play" poster="" controls playsInline webkit-playsinline>
							<source src="${video.videoRTMPid}" type=" " /> <source
								src="${video.videoHLSid}" type="application/x-mpegURL" /> </video>
						</p>
						<p align="center">
							<button type="button" class="btn btn-primary"
								onMouseover="startPtz(0,0,'${video.serialNumber }');"
								onMouseout="stopPtz(0,'${video.serialNumber }');">向上</button>
							<button type="button" class="btn btn-primary"
								onMouseover="startPtz(1,0,'${video.serialNumber }');"
								onMouseout="stopPtz(1,'${video.serialNumber }');">向下</button>
							<button type="button" class="btn btn-primary"
								onMouseover="startPtz(2,0,'${video.serialNumber }');"
								onMouseout="stopPtz(2,'${video.serialNumber }');">向左</button>
							<button type="button" class="btn btn-primary"
								onMouseover="startPtz(3,0,'${video.serialNumber }');"
								onMouseout="stopPtz(3,'${video.serialNumber }');">向右</button>
							<br /> <img class="box5" src="img/littercar.png" width="10%"
								height="10%" />
							<%-- <label class="sensordata0">${video.carId}</label> --%>
							<label class="sensordata0">${video.car.license}</label>
							<button
								onclick="editVideo(${video.id},'${video.car.license }','${video.serialNumber }')"
								class="btn btn-white btn-sm" data-toggle="modal"
								data-target="#editVideoModal">
								<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
							</button>
							<button
								onclick="deleteVideo(${video.id},'${video.car.license }');"
								class="btn btn-white btn-sm" data-toggle="modal"
								data-target="#deleteModal">
								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
							</button>
							<c:if test="${video.car.status==1 }">
								<span class="text-center block" style="font-size:20px; font-weight:900;"><mark>去往--${video.site.siteName}--途中</mark></span>
							</c:if>
							<c:if test="${video.car.status==2 }">
								<span class="text-center block" style="font-size:20px; font-weight:900;"><mark>在--${video.site.siteName}--</mark></span>
							</c:if>
						</p>
					</div>
					<!-- <div style="width:500px;position: absolute;	margin-left:500px;height:300px"> -->
					<div class="row">


						<c:forEach items="${sensorMap }" var="item">

							<c:if test="${item.key==video.carId}">

								<c:forEach items="${ item.value }" var="it">
									<div class="col-sm-4">
										<div class="contact-box">
										<c:if test="${it.status ==0}">
													<label id="${it.id}Status"
														class="label label-primary pull-right">正常</label>
												</c:if>
												<c:if test="${it.status ==1}">
													<label id="${it.id}Status"
														class="label label-danger pull-right ">异常</label>
												</c:if>
											<div class="col-sm-4">
												<label class="label">监测值</label>
												<div class="h5 text-info inline">
													<input type="hidden" id='${it.id}' name="sensorId"
														alt='${it.sensorType.type}' /> <input
														class="form-control" id='${it.id}value1'
														style="width: 135%;" readonly />
													<c:if
														test="${it.sensorType.type=='GPS传感器'||it.sensorType.type=='温湿度传感器' }">
														<input class="form-control" id='${it.id}value2'
															style="width: 135%;" readonly />
													</c:if>
												</div>
											</div>
											<div class="col-sm-8">
												<div>
													<label class="label">编号</label>
													<div class="h5 text-info inline">${it.serialNumber }</div>
												</div>
												<div>
													<label class="label">类型</label>
													<div class="h5 text-info inline">${it.sensorType.type}</div>
												</div>
												<%-- <c:if
													test="${it.sensorType.type=='氨气传感器'||it.sensorType.type=='硫化氢传感器'||it.sensorType.type=='超声波传感器'||it.sensorType.type=='液位传感器' }"> --%>
													<button class="btn btn-sm btn-info"
														onclick="javascript:showRealTimeData(${it.id },'${it.sensorType.type}')">实时数据</button>
												<%-- </c:if> --%>
											</div>
											<div class="clearfix"></div>

										</div>
									</div>



								</c:forEach>
							</c:if>
						</c:forEach>
					</div>
				</div>
			</div>
			<br>
		</c:forEach>


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
								<a class="close-link" id="clearInterval"> <i> class="fa
										fa-times"></i>
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
			    <c:forEach items="${requestScope.videoList }" var="video">
			        var player=new EZUIPlayer('myPlayer'+${video.id});
			    	player.on('error', function(){
			        console.log('error');
			    	});
			   		player.on('play', function(){
			    	    console.log('play');
			    	});
			    	player.on('pause', function(){
			        	console.log('pause');
			    	});
			   </c:forEach> 
		</script>

	<script>
				/***************************** 新增摄像头提交************************************* */
				$("#addVideo").click(function() {
					/* var carId=$("#carId").val(); */
					var license = $("#addCarId").find("option:selected").text();
					alert(license);
					var carId = parseInt($("#addCarId").val());
					var serialNumber = $("#serialNumber").val();
					var videoRTMPid = $("#videoRTMPid").val();
					var videoHLSid = $("#videoHLSid").val();
					var delStatus = $("#delStatus").val();
					$.ajax({
						type : "POST",
						url : "monitor/addVideo",
						data : JSON.stringify({
							/* carId:carId, */
							carId : carId,
							/* license:license, */
							serialNumber : serialNumber,
							videoRTMPid : videoRTMPid,
							videoHLSid : videoHLSid,
							delstatus : delStatus,
						}),
						cache : false,
						dataType : "json",
						contentType : "application/json",
						success : function(data) {
							alert("新增成功")
							//刷新当前	
							window.location.reload();
						},
						error : function(data) {
							alert("新增失败")
						}
					})
				})
			</script>
	<!-- 删除摄像头 -->
	<script>
				/***************************** 删除用户按钮************************************* */
				function deleteVideo(videoId, license) {
					var delContent = "确定删除" + license + "车上的监控";
					$("#delModalContent").html(delContent);
					$("#delId").val(videoId);
				}
				/***************************** 删除监控************************************* */
				$("#delSubmit").click(function() {
					var videoId = $("#delId").val();
					alert(videoId)
					$.ajax({
						type : "POST",
						url : "monitor/deletevideo",
						data : "videoId=" + videoId,
						success : function() {
							alert("删除成功")
							$('#deleteModal').modal('hide');
							$("#" + videoId.toString()).remove()
							window.location.reload();
						}
					});
				});
			
				/***************************** 修改监控按钮************************************* */
				function editVideo(videoId, license, SerialNumber) {
					var editContent = "确定修改" + license + "车上的监控" + SerialNumber;
					$("#editModalContent").html(editContent);
					$("#editId").val(videoId);
				}
			
				/*----------------------------------- 确认修改 ------------------------------------------*/
				$("#editSubmit").click(function() {
					var videoId = parseInt($("#editId").val());
					var SerialNumber = $("#editSerialNumber").val()
					var license = $("#editCarLicense").val()
					var videoRTMPid = $("#editvideoRTMPid").val();
					var videoHLSid = $("#editvideoHLSid").val();
					alert(videoId)
					alert(SerialNumber)
					alert(license)
					$.ajax({
						type : "POST",
						url : "monitor/editVideo",
						/* data: "videoId=" + videoId, */
						data : JSON.stringify({
							id : videoId,
							serialNumber : SerialNumber,
							/* license:license, */
							videoRTMPid : videoRTMPid,
							videoHLSid : videoHLSid,
						}),
						cache : false,
						dataType : "json",
						contentType : "application/json",
						success : function(data) {
							alert("修改成功")
							$('#editVideoModal').modal('hide');
							window.location.reload();
						},
						error : function(data) {
							alert("修改失败")
						}
					});
				});
			
				/***************************** 按照车牌号查询监控************************************* */
				$("#queryButton").click(function() {
					var carLicense = $("#queryVideoByCarLicense").val();
					$.ajax({
						type : "POST",
						url : "monitor/queryVideoByCarLicense",
						data : "license=" + carLicense,
						jsonpcallback : function() {},
						success : function(data) {
			
							$(".video").html(
			
								'<video class="box5" id="myPlayer' + data.id + '" poster="" controls playsInline webkit-playsinline autoplay>'
								+ '<source src="' + data.videoRTMPid + '" type="" />'
								+ '<source src="' + data.videoHLSid + '" type="application/x-mpegURL" />'
								+ '</video>'
								+ '<br/><button type="button" style=" margin-right:60px" class="btn btn-primary" onMouseover="startPtz(0,0,\'' + data.serialNumber + '\');" onMouseout="stopPtz(0,\'' + data.serialNumber + '\');">向上</button>'
								+ '<button type="button" style="margin-right:60px" class="btn btn-primary" onMouseover="startPtz(1,0,\'' + data.serialNumber + '\');" onMouseout="stopPtz(1,\'' + data.serialNumber + '\');">向下</button>'
								+ '<button type="button" style="margin-right:60px" class="btn btn-primary" onMouseover="startPtz(2,0,\'' + data.serialNumber + '\');" onMouseout="stopPtz(2,\'' + data.serialNumber + '\');">向左</button>'
								+ '<button type="button" style="margin-right:60px" class="btn btn-primary" onMouseover="startPtz(3,0,\'' + data.serialNumber + '\');" onMouseout="stopPtz(3,\'' + data.serialNumber + '\');">向右</button> <br/>'
							);
			
							var player = new EZUIPlayer('myPlayer' + data.id);
							player.on('error', function() {
								console.log('error');
							});
							player.on('play', function() {
								console.log('play');
							});
							player.on('pause', function() {
								console.log('pause');
							});
						}
					});
				});
			
				function searchCallBack(id) {
					alert(id);
			
			
				}
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
			var carStatus;
			var historyData={};
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
			var updateInputValue=setInterval(queryRealTimeValueToText,2000);
			var sensorList=document.getElementsByName("sensorId");
			var sensorNum=sensorList.length;
			function queryRealTimeValueToText(){
				for(var i=0;i<sensorNum;i++){
					var sensorId=sensorList[i].getAttribute("id");
					var sensorType=sensorList[i].getAttribute("alt");
					$.ajax({
						type : "POST",
						url : "sensor/queryRealTimeValue?sensorId=" + parseInt(sensorId),
						async:false,
						success : function(sensorValue) {
							if(historyData[sensorId]==null){
								historyData[sensorId]={};
							}else{
								if(sensorType=="超声波传感器"){
									var diff=parseFloat(sensorValue.value1)-parseFloat(historyData[sensorId].value1);
									if((carStatus==0||carStatus==3)&&diff>10){
										console.log("异常");
										$("#"+sensorId+"Status").attr("class","label label-danger pull-right ");
										$("#"+sensorId+"Status").html('异常')
									}
									
									if(sensorValue.value1>500){
										$("#"+sensorId+"Status").attr("class","label label-danger pull-right ");
										$("#"+sensorId+"Status").html('请添加干化剂')
									}										
								}
								else if(sensorType=="液位传感器"){
									var diff=parseFloat(sensorValue.value1)-parseFloat(historyData[sensorId].value1);
									if((carStatus==0||carStatus==3)&&Math.abs(diff)>5){
										console.log("异常");
										$("#"+sensorId+"Status").attr("class","label label-danger pull-right ");
										$("#"+sensorId+"Status").html('异常')
									}
									
									if(sensorValue.value1<25){
										$("#"+sensorId+"Status").attr("class","label label-danger pull-right ");
										$("#"+sensorId+"Status").html('请添加干化剂')
									}		
								}
							}
							if(sensorType=="温湿度传感器"){
								if(sensorValue.value1<=40&&sensorValue.value2>=30&&sensorValue.value2<=80){
									$("#"+sensorId+"Status").attr("class","label label-primary pull-right ");
									$("#"+sensorId+"Status").html('正常');
								}else{
									$("#"+sensorId+"Status").attr("class","label label-danger pull-right ");
									$("#"+sensorId+"Status").html('异常');
								}
							}
							if(sensorType=="氨气传感器"){
								console.log(sensorValue.value1)
								if(sensorValue.value1>=0 && sensorValue.value1<=8){
									$("#"+sensorId+"Status").attr("class","label label-primary pull-right ");
									$("#"+sensorId+"Status").html('正常');
								}else{
									$("#"+sensorId+"Status").attr("class","label label-danger pull-right ");
									$("#"+sensorId+"Status").html('异常');
								}
							}
							if(sensorType=="硫化氢传感器"){
								if(sensorValue.value1>=0 &&sensorValue.value1<=10){
									$("#"+sensorId+"Status").attr("class","label label-primary pull-right ");
									$("#"+sensorId+"Status").html('正常');
								}else{
									$("#"+sensorId+"Status").attr("class","label label-danger pull-right ");
									$("#"+sensorId+"Status").html('异常');
								}
							}
							console.log(sensorValue.value1)
							$("#"+sensorId+"value1").val(sensorValue.value1)
							if(sensorValue.value2!=0){
								historyData[sensorId].value2=sensorValue.value2;
								$("#"+sensorId+"value2").val(sensorValue.value2)
								/* var testRandowValue1=(21+Math.random()*2).toFixed(2)
								var testRandowValue2=(35+Math.random()*2).toFixed(2) */
							}
							historyData[sensorId].value1=sensorValue.value1;
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
						//var testRandowValue=(1+Math.random()*0.5).toFixed(2)
						globalData.push(sensorValue.value1)
						//globalData.push(testRandowValue)
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
