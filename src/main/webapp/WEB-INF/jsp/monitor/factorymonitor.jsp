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
<title>污泥处理厂实时监控</title>
     <meta charset="UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1.0" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" >
    <meta name="renderer" content="webkit">
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
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
	float:left;
	margin:20px auto 5px 101px;
    
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
			height:50px;
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
			font-weight:bold;
			font-size: 16px;
			vertical-align: middle;
			text-align: center;
			}
#page-wrapper{
            position:relative;
            top:10%;
            left:-10%;           	
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
		const ACCESS_TOKEN = "at.dr31pta092dj6h7l54uyc27dbh55n0r7-6ber269c57-01a6v3f-we6zziltc";
		
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
	<!-- 模态框   增加监控 -->
	<div class="modal inmodal" id="addModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content animated bounceInRight">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
					</button> <img alt="140x140" src="img/littercar.png" width="10%" height="10%" />
					<h4 class="modal-title">新增监控</h4>
			</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-sm-6">
							<div class="form-group">
								<label for="addSerialNumber">序&nbsp;&nbsp;列&nbsp;&nbsp;号</label> <input type="text"
									placeholder="请输入摄像头序列号" id="serialNumber"
									class="form-control m-b control-label">
							</div>
						
							<div class="form-group">
								<label for="video_RTMPid">RTMP&nbsp;&nbsp;地&nbsp;&nbsp;址</label> <input
									type="text" placeholder="请输入视频RTMP播放地址" id="videoRTMPid"
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
								<label for="license">工&nbsp;&nbsp;厂&nbsp;&nbsp;名&nbsp;&nbsp;称</label>
								<select class="form-control m-b" name="account" id="addSiteId">										
										<option value="0">--请选择工厂--</option>
										<c:forEach items="${requestScope.siteList }" var="site">
											<option value=${site.id}>${site.siteName}</option>
										</c:forEach>
									</select>
								<!-- <input type="text" placeholder="请输入车牌号" id="license" class="form-control m-b control-label"> --> 					
							</div>
							
							
						</div>

					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-white" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="addVideo">保存</button>
			</div>
			</div>
		</div>
	</div>	
	<!-- 编辑监控 -->
	<!-- 修改监控信息模态框 -->
	<div class="modal fade" id="editVideoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content animated bounceInRight">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
					</button> <img alt="140x140" src="img/littercar.png" width="10%" height="10%" />
					<h4 class="modal-title" id="myModalLabel">
						修改监控<input id="editId" type="hidden" />
					</h4>
			</div>			
				<div class="modal-body">
					<div class="form-group">
								<label for="editSiteName">工&nbsp;&nbsp;厂&nbsp;&nbsp;名&nbsp;&nbsp;称</label>
								<select class="form-control m-b" name="account" id="editSiteName">										
										<option value="0">--请选择修工厂名--</option>
										<c:forEach items="${requestScope.videoList }" var="video">
											<option value=${video.site.siteName}>${video.site.siteName}</option>
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
								<label for="editSerialNumber">工&nbsp;&nbsp;作&nbsp;&nbsp;状&nbsp;&nbsp;态</label> 																	
									<select class="form-control m-b" name="account" id="editStatus">
									<option value="-1">请选择监控的工作状态</option>
									<option value="0">在线</option>
									<option value="1">离线</option>
								</select>
					</div>	
					<div class="form-group" id="editModalContent">
								
					</div>								
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="editSubmit">保存</button>	
			</div>
			</div>
		</div>
	</div>	
		
	<!-- 删除监控 -->
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content animated bounceInRight">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
					</button> <img alt="140x140" src="img/littercar.png" width="10%" height="10%" />
					
					<h4 class="modal-title" id="myModalLabel">
						删除监控<input id="delId" type="hidden" />
					</h4>
			</div>
				<div class="modal-body" id="delModalContent">
					<!-- <p style='text-align:center;font-size:28px;color:red'>确定删除监控？</p> -->					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">否</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="delSubmit">是</button>
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
								<select class="form-control m-b" name="account" id="queryVideoBySiteName">										
										<option value="0">--请选择监控所在工厂--</option>
										<c:forEach items="${requestScope.videoList }" var="video">
											<option value=${video.site.siteName}>${video.site.siteName}</option>
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
		<div id="page-wrapper"  class="container-fluid">
			<div class="row clearfix video">
		<c:forEach items="${requestScope.videoList }" var="video">
			<div class="col-md-4 column" >
				<div class="" id="${video.id}">
					<div>
						<video class="box5" id='myPlayer${video.id}' name="play" poster="" controls playsInline webkit-playsinline autoplay>
					    <source src="${video.videoRTMPid}" type=" " />
						<source src="${video.videoHLSid}" type="application/x-mpegURL" />
						</video>
					</div>
					<div class="divlicense">
						<button type="button" class="btn btn-primary" onMouseover="startPtz(0,0,'${video.serialNumber }');" onMouseout="stopPtz(0,'${video.serialNumber }');">向上</button>
						<button type="button" class="btn btn-primary" onMouseover="startPtz(1,0,'${video.serialNumber }');" onMouseout="stopPtz(1,'${video.serialNumber }');">向下</button>
						<button type="button" class="btn btn-primary" onMouseover="startPtz(2,0,'${video.serialNumber }');" onMouseout="stopPtz(2,'${video.serialNumber }');">向左</button>
						<button type="button" class="btn btn-primary"onMouseover="startPtz(3,0,'${video.serialNumber }');" onMouseout="stopPtz(3,'${video.serialNumber }');">向右</button> <br/>
						<img class="box5" alt="140x140" src="img/littercar.png" width="10%" height="10%" />
						<p class="box6" style="text-align:center;">${video.car.license}</p>
						<button onclick="editFactoryVideo(${video.id},'${video.site.siteName }','${video.serialNumber }','${video.delStatus}')"
									class="btn btn-white btn-sm" data-toggle="modal"
									data-target="#editVideoModal">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
						</button>
						<button onclick="deleteVideo(${video.id},'${video.site.siteName }');"
								class="btn btn-white btn-sm" data-toggle="modal"
								data-target="#deleteModal">
								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
						</button>
					</div>
				</div>
			</div>
		</c:forEach>
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
				var license=$("#addSiteId").find("option:selected").text();
				alert(license);
				var siteId = parseInt($("#addSiteId").val());
				var serialNumber = $("#serialNumber").val();
				var videoRTMPid = $("#videoRTMPid").val();
				var videoHLSid = $("#videoHLSid").val();
				var delStatus = $("#delStatus").val();
				$.ajax({
					type : "POST",
						url :　"monitor/addFactoryVideo",
						data : JSON.stringify({
						/* carId:carId, */
						siteId:siteId,
						license:license,
						serialNumber:serialNumber,
						videoRTMPid:videoRTMPid,
						videoHLSid:videoHLSid,
						delstatus:delStatus,
						}),
						cache:false,
						dataType : "json",
						contentType : "application/json",
						success : function(data){
								alert("新增成功")
								//刷新当前			
						},
						error:function(data){
							alert("新增失败")
						}
				})
			})
					
	</script>		
	<!-- 删除摄像头 -->
	<script>	
		/***************************** 删除用户按钮************************************* */
		function deleteVideo(videoId,license) {
			var delContent = "确定删除"+license+"工厂的监控";
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
				data: "videoId=" + videoId,
				success : function() {
					alert("删除成功")
					$('#deleteModal').modal('hide');
					$("#" + videoId.toString()).remove()
				}
			});
		});
		
