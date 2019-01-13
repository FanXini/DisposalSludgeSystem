<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>污泥处理申请</title>

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
				<small>污泥处理申请</small>
			</h1>
		</div>
		<div class="login-content ">

			<div id="formEdit" method= "post", action="alert"
				class="form-horizontal" onsubmit="return validate_form(this);">
				<div class="modal-body">
					<table width="93%" border="0" cellspacing="0" cellpadding="0">
						<tr>
						<td style="font-size:15px; padding:10px;"><label
								for="siteId" class="col-sm-12 control-label">污泥厂编号</label></td>
							<td><input type="text" class="form-control" id="siteId"
								name="site.id" value="${requestScope.site.id}"
								readonly="readonly"></td>
						</tr>
						<tr>
							<td style="font-size:15px; padding:10px;"><label
								for="siteName" class="col-sm-12 control-label">污泥厂名称</label></td>
							<td><input type="text" class="form-control" id="siteName"
								name="site.siteName" value="${requestScope.site.siteName}"
								readonly="readonly"></td>
						</tr>
						<tr>
							<td align="center" style="font-size:15px; padding:10px"><label
								for="address" class="col-sm-12 control-label">污泥厂地址</label></td>
							<td><input type="text" class="form-control" id="address"
								class="require" name="site.address"
								value="${requestScope.site.address}"></td>
						</tr>
						<tr>
							<td style="font-size:15px; padding:10px"><label
								for="tel" class="col-sm-12 control-label">联系方式</label></td>
							<td><input type="text" class="form-control" id="tel"
								name="site.telephone" value="${requestScope.site.telephone}"></td>
						</tr>
						<tr>
							<td style="font-size:15px; padding:10px"><label
								for="amount" class="col-sm-12 control-label">预处理量</label></td>
							<td><input type="text" class="form-control" id="amount"
								name="record.amount" value=""></td>
						</tr>
					</table>
				</div>
			</div>
			<div class="form-group form-actions">
				<div class="col-xs-4 col-xs-offset-5 ">
					<input type="submit" class="btn btn-sm btn-info"
						id="confirmSubmmit" value="确认提交"></input>
				</div>
			</div>
		</div>
	</div>
	</div>
	</div>

	<div style="text-align:center;"></div>
	<!-- 全局js -->
	<script src="js/jquery.min.js?v=2.1.4"></script>
	<script src="js/bootstrap.min.js?v=3.3.6"></script>
	<!-- iCheck -->
	<script src="js/plugins/iCheck/icheck.min.js"></script>
	<script>
	   $("#confirmSubmmit").click(function() {
	   var siteId = $("#siteId").val();
	   var pretreatAmount = $("#amount").val();
	   $.ajax({
	   		type:"POST",
	   		url : "record/insertRecordByAlert",
	   		data : JSON.stringify({
	   			siteId : siteId,
	   			pretreatAmount : pretreatAmount
	   		}),
	   		contentType : "application/json",
	   		dataType : "text",
	   		success : function(result) {
					alert("污泥处理申请成功，请等待配车");
					$("#amount").val("");
				} 
	   });
	   });
	</script>
	</body>
	</html>