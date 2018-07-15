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

<title>登陆页面</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="shortcut icon" href="favicon.ico">
<link href="css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
<!-- <link href="css/animate.css" rel="stylesheet"> -->
<link href="css/style.css?v=4.1.0" rel="stylesheet">
<!--[if lt IE 9]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->
    
<style type="text/css">
    *{margin: 0;padding:0;}
    .div1{
        width:3000px;
        height: 200px;
        position: relative;
    }
    .imgaline {
        width: 100px;
        height: 100px;
        position: absolute;
        top: 50%;
        left: 50%;
        margin-top: -25px; /* 高度的一半 */
        margin-left: -100px; /* 宽度的一半 */
    }
</style>
<script>if (window.top !== window.self) {
		window.top.location = window.location;
	}
</script>
</head>

<body class="gray-bg">

	<div class="middle-box text-center loginscreen  animated fadeInDown">
		<div>
			<div class = "middle-box div1">
				<img alt="140x140" class="imgaline m-t img-responsive" width="50%" height="50%"
								src="img/pcar.png">
			</div>
			<h3>欢迎使用车载式污泥干化处理系统</h3>
			<div class="row">
				<div class="m-t" role="form">
					<div class="form-group">
						<input id="loginName" type="text" class="form-control"
							placeholder="用户名" required="">
					</div>
					<div class="form-group">
						<input id="loginPass" type="password" class="form-control"
							placeholder="密码" required="">
					</div>
					<button id="loginButton"
						class="btn btn-primary block full-width m-b">登 录</button>


					<p class="text-muted text-center">
						<a href="javascript:void(0)"><small>还没有账号？</small></a> | <a
							href="user/private/register">注册一个新账号</a>
					</p>

				</div>
			</div>
		</div>

		<!-- 全局js -->
		<script src="js/jquery.min.js?v=2.1.4"></script>
		<script src="js/bootstrap.min.js?v=3.3.6"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				$("#loginButton").click(function() {
					var username = $("#loginName").val();
					var password = $("#loginPass").val();
					if (username.length == 0) {
						alert("username cannot be null");
					} else if (password.length == 0) {
						alert("password cannot be null");
					} else {
						$.ajax({
							type : "POST",
							url : "user/loginValidator",
							data : JSON.stringify({
								username : username,
								password : password
							}),
							dataType : "json",
							contentType : "application/json",
							success : function(result) {
								if (result == "SUCCESS") {
									window.location.href = "user/private/main";
								} else if (result == "ERROR") {
									alert("账号密码不正确，请重新输入");
									$("#loginPass").val("");
								} else if (result == "FORBID") {
									alert("审核未通过,无法使用系统");
									$("#loginName").val("");
									$("#loginPass").val("");
								} else if (result == "AUDING") {
									alert("正在审核中，请耐心等待")
								}else{
									alert("登陆失败")
								}
							}
						});
					}
				})
			})
		</script>
</body>

</html>