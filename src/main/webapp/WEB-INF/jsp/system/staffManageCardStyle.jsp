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

.col-sm-1 {
	margin:0px 2px 0px 25px;
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

	<!-- 重置密码模态框 -->
	<div class="modal fade" id="resetPassWordModal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">
						重置密码<input id="resetUserId" type="hidden" />
					</h4>
				</div>
				<div class="modal-body" id="resetModalContent"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">否</button>
					<button id="resetPassButton" type="button" class="btn btn-primary">是</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
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
					<!-- <img alt="140x140" src="img/user.png" width="10%" height="10%" /> -->
					<h4 class="modal-title">新增用户</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-sm-6">
							<div class="form-group">
								<label for="addLoginName">登录名</label> <input type="text"
									placeholder="请输入登录名(必填)" id="addLoginName"
									class="form-control m-b control-label">
							</div>

							<div class="form-group">
								<label for="addTel">电&nbsp;&nbsp;&nbsp;&nbsp;话</label> <input
									type="text" placeholder="请输入电话" id="addTel"
									class="form-control m-b control-label">
							</div>

							<div class="form-group">
								<label for="addRole">角&nbsp;&nbsp;&nbsp;&nbsp;色</label> <span>
									<select id="addRole" name="statusId" size="1"
									class="form-control">
									<option value="1" selected="selected">管理员</option>
									<option value="2">工作人员</option> <option value="3">司机</option>
									<option value="4">运输车司机</option></select>
								</span>
							</div>

						</div>
						<div class="col-sm-6">
							<div class="form-group">
								<label for="addLoginPass">密&nbsp;&nbsp;&nbsp;&nbsp;码</label> <input
									type="text" placeholder="请设置密码(必填)" id="addLoginPass"
									class="form-control m-b control-label">
							</div>
							<div class="form-group">
								<label for="addRealName">姓&nbsp;&nbsp;&nbsp;&nbsp;名</label> <input
									type="text" placeholder="请输入姓名" id="addRealName"
									class="form-control">
							</div>

							<div class="form-group">
								<label for="addEmail">邮&nbsp;&nbsp;&nbsp;&nbsp;箱</label> <input
									type="text" placeholder="请输入邮箱" id="addEmail"
									class="form-control m-b control-label">
							</div>
						</div>



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
					<img alt="140x140" src="img/littercar.png" width="10%" height="10%" />
					<h4 class="modal-title" id="editUserId">修改用户信息</h4>
					<input id="editRoleId" type="hidden" />
					<!-- 只修改司机和工厂工作人员的车辆\工厂 -->
				</div>
				<div class="modal-body">
					<div class="container" style="width: 540px">

						<div class="form-group" id="carSelectForm">
							<div>
								<label for="Groupname" class="col-sm-3 control-label">车辆：</label>
								<div class="col-sm-9">
									<select class="form-control m-b" name="account" id="carSelect">

									</select>
								</div>
							</div>
						</div>


						<div class="form-group" id="siteSelectForm">
							<div>
								<label for="Groupname" class="col-sm-3 control-label">工厂：</label>
								<div class="col-sm-9">
									<select class="form-control m-b" name="account" id="siteSelect">
										<option value="0">--暂不分配--</option>
										<c:forEach items="${requestScope.siteList }" var="site">
											<option value="${site.id }">${site.siteName }</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="reset" class="btn btn-white" data-dismiss="modal">取消</button>
					<button id="editUserSubmit" type="button" class="btn btn-primary">保存</button>
				</div>
			</div>
		</div>
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
	<div class="search-content row container">
		<div class="add-site-btn col-sm-1">
			<button type="button" class="btn btn-primary" data-toggle="modal"
				data-target="#addModal">+ 新增用户</button>
		</div>
		<!-- Single button -->
		<div class="btn-group col-sm-1">
			<button type="button" class="btn btn-primary dropdown-toggle"
				data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				选择状态 <span class="caret"></span>
			</button>
			<ul class="dropdown-menu">
				<li><a class="btn btn-primary option" href="javascript:void(0)"
					name='-1'>全部</a></li>
				<li><a class="btn btn-primary option" href="javascript:void(0)"
					name='2'>待审核</a></li>
				<li><a class="btn btn-primary option" href="javascript:void(0)"
					name='0'>审核不通过</a></li>
				<li><a class="btn btn-primary option" href="javascript:void(0)"
					name='1'>审核通过</a></li>
			</ul>
		</div>
		
		<!-- Single button -->
		<div class="btn-group col-sm-1">
			<button type="button" class="btn btn-primary dropdown-toggle"
				data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				选择角色 <span class="caret"></span>
			</button>
			<ul class="dropdown-menu">
				<li><a class="btn btn-primary roleOption" href="javascript:void(0)"
					name='1'>管理员</a></li>
				<li><a class="btn btn-primary roleOption" href="javascript:void(0)"
					name='2'>工厂人员</a></li>
				<li><a class="btn btn-primary roleOption" href="javascript:void(0)"
					name='3'>处理车司机</a></li>
				<li><a class="btn btn-primary roleOption" href="javascript:void(0)"
					name='4'>运输车司机</a></li>
			</ul>
		</div>

		<div class="query-site-btn row">
			<div class="form-inline">
				<div>
					<input type="text" class="form-control"
						placeholder="请输入用户姓名/登录名/手机号码/身份证/邮箱" id="queryInput"
						style="width:400px">
					<button id="querySubmit" class="btn btn-primary" type="button">查询</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 人员列表 -->
	<!-- Example Pagination -->
	<div class="row" id="usersInfo">
		<c:forEach items="${requestScope.userList }" var="user">
			<div class="col-sm-4" style="height:220px">
				<div class="contact-box" id="${user.id }">
					<div class="col-sm-4">
						<div class="text-center">
							<c:if test="${user.roleId==1 }">
								<img alt="image" class="img-circle m-t-xs img-responsive"
								id="img_id" src="img/manager.png"> 
							</c:if>
							<c:if test="${user.roleId==2 }">
								<img alt="image" class="img-circle m-t-xs img-responsive"
								id="img_id" src="img/worker.png"> 
							</c:if>
							<c:if test="${user.roleId==3 || user.roleId==4}">
								<img alt="image" class="img-circle m-t-xs img-responsive"
								id="img_id" src="img/driver.png"> 
							</c:if>
							<div class="m-t-xs font-bold">${user.realname }</div>
						</div>
					</div>
					<div class="col-sm-8">
						<div class="pull-right">
							<c:if test="${user.roleId==2 }">
								<button
									onclick="editUser(${user.id},${user.roleId },${user.siteId })"
									class="btn btn-white btn-sm" data-toggle="modal"
									data-target="#editModal">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
								</button>
							</c:if>
							<c:if test="${user.roleId==3 || user.roleId==4}">
								<button
									onclick="editUser(${user.id},${user.roleId },${user.car.id })"
									class="btn btn-white btn-sm" data-toggle="modal"
									data-target="#editModal">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
								</button>
							</c:if>
							<button onclick="deleteUser(${user.id},'${user.realname }');"
								class="btn btn-white btn-sm" data-toggle="modal"
								data-target="#delModal">
								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
							</button>
						</div>
						<%-- <h3>
							<strong>姓名:${user.realname }</strong>
						</h3> --%>
						<address>
							<strong>角色:${user.role.role_name }</strong><br>
							<c:if test="${user.roleId==1 }">
								性别：${user.sex }<br>
							</c:if>
							E-mail:${user.email }<br> 身份证:${user.idCard }<br> <abbr
								title="Phone">Tel:</abbr> ${user.telephone }<br>
							<c:if test="${user.roleId==2 }">
								工厂:${user.site.siteName }
								</c:if>
							<c:if test="${user.roleId==3 || user.roleId==4}">
								车牌号:${user.car.license }
								</c:if>
						</address>
						<span class="label label-info" style="display:inline;vertical-align:middle;">通过审核</span>
						<button onclick="resetPassWord(${user.id},'${user.realname }');"
							class="btn btn-default btn-sm" data-toggle="modal"
							data-target="#resetPassWordModal">
							<span aria-hidden="true"></span>重置密码
						</button>
					</div>
					<div class="clearfix"></div>
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
	<!-- Chosen -->
	<script src="js/plugins/chosen/chosen.jquery.js"></script>

	<!-- baidu map -->
	<script type="text/javascript"
		src="http://api.map.baidu.com/api?v=2.0&ak=5TmZTw10oplDe4ZehEM6UjnY6rDgocd8"></script>
	<!-- Page-Level Scripts -->
	<script>
		var addValidate;
		//查询各种状态的用户
		$(".option").click(function() {
			var checkStatus = parseInt(this.getAttribute("name"))
			$.ajax({
				type : "POST",
				url : "system/queryUserByCheckStatus",
				data : "checkStatus=" + checkStatus,
				success : function(userList) {
					$("#usersInfo").empty();
					var content = '';
					$.each(userList, function(i, user) {
						content += '<div class="col-sm-4" style="height:220px">'
						content += '<div class="contact-box" id="' + user.id + '">'
						content += '<div class="col-sm-4">'
						content += '<div class="text-center">'
						if (user.roleId == 1) {//管理员
							content += '<img alt="image" class="img-circle m-t-xs img-responsive" src="img/manager.png">'
						}else if (user.roleId == 2) { //工厂人员
								content += '<img alt="image" class="img-circle m-t-xs img-responsive" src="img/worker.png">'
							} else if (user.roleId == 3 || user.roleId==4) { //司机
								content += '<img alt="image" class="img-circle m-t-xs img-responsive" src="img/driver.png">'
							}
						content += '<div class="m-t-xs font-bold">' + user.realname + '</div>'
						content += '</div>'
						content += '</div>'
						content += '<div class="col-sm-8">'
						content += '<div class="pull-right">'
						if (user.checkStatus != 1) {//管理员
							content += '<button onclick="checkUser(' + user.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#checkModal">'
							content += '<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>审核'
							content += '</button>'
						} 
						if(user.checkStatus == 0) {
							if (user.roleId == 2) { //工厂人员
								content += '<button onclick="editUser(' + user.id + ',' + user.roleId + ',' + user.siteId + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#editModal">'
								content += '<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑'
								content += '</button>'
							} else if (user.roleId == 3 || user.roleId==4) { //司机
								content += '<button onclick="editUser(' + user.id + ',' + user.roleId + ',' + user.car.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#editModal">'
								content += '<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑'
								content += '</button>'
							}
						} 
						content += '<button onclick="deleteUser(' + user.id + ',\'' + user.realname + '\');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delModal">'
						content += '<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除'
						content += '</button>'
						content += '</div>'
						/* content += '<h3><strong>姓名:' + user.realname + '</strong></h3>' */
						content += '<address>'
						content += '<strong>角色:' + (user.role.role_name==null?"":user.role.role_name ) + '</strong><br>'
						content += 'E-mail:' + (user.email==null?"":user.email ) + '<br> 身份证:' + (user.idCard==null?"":user.idCard ) + '<br> <abbr title="Phone">Tel:</abbr>' + user.telephone + '<br>'
						/* if (user.roleId == 1) {
							content += '性别:' + (user.sex==null?"":user.sex ) + '<br>'
						} */
						if (user.roleId == 2) {
							if(user.site==null){
								content += '工厂:'
							}
							else {
								content += '工厂:'+user.site.siteName;
							}
						}
						else if (user.roleId == 3 || user.roleId==4) {
							if(user.car==null){
								content += '车牌:'
							}
							else {
								content += '车牌:'+user.car.license
							}
							
						}
						content += '</address>'
						if (user.checkStatus == 0) {
							content += '<span class="label label-default">审核不通过</span>'
						} else if (user.checkStatus == 1) {
							content += '<span class="label label-info">已通过审核</span>'
						} else {
							content += '<span class="label label-danger">待审核</span>'
						}
						content += '<button onclick="resetPassWord(' + user.id + ',\'' + user.realname + '\');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#resetPassWordModal">'
						content += '<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>重置密码'
						content += '</button>'
						content += '</div>'
	
						content += '<div class="clearfix"></div>'
						content += '</div>'
						content += '</div>'
					})
					$("#usersInfo").append(content);
					$('.contact-box').each(function() {
						animationHover(this, 'pulse');
					});
				}
			});
		})
		
		$(".roleOption").click(function() {
			var roleId = parseInt(this.getAttribute("name"))
			$.ajax({
				type : "POST",
				url : "system/queryUserByRoleId",
				data : "roleId=" + roleId,
				success : function(userList) {
					$("#usersInfo").empty();
					var content = '';
					$.each(userList, function(i, user) {
						content += '<div class="col-sm-4" style="height:220px">'
						content += '<div class="contact-box" id="' + user.id + '">'
						content += '<div class="col-sm-4">'
						content += '<div class="text-center">'
						if (user.roleId == 1) {//管理员
							content += '<img alt="image" class="img-circle m-t-xs img-responsive" src="img/manager.png">'
						}else if (user.roleId == 2) { //工厂人员
								content += '<img alt="image" class="img-circle m-t-xs img-responsive" src="img/worker.png">'
							} else if (user.roleId == 3 || user.roleId==4) { //司机
								content += '<img alt="image" class="img-circle m-t-xs img-responsive" src="img/driver.png">'
							}
						content += '<div class="m-t-xs font-bold">' + user.realname + '</div>'
						content += '</div>'
						content += '</div>'
						content += '<div class="col-sm-8">'
						content += '<div class="pull-right">'
						if (user.checkStatus != 1) {//管理员
							content += '<button onclick="checkUser(' + user.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#checkModal">'
							content += '<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>审核'
							content += '</button>'
						} 
						if(user.checkStatus == 0) {
							if (user.roleId == 2) { //工厂人员
								content += '<button onclick="editUser(' + user.id + ',' + user.roleId + ',' + user.siteId + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#editModal">'
								content += '<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑'
								content += '</button>'
							} else if (user.roleId == 3 || user.roleId==4) { //司机
								content += '<button onclick="editUser(' + user.id + ',' + user.roleId + ',' + user.car.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#editModal">'
								content += '<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑'
								content += '</button>'
							}
						} 
						content += '<button onclick="deleteUser(' + user.id + ',\'' + user.realname + '\');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delModal">'
						content += '<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除'
						content += '</button>'
						content += '</div>'
						/* content += '<h3><strong>姓名:' + user.realname + '</strong></h3>' */
						content += '<address>'
						content += '<strong>角色:' + (user.role.role_name==null?"":user.role.role_name ) + '</strong><br>'
						content += 'E-mail:' + (user.email==null?"":user.email ) + '<br> 身份证:' + (user.idCard==null?"":user.idCard ) + '<br> <abbr title="Phone">Tel:</abbr>' + user.telephone + '<br>'
						/* if (user.roleId == 1) {
							content += '性别:' + (user.sex==null?"":user.sex ) + '<br>'
						} */
						if (user.roleId == 2) {
							if(user.site==null){
								content += '工厂:'
							}
							else {
								content += '工厂:'+user.site.siteName;
							}
						}
						else if (user.roleId == 3 || user.roleId==4) {
							if(user.car==null){
								content += '车牌:'
							}
							else {
								content += '车牌:'+user.car.license
							}
							
						}
						content += '</address>'
						if (user.checkStatus == 0) {
							content += '<span class="label label-default">审核不通过</span>'
						} else if (user.checkStatus == 1) {
							content += '<span class="label label-info">已通过审核</span>'
						} else {
							content += '<span class="label label-danger">待审核</span>'
						}
						content += '<button onclick="resetPassWord(' + user.id + ',\'' + user.realname + '\');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#resetPassWordModal">'
						content += '<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>重置密码'
						content += '</button>'
						content += '</div>'
	
						content += '<div class="clearfix"></div>'
						content += '</div>'
						content += '</div>'
					})
					$("#usersInfo").append(content);
					$('.contact-box').each(function() {
						animationHover(this, 'pulse');
					});
				}
			});
		})
	
	
		/***************************** 模糊查询************************************* */
		$("#querySubmit").click(function() {
			var queryStr = $("#queryInput").val(); //获取输入框输入的用户姓名或登录名
			$.ajax({
				type : "POST",
				url : "system/fuzzyQueryUser",
				data : "queryStr=" + queryStr,
				success : function(userList) {
					$("#usersInfo").empty();
					var content = '';
					$.each(userList, function(i, user) {
						content += '<div class="col-sm-4" style="height:220px">'
						content += '<div class="contact-box" id="' + user.id + '">'
						content += '<div class="col-sm-4">'
						content += '<div class="text-center">'
						if (user.roleId == 1) {//管理员
							content += '<img alt="image" class="img-circle m-t-xs img-responsive" src="img/manager.png">'
						}else if (user.roleId == 2) { //工厂人员
								content += '<img alt="image" class="img-circle m-t-xs img-responsive" src="img/worker.png">'
							} else if (user.roleId == 3 || user.roleId==4) { //司机
								content += '<img alt="image" class="img-circle m-t-xs img-responsive" src="img/driver.png">'
							}
						content += '<div class="m-t-xs font-bold">' + user.realname + '</div>'
						content += '</div>'
						content += '</div>'
						content += '<div class="col-sm-8">'
						content += '<div class="pull-right">'
						if (user.checkStatus != 1) {//管理员
							content += '<button onclick="checkUser(' + user.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#checkModal">'
							content += '<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>审核'
							content += '</button>'
						} 
						if(user.checkStatus == 0) {
							if (user.roleId == 2) { //工厂人员
								content += '<button onclick="editUser(' + user.id + ',' + user.roleId + ',' + user.siteId + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#editModal">'
								content += '<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑'
								content += '</button>'
							} else if (user.roleId == 3 || user.roleId==4) { //司机
								content += '<button onclick="editUser(' + user.id + ',' + user.roleId + ',' + user.car.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#editModal">'
								content += '<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑'
								content += '</button>'
							}
						} 
						content += '<button onclick="deleteUser(' + user.id + ',\'' + user.realname + '\');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delModal">'
						content += '<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除'
						content += '</button>'
						content += '</div>'
						/* content += '<h3><strong>姓名:' + user.realname + '</strong></h3>' */
						content += '<address>'
						content += '<strong>角色:' + (user.role.role_name==null?"":user.role.role_name ) + '</strong><br>'
						content += 'E-mail:' + (user.email==null?"":user.email ) + '<br> 身份证:' + (user.idCard==null?"":user.idCard ) + '<br> <abbr title="Phone">Tel:</abbr>' + user.telephone + '<br>'
						/* if (user.roleId == 1) {
							content += '性别:' + (user.sex==null?"":user.sex ) + '<br>'
						} */
						if (user.roleId == 2) {
							if(user.site==null){
								content += '工厂:'
							}
							else {
								content += '工厂:'+user.site.siteName;
							}
						}
						else if (user.roleId == 3 || user.roleId==4) {
							if(user.car==null){
								content += '车牌:'
							}
							else {
								content += '车牌:'+user.car.license
							}
							
						}
						content += '</address>'
						if (user.checkStatus == 0) {
							content += '<span class="label label-default">审核不通过</span>'
						} else if (user.checkStatus == 1) {
							content += '<span class="label label-info">已通过审核</span>'
						} else {
							content += '<span class="label label-danger">待审核</span>'
						}
						content += '<button onclick="resetPassWord(' + user.id + ',\'' + user.realname + '\');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#resetPassWordModal">'
						content += '<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>重置密码'
						content += '</button>'
						content += '</div>'
	
						content += '<div class="clearfix"></div>'
						content += '</div>'
						content += '</div>'
					})
					$("#usersInfo").append(content);
					$('.contact-box').each(function() {
						animationHover(this, 'pulse');
					});
				}
			});
		});
	
		/***************************** 新增用户************************************* */
		$("#addUser").click(function() {
			var realname = $("#addRealName").val();
			var username = $("#addLoginName").val();
			var password = $("#addLoginPass").val();
			var email = $("#addEmail").val();
			var telephone = $("#addTel").val();
			var roleId = $("#addRole").val();
			if (username == '' || username == null || password == '' || password == null) {
				alert("登陆名和密码必填");
			}else if(!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(telephone))){
				alert("请输入正确的手机号码");
			}else if(!(/[\u4e00-\u9fa5]+/g.test(realname))){
				alert("请输入汉字");
			}else {
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
					success : function(data) {
						var result = data.result
						if (result == "SUCCESS") {
							//							alert("添加成功");
							$('#addModal').modal('hide');
							window.location.href = "system/jumpToStaff";
							/* var content = '';
							content += '<div class="col-sm-4">'
							content += '<div class="contact-box" id="' + data.id + '">'
							content += '<div class="col-sm-4">'
							content += '<div class="text-center">'
							content += '<img alt="image" class="img-circle m-t-xs img-responsive" src="img/a2.jpg">'
							content += '<div class="m-t-xs font-bold">' + realname + '</div>'
							content += '</div>'
							content += '</div>'
							content += '<div class="col-sm-8">'
							content += '<div class="pull-right">'
	
							content += '<button onclick="editUser(' + data.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#editModal">'
							content += '<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑'
							content += '</button>'
							content += '<button onclick="deleteUser(' + data.id + ',\'' + username + '\');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delModal">'
							content += '<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除'
							content += '</button>'
							content += '</div>'
							content += '<h3><strong>姓名:' + realname + '</strong></h3>'
							content += '<address>'
							content += '<strong>角色:' + roleId + '</strong><br>'
							if (roleId == 1) {
								content += '性别:<br>'
							}
							content += 'E-mail:' + email + '<br> 身份证:<br> <abbr title="Phone">Tel:</abbr>' + telephone + '<br>'
							if (roleId == 2) {
								content += '工厂:'
							}
							if (roleId == 3) {
								content += '车牌号:'
							}
							content += '<span class="label label-info">已通过审核</span>'
	
							content += '</div>'
							content += '<div class="clearfix"></div>'
							content += '</div>'
							content += '</div>'
							$("#usersInfo").append(content);
							$('.contact-box').each(function() {
								animationHover(this, 'pulse');
							}); */
						} else if (result == "INPUT") {
							alert("登陆名和密码必填");
						} else if (result == "DUPLICATE") {
							alert("改用户名已被占用")
						} else {
							alert("添加失败")
						}
					},
					error : function(data) {
						alert("添加失败")
					}
				});
			}
		});
	
		$("#resetPassButton").click(function() {
			var userId = parseInt($("#resetUserId").val());
			$.ajax({
				type : "POST",
				url : "system/resetPassWord?userId=" + userId,
				success : function(result) {
					if (result == "SUCCESS") {
						alert("重置成功")
						$("#resetPassWordModal").modal("hide")
					} else {
						alert("重置失败")
						$("#resetPassWordModal").modal("hide")
					}
				}
			})
		})
	
		/***************************** 删除用户按钮************************************* */
		function deleteUser(userId, realname) {
			var delContent = "确定删除用户：" + realname + "?";
			$("#delModalContent").html(delContent);
			$("#delId").val(userId);
		}
	
		/***************************** 重置密码按钮************************************* */
		function resetPassWord(userId, userName) {
			var delContent = "确定为用户：" + userName + "重置密码？重置密码为66668888";
			$("#resetModalContent").html(delContent);
			$("#resetUserId").val(userId);
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
					$("#" + userId.toString()).remove()
				}
			});
		});
	
		/***************************** 修改用户按钮************************************* */
		function editUser(userId, roleId, carOrsiteId) {
			$("#editUserId").val(userId);
			$("#editRoleId").val(roleId);
			if (roleId == 2) { //工厂管理员
				$("#carSelectForm").hide()
				$("#siteSelectForm").show()
				$("#siteSelect").val(carOrsiteId)
			} else if (roleId == 3) { //司机
				$("#carSelectForm").show()
				$("#siteSelectForm").hide()
				$.ajax({
					type : "POST",
					url : "car/queryCarWhichNotAssignDriver",
					success : function(carList) {
						$("#carSelect").empty()
						var option = new Option('--暂不修改--', -1);
						var option1 = new Option('--不分配车辆--', 0);
						$("#carSelect")[0].options.add(option)
						$("#carSelect")[0].options.add(option1)
						$.each(carList, function(i, car) {
							var option = new Option(car.license, car.id);
							$("#carSelect")[0].options.add(option)
						})
					}
				})
			}
		}
	
		/***************************** 修改用户信息************************************* */
		$("#editUserSubmit").click(function() {
			var userId = parseInt($("#editUserId").val());
			var roleId = parseInt($("#editRoleId").val());
			var siteId = 0;
			var carId = 0;
	
			if (roleId == 2) {
				siteId = parseInt($("#siteSelect").val())
			} else if (roleId == 3) {
				carId = parseInt($("#carSelect").val())
			}
	
			if (roleId == 3 && carId == -1) {
				//不修改，不触发
				$('#editModal').modal('hide');
			} else {
				$.ajax({
					type : "POST",
					url : "system/editUserByUserId",
					data : JSON.stringify({
						userId : userId,
						roleId : roleId,
						siteId : siteId,
						carId : carId
					}),
					dataType : "json",
					contentType : "application/json",
					success : function(result) {
						if (result.result == "success") {
							alert("修改成功")
							$('#editModal').modal('hide');
							window.location.href = "system/jumpToStaff";
						} else {
							alert("修改用户信息失败");
						}
					}
				});
			}
	
	
	
		});
	
	
		/***************************** 审核用户按钮************************************* */
		function checkUser(userId) {
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
					$("#" + userId.toString()).remove();
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
					$("#" + userId.toString()).remove();
				}
			});
		});
	</script>

	</div>

</body>

</html>
