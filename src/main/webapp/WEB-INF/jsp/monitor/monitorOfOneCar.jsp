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
</head>
<body>
<script src="https://open.ys7.com/sdk/js/1.3/ezuikit.js"></script>
	<!-- 模态框   增加监控 -->
	
	
	
    <!-- 摄像头列表 -->
	<!-- Example Pagination -->
		<div id="page-wrapper"  class="container-fluid">
			<div class="row clearfix video">
		<%-- <c:forEach items="${requestScope.videoList }" var="video"> --%>
			<div class="col-md-12 column" >
				<div class="" id="${requestScope.video.id}">
					<div>
						<video class="box5" id='myPlayer${requestScope.video.id}' name="play" poster="" controls playsInline webkit-playsinline autoplay>
					    <source src="${requestScope.video.video_RTMPid}" type="" />
						<source src="${requestScope.video.video_HLSid}" type="application/x-mpegURL" />
						</video>
					</div>
					<div class="divlicense">
						<img class="box5" alt="140x140" src="img/littercar.png" width="10%" height="10%" />
						<p class="box6" style="text-align:center;">${requestScope.video.car.license}</p>
					</div>
				</div>
			</div>
		<%-- </c:forEach> --%>
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
	
</body>
</html>
