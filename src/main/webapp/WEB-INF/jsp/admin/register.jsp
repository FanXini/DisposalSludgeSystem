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

<title>注册页面</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="shortcut icon" href="favicon.ico">
<link href="css/plugins/iCheck/custom.css" rel="stylesheet">
<link href="css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
<!-- <link href="css/animate.css" rel="stylesheet"> -->
<link href="css/style.css?v=4.1.0" rel="stylesheet">

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
<script type="text/javascript" src="js\checkPwd.js"></script>

</head>

<body class="gray-bg">

	<div class="middle-box text-center loginscreen   animated fadeInDown">
		<div>
			<div class = "middle-box div1">
				<img alt="140x140" class="imgaline m-t img-responsive" width="50%" height="50%"
								src="img/pcar.png">
			</div>
			<h3>欢迎注册车载式污泥干化处理系统</h3>
			<p>创建一个车载式污泥干化处理系统新账户</p>
			<div class="m-t" role="form" action="login.html">
				<div class="form-group">
					<input id="userName" type="text" class="form-control"
						placeholder="用户名(手机号码)" required="">
				</div>
				<div class="form-group">
					<input id="idCard" type="text" class="form-control"
						placeholder="身份证号" required="">
				</div>
				<div class="form-group">
					<input id="realName" type="text" class="form-control"
						placeholder="姓名" required="">
				</div>
				<div class="form-group">
					<input id="sex" type="text" class="form-control"
						placeholder="性别（男/女）" required="">
				</div>
				<div class="form-group">
					<input id="registerPass" type="password" class="form-control"
						placeholder="密码" required="" onblur="chkpwd(this);">
						<div id="chkResult"></div>
				</div>
				<div class="form-group">
					<input id="confirmPass" type="password" class="form-control"
						placeholder="请再次输入密码" required="">
				</div>
				<div class="row form-group">
					<div class="col-sm-3">
						<label> <input type="radio" name="optionsRadios"
							class="radios" id="driverRadios" value="3" checked>污泥处理司机
						</label>
					</div>
					<div class="col-sm-3">
						<label> <input type="radio" name="optionsRadios"
							class="radios" id="transportRadios" value="4" checked>污泥运输司机
						</label>
					</div>
					<div class="col-sm-4">
						<label> <input type="radio" name="optionsRadios"
							class="radios" id="factoryManageRadios" value="2">工厂管理员
						</label>
					</div>
				</div>
				<div class="form-group" id="factory">
					<div class="input-group">
						<span class="input-group-addon">工厂</span> <select
							id="siteList" class="form-control col-lg-4">
								<option value="0">请选择</option>
						</select>
					</div>
				</div>
				<div class="form-group text-left">
					<div class="checkbox i-checks">
						<a class="no-padding" role="button" data-toggle="collapse"
							href="#collapseExample" aria-expanded="false"
							aria-controls="collapseExample"> <input
							type="checkbox"><i></i> 我同意注册协议
						</a>
						<div class="collapse" id="collapseExample">
							<div class="well">严格遵守公司的规章管理制度</div>
						</div>
					</div>
				</div>

				<button id="register" class="btn btn-primary block full-width m-b">注
					册</button>

				<p class="text-muted text-center">
					<small>已经有账户了？</small><a href="user/private/login">点此登录</a>
				</p>

			</div>
		</div>
	</div>

	<!-- 全局js -->
	<script src="js/jquery.min.js?v=2.1.4"></script>
	<script src="js/bootstrap.min.js?v=3.3.6"></script>
	<!-- iCheck -->
	<script src="js/plugins/iCheck/icheck.min.js"></script>
	<script>
		$(document).ready(function() {
			$("#factory").hide()
			$.ajax({
				type:"POST",
				url:"system/queryAllSite",
				success:function(siteList){
					$.each(siteList, function(i, site) {
						var option=new Option(site.siteName,site.id)
						$("#siteList")[0].options.add(option)
						/* $("#siteList").append('<option >'+site.siteName+'</option>') */
					})
				}
			})
			$('.i-checks').iCheck({
				checkboxClass : 'icheckbox_square-green',
				radioClass : 'iradio_square-green',
			});
			$(".radios").click(function(){
				var id=this.getAttribute("id")
				if(id=="factoryManageRadios"){
					$("#factory").show()
				}
				else{
					$("#factory").hide()
				}
			})
			
			$("#register").click(function() {
			var username = $("#userName").val();
			var telephone = $("#userName").val();
			var idCard = $("#idCard").val();
			var realname = $("#realName").val();
			var sex = $("#sex").val();
			var registerPass = $("#registerPass").val();
			var confirmPass = $("#confirmPass").val();
			var roleId=parseInt($("input[type='radio']:checked").val())
			var siteId=parseInt($("#siteList").val())
			var regidcard = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
			/* alert(registerName+" "+registerPass+" "+roleId+" "+siteId) */
			if (username.length == 0) {
				alert("用户名不能为空");
			}else if (username.length == 0){
					alert("手机号码不能为空");			
			}else if (!(username && username.length == 11 && !isNaN(username))){
					alert("不是完整的11位手机号或者正确的手机号前七位");			
					return false
			}else if (idCard.length == 0){
					alert("身份证号码不能为空");			
			}else if(regidcard.test(idCard) == false){
				alert("不是正确的身份证号，请重新输入")
			}else if (realname.length == 0){
					alert("姓名不能为空");			
			}else if (registerPass.length == 0) {
				alert("密码不能为空");
			}else if (confirmPass.length == 0) {
				alert("请输入确认密码");
			}else if (registerPass != confirmPass) {
				alert("密码与确认密码不一致！"); 
			}else if(!$("input[type='checkbox']").is(':checked')){
				alert("请阅读注册协议")
			}else {
				$.ajax({
					type : "POST",
					url : "user/register",
					data : JSON.stringify({
						username : username,
						telephone:telephone,
						idCard : idCard,
						realname : realname,
						sex :sex,
						password : registerPass,
						roleId : roleId,
						siteId : siteId
					}),
					contentType : "application/json",
					dataType : "json",
					success : function(result) {
						if (result == "SUCCESS") {
							alert("注册成功,请耐心等待管理员审核");
						} else if (result == "DUPLICATE") {
							alert("该用户名已被注册");
						} else if (result == "INPUT") {
							alert("请检查注册信息输入是否正确");
						}else {
							alert("注册失败");
						}
					},
					error:function(result){
						alert("注册失败")
					}
				});
			}
		});
			
			
		});
	</script>




</body>

</html>