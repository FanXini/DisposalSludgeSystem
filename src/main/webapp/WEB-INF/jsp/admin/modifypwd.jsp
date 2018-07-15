<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "No-store");
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>修改密码</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href="css/bootstrap.min.css?v=3.3.6" rel="stylesheet">

<script src="js/jquery.min.js?v=2.1.4"></script>
<script src="js/bootstrap.min.js?v=3.3.6"></script>
<script type="text/javascript" src="js\checkPwd.js"></script>

<style type="text/css">
html,body {
	height: 100%;
}
.box {
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6699FF', endColorstr='#6699FF'); /*  IE */	
	margin: 0 auto;
	position: relative;
	width: 100%;
	height: 100%;
}
.login-box {
	width: 100%;
	max-width:500px;
	height: 400px;
	border: 1px solid #6495ED;
	position: absolute;
	top: 50%;

	margin-top: -200px;
	/*设置负值，为要定位子盒子的一半高度*/
	
}
.btn-info{
	background:#6495ED;
	border: 1px solid #6495ED;
}
@media screen and (min-width:500px){
	.login-box {
		left: 50%;
		/*设置负值，为要定位子盒子的一半宽度*/
		margin-left: -250px;
	}
}	

.form {
	width: 100%;
	max-width:500px;
	height: 275px;
	margin: 25px auto 0px auto;
	padding-top: 25px;
}	
.login-content {
	height: 300px;
	width: 100%;
	max-width:500px;
	background-color: rgba(255, 250, 2550, .6);
	float: left;
}		
	
	
.input-group {
	margin: 0px 0px 30px 0px !important;
}
.form-control,
.input-group {
	height: 40px;
}

.form-group {
	margin-bottom: 0px !important;
}
.login-title {
	padding: 20px 10px;
	background-color: #6495ED;
}
.login-title h1 {
	margin-top: 10px !important;
}
.login-title small {
	color: #fff;
}

.link p {
	line-height: 20px;
	margin-top: 30px;
}
.btn-sm {
	padding: 8px 24px !important;
	font-size: 16px !important;
}
.glyphicon-user:before {
  content: "\e008";
}

</style>

</head>

<body class="box">
	<div class="login-box">
		<div class="login-title text-center">
			<h1>
				<small>修改用户密码</small>
			</h1>
		</div>
		<div class="login-content ">
			<div class="form">
				<form action="#" method="post">
					<div class="form-group">
						<div class="col-xs-12  ">
							<div class="input-group">
								<span class="input-group-addon"><span
									class="glyphicon glyphicon-lock"></span></span> <input id="pass"
									name="password" type="password" value="" placeholder="请输入原始密码"
									class="form-control">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-12  ">
							<div class="input-group">
								<span class="input-group-addon"><span
									class="glyphicon glyphicon-lock"></span></span> <input
									class="form-control" id="pass1" name="newpwd" type="password"
									value="" placeholder="请输入新密码" onblur="chkpwd(this);">
								<div id="chkResult"></div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-12  ">
							<div class="input-group">
								<span class="input-group-addon"><span
									class="glyphicon glyphicon-lock"></span></span> <input
									class="form-control" id="pass2" name="newpwd1" type="password"
									value="" placeholder="请确认密码">
							</div>
						</div>
					</div>
				</form>
				<div class="form-group form-actions">
					<div class="col-xs-4 col-xs-offset-4 ">
						<button type="submit" id="EditPWDButton"
							class="btn btn-sm btn-info">确认修改</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>

	<div style="text-align:center;"></div>
	<script type="text/javascript">
	  function chkpwd(obj){
		var t=obj.value;
		var id=getResult(t);
		
		//定义对应的消息提示
		var msg=new Array(4);
		msg[0]="密码过短。";
		msg[1]="密码强度差。";
		msg[2]="密码强度良好。";
		msg[3]="密码强度高。";
		
		var sty=new Array(4);
		sty[0]=-45;
		sty[1]=-30;
		sty[2]=-15;
		sty[3]=0;
		
		var col=new Array(4);
		col[0]="red";
		col[1]="red";
		col[2]="Green";
		col[3]="Green";
		
		//设置显示效果
		var bImg="http://bbs.blueidea.com/attachments/2006/12/7/pwdlen_dSIPeEGQWxfO.gif";//一张显示用的图片
		var sWidth=300;
		var sHeight=15;
		var Bobj=document.getElementById("chkResult");

		Bobj.style.fontSize="14px";
		Bobj.style.color=col[id];
		Bobj.style.width=sWidth + "px";
		Bobj.style.height=sHeight + "px";
		Bobj.style.lineHeight=sHeight + "px";
		Bobj.style.background="url(" + bImg + ") no-repeat left " + sty[id] + "px";
		Bobj.style.textIndent="20px";
		Bobj.innerHTML="检测提示：" + msg[id];
	}
	
	//定义检测函数,返回0/1/2/3分别代表无效/差/一般/强
	function getResult(s){
		if(s.length < 4){
			return 0;
		}
		var ls = 0;
		if (s.match(/[a-z]/ig)){
			ls++;
		}
		if (s.match(/[0-9]/ig)){
			ls++;
		}
	 	if (s.match(/(.[^a-z0-9])/ig)){
			ls++;
		}
		if (s.length < 6 && ls > 0){
			ls--;
		}
		return ls
	}
		$(document).ready(function() {
			$("#EditPWDButton").click(function() {
				var originPwd = $("#pass").val(); //取pass对象的值
				var newPwd = $("#pass1").val();
				var checknewPwd = $("#pass2").val();
				if (originPwd == "") {
					alert("原始密码不能为空！");
				} else if (newPwd == "") {
					alert("新密码不能为空！");
				}else if(newPwd.length<6){
					alert("密码不能低于6位")
				} else if (originPwd == newPwd) {
					alert("新密码不能和旧密码相同！");
				}else if (checknewPwd == "") {
					alert("确认密码不能为空！");
				} else if (newPwd != checknewPwd) {
					alert("密码与确认密码不一致！");
				} else {
					$.ajax({
						type : "POST",
						url : "user/modifyPwd",
						data : JSON.stringify({
							userId:${sessionScope.user.id}, //取session中的数据
							originPwd : originPwd,  //Map（K，V）
							newPwd : newPwd,
							checknewPwd : checknewPwd
						}),
						dataType : "json",
						contentType : "application/json",
						success : function(data) {					
							alert(data.msg)
							if(data.msg =="success"){
								alert("修改成功，请重新登陆")								
  								parent.location.href= "user/private/login"
								session.invalidate(); 
							}
							else{
								alert("原始密码输入不正确，请重新输入")
								window.location.reload()								
							}
						},
						error:function(data){
							alert(data.msg)
							parent.location.href= "user/private/modifypwd"
						}
					})
	
				}
			})
		})
	</script>
</body>
</html>