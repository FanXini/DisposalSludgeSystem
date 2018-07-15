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

<title>My JSP 'driverManage.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="shortcut icon" href="favicon.ico">
<link href="css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="css/font-awesome.css?v=4.4.0" rel="stylesheet">
<link href="css/plugins/dataTables/dataTables.bootstrap.css"
	rel="stylesheet">

<link href="css/plugins/chosen/chosen.css" rel="stylesheet">

<link href="css/animate.css" rel="stylesheet">
<link href="css/style.css?v=4.1.0" rel="stylesheet">

<style>
body {
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
</style>
</head>

<body>
	<!-- 模态框   信息删除确认 -->
	<div class="modal fade" id="delModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">
						删除<input id="delId" type="hidden" />
					</h4>
				</div>
				<div class="modal-body" id="delModalContent"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">否</button>
					<button id="delSubmit" type="button" class="btn btn-primary">是</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>

	<!-- 模态框   增加用户 -->
	<div class="modal inmodal" id="addModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content animated bounceInRight">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
					</button>
					<img alt="140x140" src="img/user.png" width="10%" height="10%" />
					<h4 class="modal-title">新增用户</h4>
				</div>
				<div class="modal-body">
					<div class="container" style="width: 540px">
						<form class="form-inline">
							<div class="form-group">
								<label for="addRealName">姓&nbsp;&nbsp;&nbsp;&nbsp;名</label> <input
									type="text" placeholder="请输入姓名" id="addRealName"
									class="form-control">
							</div>
							<div class="form-group">
								<label for="addLoginName">登录名</label> <input type="text"
									placeholder="请输入登录名" id="addLoginName"
									class="form-control m-b control-label">
							</div>
							<div class="form-group">
								<label for="addLoginPass">密&nbsp;&nbsp;&nbsp;&nbsp;码</label> <input
									type="text" placeholder="请重置密码" id="addLoginPass"
									class="form-control m-b control-label">
							</div>
							<div class="form-group">
								<label for="addEmail">邮&nbsp;&nbsp;&nbsp;&nbsp;箱</label> <input
									type="text" placeholder="请输入邮箱" id="addEmail"
									class="form-control m-b control-label">
							</div>
							<div class="form-group">
								<label for="addTel">电&nbsp;&nbsp;&nbsp;&nbsp;话</label> <input
									type="text" placeholder="请输入电话" id="addTel"
									class="form-control m-b control-label">
							</div>
							<div class="form-group">
								<label for="addRole">角&nbsp;&nbsp;&nbsp;&nbsp;色</label> <span>
									<select id="addRole" name="statusId" size="1">
										<option value="1">管理员</option>
										
										<option value="3">司机</option>
										<option value="4">其他</option>
								</select>
								</span>
							</div>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-white" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="addUser">保存</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 模态框   编辑用户 -->
	<div class="modal inmodal" id="editModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content animated bounceInRight">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
					</button>
					<img alt="140x140" src="img/user.png" width="10%" height="10%" />
					<h4 class="modal-title" id="editUserId">编辑用户</h4>
				</div>
				<div class="modal-body">
					<div class="container" style="width: 540px">
						<form class="form-inline">
							<div class="form-group">
								<label for="editRealName">姓&nbsp;&nbsp;&nbsp;&nbsp;名</label> <input
									type="text" placeholder="请输入姓名" id="editRealName"
									class="form-control">
							</div>
							<div class="form-group">
								<label for="editLoginName">登录名</label> <input type="text"
									placeholder="请输入登录名" id="editLoginName"
									class="form-control m-b control-label">
							</div>
							<div class="form-group">
								<label for="editLoginPass">密&nbsp;&nbsp;&nbsp;&nbsp;码</label> <input
									type="text" placeholder="请重置密码" id="editLoginPass"
									class="form-control m-b control-label">
							</div>
							<div class="form-group">
								<label for="editEmail">邮&nbsp;&nbsp;&nbsp;&nbsp;箱</label> <input
									type="text" placeholder="请输入邮箱" id="editEmail"
									class="form-control m-b control-label">
							</div>
							<div class="form-group">
								<label for="editTel">电&nbsp;&nbsp;&nbsp;&nbsp;话</label> <input
									type="text" placeholder="请输入电话" id="editTel"
									class="form-control m-b control-label">
							</div>
							<div class="form-group">
								<label for="editRole">角&nbsp;&nbsp;&nbsp;&nbsp;色</label> <span>
									<select id="editRole" name="statusId" size="1"
									style="height:29px; width:180px; line-height:35px;">
										<option value="1">管理员</option>
										<option value="2">工作人员</option>
										<option value="3">司机</option>
										<option value="4">其他</option>
								</select>
								</span>
							</div>
							<div class="form-group">
								<label for="editStatus">状&nbsp;&nbsp;&nbsp;&nbsp;态</label> <span>
									<select id="editStatus" name="statusId" size="1"
									style="height:29px;width:180px; line-height:35px;">
										<%--<option value="2">待审核</option>--%>
										<option value="0">审核不通过</option>
										<option value="1">审核通过</option>
										<%--<option value="3">其他</option>--%>
								</select>
								</span>
							</div>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-white" data-dismiss="modal">取消</button>
					<button id="editUserSubmit" type="button" class="btn btn-primary">保存</button>
				</div>
			</div>
		</div>
		<!-- /.modal -->
	</div>

	<!-- 模态框   审核用户 -->
	<div class="modal inmodal" id="checkModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content animated bounceInRight">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
					</button>
					<img alt="140x140" src="img/user.png" width="10%" height="10%" />
					<h4 class="modal-title" id="checkUserId">审核用户</h4>
				</div>
				<div class="modal-body">
					<div class="container" style="width:340px">
						<button id="checkUserSubmit1" type="button"
							class="btn btn-primary">通过</button>
						<button id="checkUserSubmit2" type="button"
							class="btn btn-primary">不通过</button>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-white" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
		<!-- /.modal -->
	</div>

	<!-- 搜索栏 -->
	<div class="search-content">
		<div class="add-site-btn">
			<button type="button" class="btn btn-primary" data-toggle="modal"
				data-target="#addModal">+ 新增用户</button>
		</div>

		<div class="query-site-btn">
			<div class="form-inline">
				<div>
					<span> <select id="userStatus" name="statusId" size="1"
						style="height:29px; line-height:35px;">
							<option value="">-请选择状态-</option>
							<option value="2">待审核</option>
							<option value="0">审核不通过</option>
							<option value="1">审核通过</option>
							<%--<option value="3">其他</option>--%>
					</select>
					</span> <input type="text" class="form-control" placeholder="请输入用户姓名或登录名"
						id="queryInput">
					<button id="querySubmit" class="btn btn-primary" type="button">查询</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 人员列表 -->
	<div class="col-sm-12">
		<!-- Example Pagination -->
		<div class="example-wrap">
			<div id="tabelDiv" class="ibox-content"></div>
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
		<!-- Chosen -->
		<script src="js/plugins/chosen/chosen.jquery.js"></script>

		<!-- baidu map -->
		<script type="text/javascript"
			src="http://api.map.baidu.com/api?v=2.0&ak=5TmZTw10oplDe4ZehEM6UjnY6rDgocd8"></script>
		<!-- Page-Level Scripts -->
		<script>
		
	var addValidate;

	var table_start = '<table id="staffTable" class="table table-striped table-bordered table-hover dataTables-example">'
			+ '<thead>'
			+ '<tr>'
			+ '<th data-field="siteName">姓名</th>'
			+ '<th data-field="address">登录名</th>'
			+ '<th data-field="address">密码</th>'
			+ '<th data-field="tel">Email</th>'
			+ '<th data-field="device">电话</th>'
			+ '<th data-field="device">角色</th>'
			+ '<th data-field="sensors">状态</th>'
			+ '<th data-field="sensors">操作</th>'
			+ '</tr>'
			+ '</thead>'
			+ '<tbody>'
	var table_end = '</tbody>' + '<tfoot>' + '</tfoot>' + '</table>'

	/***************************** 查询所有用户************************************* */
	$.ajax({
			type : "POST",
			url : "system/queryAllUser",
			dataType : "json",
			contentType : "application/json",
			success : function(userList) {
				$("#tabelDiv").empty();
				var table = table_start;
				$.each(userList,function(i, user) {
					table += '<tr class="gradeX" id="' + user.id + '">';
					if(user.realname == null)
					{
						table += '<td></td>';
					}
					else
					{
						table +='<td>'+ user.realname + '</td>';
					}

					if(user.username == null)
					{
						table += '<td></td>';
					}
					else
					{
						table +='<td>'+ user.username + '</td>';
					}

					table +='<td>'+ '******' + '</td>';

					if(user.email == null)
					{
						table += '<td></td>';
					}
					else
					{
						table +='<td>'+ user.email + '</td>';
					}

					if(user.telephone == null)
					{
						table += '<td></td>';
					}
					else
					{
						table +='<td>'+ user.telephone + '</td>';
					}

					table += '<td>'
					if(user.roleId == 1)
					{
						table += "管理员";
					}
					else if(user.roleId == 2)
					{
						table += "工作人员";
					}
					else if(user.roleId == 3)
					{
						table += "司机";
					}
					else
					{
						table += "其他";
					}
					table += '</td><td>';
					if (user.checkStatus == 1)
					{
						table += "审核通过";
						table += '</td><td style="width:15%;">';
						table += '<div><button onclick="editUser(' + user.id + ')" id="' + user.id + ' " class="btn btn-white btn-sm" data-toggle="modal" data-target="#editModal">';
						table += '<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button>';
						table += '<button onclick="deleteUser(' + user.id + ',\''+ user.username + '\');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delModal">';
						table += '<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>';
					}
					else if (user.checkStatus == 2)
					{
						table += "待审核";
						table += '</td><td style="width:15%;">';
						table += '<div><button onclick="checkUser(' + user.id + ')" class="btn btn-white btn-sm" data-toggle="modal" data-target="#checkModal">';
						table += '<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>审核</button>';
						table += '<button onclick="deleteUser(' + user.id + ',\''+ user.username + '\');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delModal">';
						table += '<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>';
					}
					else if (user.checkStatus == 0)
					{
						table += "审核不通过";
						table += '</td><td style="width:15%;">';
						table += '<div><button onclick="editUser(' + user.id + ')" id="' + user.id + ' " class="btn btn-white btn-sm" data-toggle="modal" data-target="#editModal">';
						table += '<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button>';
						table += '<button onclick="deleteUser(' + user.id + ',\''+ user.username + '\');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delModal">';
						table += '<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>';
					}
					table += '</div></td></tr>';
				});

				table += table_end
				$('#tabelDiv').append(table)
				$('.dataTables-example').dataTable();
			}
	});

	/***************************** 模糊查询************************************* */
	$("#querySubmit").click(function(){
		var data1 = $("#queryInput").val();//获取输入框输入的用户姓名或登录名
		var data2 = $("#userStatus").val();//获取下拉列表对应的value值
		data1 = $.trim(data1);
		if(data2 == '')
		{
			data2=-1;//UserDao.xml中判断条件为:<if test="checkStatus!=-1">
		}
		$.ajax({
			type : "POST",
			url : "system/fuzzyQueryUser",
			data : "queryStr=" + data1+"&checkStatus="+data2,
			success : function(userList) {
				$("#tabelDiv").empty();
				var table = table_start;
				$.each(userList,function(i, user) {
					table += '<tr class="gradeX" id="' + user.id + '">';
					if(user.realname == null)
					{
						table += '<td></td>';
					}
					else
					{
						table +='<td>'+ user.realname + '</td>';
					}

					if(user.username == null)
					{
						table += '<td></td>';
					}
					else
					{
						table +='<td>'+ user.username + '</td>';
					}

					table +='<td>'+ '******' + '</td>';

					if(user.email == null)
					{
						table += '<td></td>';
					}
					else
					{
						table +='<td>'+ user.email + '</td>';
					}

					if(user.telephone == null)
					{
						table += '<td></td>';
					}
					else
					{
						table +='<td>'+ user.telephone + '</td>';
					}

					table += '<td>'
					if(user.roleId == 1)
					{
						table += "管理员";
					}
					else if(user.roleId == 2)
					{
						table += "工作人员";
					}
					else if(user.roleId == 3)
					{
						table += "司机";
					}
					else
					{
						table += "其他";
					}
					table += '</td><td>';
					if (user.checkStatus == 1)
					{
						table += "审核通过";
						table += '</td><td style="width:15%;">';
						table += '<div><button onclick="editUser(' + user.id + ')" id="' + user.id + ' " class="btn btn-white btn-sm" data-toggle="modal" data-target="#editModal">';
						table += '<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button>';
						table += '<button onclick="deleteUser(' + user.id + ',\''+ user.username + '\');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delModal">';
						table += '<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>';
					}
					else if (user.checkStatus == 2)
					{
						table += "待审核";
						table += '</td><td style="width:15%;">';
						table += '<div><button onclick="checkUser(' + user.id + ')" class="btn btn-white btn-sm" data-toggle="modal" data-target="#checkModal">';
						table += '<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>审核</button>';
						table += '<button onclick="deleteUser(' + user.id + ',\''+ user.username + '\');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delModal">';
						table += '<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>';
					}
					else if (user.checkStatus == 0)
					{
						table += "审核不通过";
						table += '</td><td style="width:15%;">';
						table += '<div><button onclick="editUser(' + user.id + ')" id="' + user.id + ' " class="btn btn-white btn-sm" data-toggle="modal" data-target="#editModal">';
						table += '<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button>';
						table += '<button onclick="deleteUser(' + user.id + ',\''+ user.username + '\');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delModal">';
						table += '<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>';
					}
					table += '</div></td></tr>';
				});
				table += table_end
				$('#tabelDiv').append(table)
				$('.dataTables-example').dataTable();
			}
		});
	});

	/***************************** 新增用户************************************* */
	$("#addUser").click(function(){
		var realname=$("#addRealName").val();
		var username=$("#addLoginName").val();
		var password=$("#addLoginPass").val();
		var email=$("#addEmail").val();
		var telephone=$("#addTel").val();
		var roleId=$("#addRole").val();

				$.ajax({
					type : "POST",
					url : "system/addUser",
					data : JSON.stringify({
						realname : realname,
						username : username,
						password : password,
						email : email,
						telephone : telephone,
						roleId : roleId,
					}),
					dataType : "json",
					contentType : "application/json",
					success : function(result) {
						if (result.result == "success") {
//							alert("添加成功");
							$('#addModal').modal('hide');
							window.location.href = "system/jumpToStaff";
						} else {
							alert("添加失败");
						}
					}
				});
	});

	/***************************** 删除用户按钮************************************* */
	function deleteUser(userId, userName) {
		var delContent = "确定删除用户：" + userName + "?";
		$("#delModalContent").html(delContent);
		$("#delId").val(userId);
	}

	/***************************** 删除用户************************************* */
	$("#delSubmit").click(function() {
		var userId = $("#delId").val();
		$.ajax({
			type : "POST",
			url : "system/deleteUserByUserId",
			data : "userId=" + userId,
			success : function() {
				$('#delModal').modal('hide');
				window.location.href = "system/jumpToStaff";
			}
		});
	});

	/***************************** 修改用户按钮************************************* */
	function editUser(userId) {
		var rowNum = $("tr[id="+userId+"]");
		var realname = rowNum.children("td").eq(0).text();
		var username = rowNum.children("td").eq(1).text();
		var email = rowNum.children("td").eq(3).text();
		var phone = rowNum.children("td").eq(4).text();
		var role = rowNum.children("td").eq(5).text();
		var status = rowNum.children("td").eq(6).text();

		$("#editUserId").val(userId);
		$("#editRealName").val(realname);
		$("#editLoginName").val(username);
		$("#editLoginPass").val("******");
		$("#editEmail").val(email);
		$("#editTel").val(phone);
		if(role == "管理员")
		{
			$("#editRole").val(1);
		}
		else if(role == "工作人员")
		{
			$("#editRole").val(2);
		}
		else if(role == "司机")
		{
			$("#editRole").val(3);
		}
		else if(role == "其他")
		{
			$("#editRole").val(4);
		}

		if(status == "审核不通过")
		{
			$("#editStatus").val(0);
		}
		else if(status == "审核通过")
		{
			$("#editStatus").val(1);
		}
		else if(status == "待审核")
		{
			$("#editStatus").val(2);
		}
	}

	/***************************** 修改用户信息************************************* */
	$("#editUserSubmit").click(function() {
		var id=$("#editUserId").val();
		var realname=$("#editRealName").val();
		var username=$("#editLoginName").val();
		var password=$("#editLoginPass").val();
		var email=$("#editEmail").val();
		var telephone=$("#editTel").val();
		var roleId=$("#editRole").val();
		var checkStatus=$("#editStatus").val();

		$.ajax({
			type : "POST",
			url : "system/editUserByUserId",
			data : JSON.stringify({
				id : id,
				realname : realname,
				username : username,
				password : password,
				email : email,
				telephone : telephone,
				roleId : roleId,
				checkStatus : checkStatus,
			}),
			dataType : "json",
			contentType : "application/json",
			success : function(result) {
				if (result.result == "success")
				{
//					alert("修改成功")
					$('#editModal').modal('hide');
					window.location.href = "system/jumpToStaff";
				}
				else
				{
					alert("修改用户信息失败");
				}
			}
		});
	});

	/***************************** 审核用户按钮************************************* */
	function checkUser(userId)
	{
		$("#checkUserId").val(userId);
	}

	/***************************** 审核用户************************************* */
//	审核通过 修改用户状态
	$("#checkUserSubmit1").click(function() {
		var userId = $("#checkUserId").val();
		$.ajax({
			type : "POST",
			url : "system/checkUserByUserId",
			data : "userId=" + userId,
			success : function() {
				$('#checkModal').modal('hide');
				window.location.href = "system/jumpToStaff";
			}
		});
	});

	//	审核不通过
	$("#checkUserSubmit2").click(function() {
		var userId = $("#checkUserId").val();
		$.ajax({
			type : "POST",
			url : "system/checkNUserByUserId",
			data : "userId=" + userId,
			success : function() {
				$('#checkModal').modal('hide');
				window.location.href = "system/jumpToStaff";
			}
		});
	});

</script>

	</div>

</body>

</html>