/***************************** 修改监控按钮************************************* */
		function editFactoryVideo(videoId,license,SerialNumber) {
			var editContent = "确定修改"+license+"车上的监控"+SerialNumber;
			$("#editModalContent").html(editContent);
			$("#editId").val(videoId);
		}	
		
	/*----------------------------------- 确认修改 ------------------------------------------*/			
			$("#editSubmit").click(function() {
			var videoId = parseInt($("#editId").val());
			var SerialNumber = $("#editSerialNumber").val()
			var license = $("#editSiteName").val()
			var delStatus = $("#editdelStatus").val()
			alert(videoId)
			alert(SerialNumber)
			alert(license)
			$.ajax({
				type : "POST",
				url : "monitor/editFactoryVideo",
				/* data: "videoId=" + videoId, */
				data:JSON.stringify({
					id:videoId,
					serialNumber:SerialNumber,
					license:license,
					delStatus:delStatus
				}),
				cache:false,
				dataType : "json",
				contentType : "application/json",
				success : function(data) {
					alert("修改成功")
					$('#editVideoModal').modal('hide');
				},
				error:function(data){
					alert("修改失败")
				}
			});
		});	
		
		/***************************** 按照工厂名称查询监控************************************* */
		$("#queryButton").click(function() {
			var siteName = $("#queryVideoBySiteName").val();
			$.ajax({
				type : "POST",
				url : "monitor/queryVideoBySiteName",
				data: "license=" + siteName,
				jsonpcallback: function(){
				},
				success : function(data) {
				
					$(".video").html(
					
					'<video class="box5" id="myPlayer'+data.id+'" poster="" controls playsInline webkit-playsinline autoplay>'
					+'<source src="'+data.videoRTMPid+'" type="" />'
					+'<source src="'+data.videoHLSid+'" type="application/x-mpegURL" />'   
					+'</video>'
					+'<br/><button type="button" style=" margin-right:60px" class="btn btn-primary" onMouseover="startPtz(0,0,\''+data.serialNumber+'\');" onMouseout="stopPtz(0,\''+data.serialNumber+'\');">向上</button>'
					+'<button type="button" style="margin-right:60px" class="btn btn-primary" onMouseover="startPtz(1,0,\''+data.serialNumber+'\');" onMouseout="stopPtz(1,\''+data.serialNumber+'\');">向下</button>'
					+'<button type="button" style="margin-right:60px" class="btn btn-primary" onMouseover="startPtz(2,0,\''+data.serialNumber+'\');" onMouseout="stopPtz(2,\''+data.serialNumber+'\');">向左</button>'
					+'<button type="button" style="margin-right:60px" class="btn btn-primary" onMouseover="startPtz(3,0,\''+data.serialNumber+'\');" onMouseout="stopPtz(3,\''+data.serialNumber+'\');">向右</button> <br/>'
					);
					
					 var player=new EZUIPlayer('myPlayer'+data.id);
				    	player.on('error', function(){
				        console.log('error');
				    	});
				   		player.on('play', function(){
				    	    console.log('play');
				    	});
				    	player.on('pause', function(){
				        	console.log('pause');
				    	});
							}
						});
		});
		
		function searchCallBack(id){
			alert(id);
		   
		
		}
	</script>		
</body>
</html>
