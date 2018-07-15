<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>修改用户信息</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href="css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script
	src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="js/jquery.min.js?v=2.1.4"></script>
<script src="js/bootstrap.min.js?v=3.3.6"></script>
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
	max-width:800px;
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
		left: 38%;
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
	height: 400px;
	width: 100%;
	background-color: rgba(255, 250, 2550, .6);
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
				<small>修改用户信息</small>
			</h1>
		</div>
		<div class="login-content ">

			<form id="formEdit" method="post" action="modifyUserInfo"
				class="form-horizontal" onsubmit="return validate_form(this);">
				<div class="modal-body">
					<table width="93%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td style="font-size:15px; padding:10px;"><label
								for="lastname" class="col-sm-12 control-label">登陆账号</label></td>
							<td><input type="text" class="form-control" id="username"
								name="user.userName" value="${sessionScope.user.username}"
								readonly="readonly"></td>
							<td style="font-size:15px; padding:10px"><label
								for="lastname" class="col-sm-12 control-label">角色</label></td>
							<td><input type="text" class="require form-control"
								id="roleId" name="${sessionScope.user.roleId }"
								value="${sessionScope.user.role.role_name}" readonly="readonly"></td>
						</tr>
						<tr>
							<td align="center" style="font-size:15px; padding:10px"><label
								for="lastname" class="col-sm-12 control-label">真实姓名</label></td>
							<td><input type="text" class="form-control" id="realname"
								class="require" name="user.realName"
								value="${sessionScope.user.realname}"></td>
							<td style="font-size:15px; padding:10px"><label
								for="lastname" class="col-sm-12 control-label">性别</label></td>
							<td><input type="text" class="form-control" id="sex"
								name="user.sex" value="${sessionScope.user.sex}"></td>
						</tr>
						<tr>
							<td style="font-size:15px; padding:10px"><label
								for="lastname" class="col-sm-12 control-label">身份证</label></td>
							<td><input type="text" class="form-control" id="idCard"
								name="user.idCard" value="${sessionScope.user.idCard}"></td>
							<td align="center" style="font-size:15px; padding:10px"><label
								for="lastname" class="col-sm-12 control-label">手机号码</label></td>
							<td><input type="text" class="form-control" id="telephone"
								class="require" id="lastname" name="user.telephone"
								value="${sessionScope.user.telephone}"></td>
						</tr>
						<tr>
							<td style="font-size:15px; padding:10px"><label
								for="lastname" class="col-sm-12 control-label">邮箱</label></td>
							<td><input type="text" class="form-control" id="email"
								name="user.email" value="${sessionScope.user.email}"></td>
						</tr>
					</table>
				</div>
			</form>
			<div class="form-group form-actions">
				<div class="col-xs-4 col-xs-offset-5 ">
					<input type="submit" class="btn btn-sm btn-info"
						id="editUserinfo" value="确认修改"></input>
				</div>
			</div>
		</div>
	</div>
	</div>
	</div>

	<div style="text-align:center;"></div>
	<script type="text/javascript">
	
		$(document).ready(function() {
			$("#editUserinfo").click(function() {
				var reg = /^[a-zA-Z0-9_-]+@([a-zA-Z0-9]+\.)+(com|cn|net|org)$/;
				var regs = /^[1][3,4,5,7,8][0-9]{9}$/;
				var regidcard = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/; 
				var pattern = /^['男'|'女']$/
				var email = $("#email").val();
				var realname = $("#realname").val();
				var sex = $("#sex").val();
				var telephone = $("#telephone").val();	
  				var username = 	$("#username").val();
				var role_name=$("#roleId").val()
				var roleId=$("#roleId").attr("name")
				var role={
					id:roleId,
					role_name:role_name
				}
				var idCard = $("#idCard").val();
				if(realname == ""){
					alert("真实姓名不能为空")
				}else if(pattern.test(sex) == false){
					alert("请输入您的性别：<男> 或 <女>")
				}else if(idCard == ""){
					alert("身份证号码不能为空")
				}else if(regidcard.test(idCard) == false){
					alert("不是正确的身份证号，请重新输入")
				}else if(telephone == ""){
					alert("手机号码不能为空")
				}else if (!(telephone && telephone.length == 11 && !isNaN(telephone))){
					alert("不是完整的11位手机号或者正确的手机号前七位");			
					return false
				}else if(email == ""){
					alert("邮箱不能为空")
				}
				else if (!(reg.test(email))) {
					alert("邮箱格式不正确");			
				}else{
					$.ajax({
						type : "POST",
						url :　"user/modifyUserInfo",
						data : JSON.stringify({
						id : ${sessionScope.user.id},
						username : username,
						realname : realname,
						email : email,
						sex : sex,
						role:role,
						telephone:telephone,
						idCard:idCard
						}),
						cache:false,
						dataType : "json",
						contentType : "application/json",
						success : function(data){
							alert("修改成功")
							$("#email").val(data.email);
							$("#sex").val(data.sex);
							$("#telephone").val(data.telephone);
							$("#realname").val(data.realname);
						}, 
						error:function(data){
							alert("修改失败")
						}
					})
				}
				
			})
		})
	</script>

</body>
</html>