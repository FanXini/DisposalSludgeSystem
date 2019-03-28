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

<title>污泥处理记录</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="shortcut icon" href="favicon.ico">
<link href="css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="css/font-awesome.css?v=4.4.0" rel="stylesheet">
<link href="css/plugins/footable/footable.core.css" rel="stylesheet">
<!-- <link href="css/animate.css" rel="stylesheet"> -->
<link href="css/style.css?v=4.1.0" rel="stylesheet">
<link href="css/data/bootstrap-datetimepicker.min.css" rel="stylesheet" />



</head>

<body class="gray-bg">
	<!-- 手动分配处理人Modal -->
	<div class="modal fade" id="dealSiteModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">分配处理人</h4>
				</div>
				<div class="modal-body">
					<!-- 用来存id -->
					<input id="dealSiteId" type="hidden"/>
					<form>
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon">处理车司机</span>
								<select	id="driverSelect" class="form-control col-lg-4">
								</select>
							</div>
						</div>
					</form>
				</div>
				
				<div class="modal-body">
					<!-- 用来存id -->
					<form>
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon">运输车司机</span>
								<select	id="carrierSelect" class="form-control col-lg-4">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-l" data-dismiss="modal">取消</button>
					<button id="saveSiteDealBtn" type="button" class="btn btn-primary">保存</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改处理人</h4>
				</div>
				<div class="modal-body">
					<!-- 用来存id -->
					<input id="recordId" type="hidden" /> <input id="siteId"
						type="hidden" /> <input id="trIndex" type="hidden" />
					<form>
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon">处理人</span> <select
									id="driverSelect" class="form-control col-lg-4">
									<%-- <c:forEach items="${requestScope.assignCarDriverList }"
										var="driver">
										<option name="${driver.telephone }" id=${driver.id }>${driver.realname }</option>
									</c:forEach> --%>
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-l" data-dismiss="modal">取消</button>
					<button id="saveEditButton" type="button" class="btn btn-primary">保存</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="myModal1" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<h2 style="text-align: center;">确认删除?</h2>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-l" data-dismiss="modal">取消</button>
					<button id="deleteButton" type="button" class="btn btn-primary">删除</button>
				</div>
			</div>
		</div>
	</div>
	<div class="wrapper wrapper-content animated fadeInRight">

		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h1 class="text-info"
							style="text-align: center;font-family:KaiTi; margin-top:-1%">污泥处理记录</h1>

						<!-- <div class="ibox-tools">
							<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
							</a> <a class="dropdown-toggle" data-toggle="dropdown" href="#">
								<i class="fa fa-wrench"></i>
							</a> <a class="close-link"> <i class="fa fa-times"></i>
							</a>
						</div> -->
					</div>
					<div class="ibox-content project-list">

						<div class="col-lg-offset-2">

							<div class="form-inline">
								<div class="form-group">
									<label class="sr-only" for="search">搜索方式</label>
									<div class="input-group">
										<div class="btn-group">
											<button class="btn btn-default" disabled="disabled">搜索方式</button>
											<button class="btn btn-primary dropdown-toggle"
												data-toggle="dropdown">
												<span class="fa fa-caret-down"></span>
											</button>
											<ul class="dropdown-menu">
												<li><a class="btn btn-primary"
													href="javascript:void(0)" id="all_search">全部</a></li>
												<li><a class="btn btn-primary"
													href="javascript:void(0)" id="factory_search">工厂</a></li>
												<li><a class="btn btn-primary"
													href="javascript:void(0)" id="driver_search">负责人</a></li>
												<li><a class="btn btn-primary"
													href="javascript:void(0)" id="date-search">日期</a></li>
											</ul>
										</div>
									</div>
								</div>

								<div class="form-group col-lg-offset-1" id="siteList"
									style="margin-top:4px ;">
									<label class="sr-only" for="工厂">工厂</label>
									<div class="input-group">
										<div class="btn-group">
											<button class="btn btn-default" disabled="disabled">选择工厂</button>
											<button class="btn btn-primary dropdown-toggle"
												data-toggle="dropdown">
												<span class="fa fa-caret-down"></span>
											</button>
											<ul class="dropdown-menu">

												<c:forEach items="${requestScope.siteList }" var="site">
													<li><a class="btn btn-primary site" name="${site.id }"
														href="javascript:void(0)">${site.siteName }</a></li>

												</c:forEach>



											</ul>
										</div>
									</div>
								</div>

								<div class="form-group col-lg-offset-1" id="driverList"
									style="margin-top: 4px;">
									<label class="sr-only" for="司机">负责人</label>
									<div class="btn-group">
										<button class="btn btn-default" disabled="disabled">选择负责人</button>
										<button class="btn btn-primary dropdown-toggle"
											data-toggle="dropdown">
											<span class="fa fa-caret-down"></span>
										</button>
										<ul class="dropdown-menu">

											<c:forEach items="${requestScope.assignCarTreatDriver }" var="driver">
												<li><a class="btn btn-success driver"
													name="${driver.id }" href="javascript:void(0)">${driver.realname }</a></li>
											</c:forEach>
										</ul>
									</div>
								</div>

								<div class="form-group" id="start_date">
									<label class="sr-only" for="time">起始时间</label>
									<div class="input-group date form_date">
										<span class="input-group-addon">起始时间&nbsp;<i
											class="fa fa-calendar-o"></i></span> <input id="start_date_text"
											type="text" class="form-control" readonly /> <span
											class="input-group-addon"><span
											class="glyphicon glyphicon-remove"></span></span> <span
											class="input-group-addon"><span
											class="glyphicon glyphicon-calendar"></span></span>
									</div>
								</div>

								<div class="form-group" id="end_date">
									<label class="sr-only" for="time">截止时间</label>
									<div class="input-group date form_date">
										<span class="input-group-addon">截止时间&nbsp;<i
											class="fa fa-calendar-o"></i></span> <input id="end_date_text"
											type="text" class="form-control" readonly /> <span
											class="input-group-addon"><span
											class="glyphicon glyphicon-remove"></span></span> <span
											class="input-group-addon"><span
											class="glyphicon glyphicon-calendar"></span></span>
									</div>
								</div>
								<button class="btn btn-primary" id="submit"
									style="margin-top:3px">查询</button>

							</div>

							<!--<input type="text" class="form-control input-sm m-b-xs" id="filter" placeholder="搜索表格...">-->
						</div>

						<div id="tableDiv" style="red"></div>



					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 全局js -->
	<script src="js/jquery.min.js?v=2.1.4"></script>
	<script src="js/bootstrap.min.js?v=3.3.6"></script>
	<script src="js/plugins/data/bootstrap-datetimepicker.min.js"></script>
	<script src="js/plugins/data/bootstrap-datetimepicker.zh-CN.js"></script>
	<script src="js/plugins/footable/footable.all.min.js"></script>



	<!-- 自定义js -->
	<script src="js/content.js?v=1.0.0"></script>
	<script>
		$(document).ready(function() {
			var table_start = '<table id="table" class="footable table-hover table table-stripped toggle-arrow-tiny" data-page-size="7">' +
				'<thead>' +
				'<tr>' +
				'<th data-toggle="true">状态</th>' +
				'<th>工厂</th>' +
				/* '<th>污泥处理量</th>' + */
				'<th>任务分配时间</th>' +
				'<th>产生污泥块量</th>' +
				'<th>污泥运输记录</th>' +
				'<th>操作</th>' +
				'<th data-hide="all">污泥处理开始时间</th>' +
				'<th data-hide="all">污泥处理完成时间</th>' +
				'<th data-hide="all">工厂地址</th>' +
				'<th data-hide="all">工厂联系号码</th>' +
				'<th data-hide="all">处理车辆</th>' +
				'</tr>' +
				'</thead>' +
				'<tbody>'
			var table_end = '</tbody>' +
				'<tfoot>' +
				'<tr>' +
				'<td colspan="5">' +
				'<ul class="pagination pull-right"></ul>' +
				'</td>' +
				'</tr>' +
				'</tfoot>' +
				'</table>'
	
	
			$(".form_date").datetimepicker({
				format : "yyyy-mm-dd hh:00",
				language : 'zh-CN',
				weekStart : 1,
				todayBtn : true,
				autoClose : 1,
				startView : 2,
				todayHighlight : 1,
				minView : 1
			});
	
			$("#driverList").hide()
			$(".form_date").hide()
			$("#submit").hide()
	
			$("#factory_search").click(function() {
				$("#siteList").show()
				$("#driverList").hide()
				$(".form_date").hide()
				$("#submit").hide()
			})
	
			$("#driver_search").click(function() {
				$("#siteList").hide()
				$("#driverList").show()
				$(".form_date").hide()
				$("#submit").hide()
			})
	
			$("#date-search").click(function() {
				$("#siteList").hide()
				$("#driverList").hide()
				$(".form_date").show()
				$("#submit").show()
			})

			$.ajax({
				type : "POST",
				url : "record/queryAllRecord",
				dataType : "json",
				contentType : "application/json",
				success : function(recordList) {
					$("#tableDiv").empty()
					var table = table_start
					$.each(recordList, function(i, record) {
						console.log(JSON.stringify(record.recordTreatCars))
						table += '<tr>'
						if (record.status == 0) {
							table += '<td class="project-status"><span class="label label-inverse">已完成</td>'
						} else if (record.status == 1) {
							table += '<td class="project-status"><span class="label label-danger">处理中</td>'
						} else if (record.status == 2) {
							table += '<td class="project-status"><span class="label label-primary">待处理</td>'
						} else{
							table+='<td class="project-status"><span class="label label-warning">待审核</td>'
						}
						table += '<td>' + (record.site.siteName ==null?"": record.site.siteName) + '</td>'
						//table += '<td class="project-manage">' + (record.car.driver.realname ==null?"":record.car.driver.realname) + '</td>' 
						table += '<td>' + (record.allocationTime ==null?"":  record.allocationTime) + '</td>'
						table += '<td>' + (record.sludgesWeight ==null?"0":  record.sludgesWeight) + '吨</td>'
						table += '<td><a href='+"record/jumpToSludgesOfOneRecord?recordId="+''+record.id+'>查看详情</a></td>'
						if(record.status==1||record.status==2){
							table += '<td class="project-actions" style="float:left;">' +
							'<button onclick="javascript:deleteRecord(' + i + ',' + record.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#myModal1"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
							'<button onclick="javascript:dealSite(' + record.siteId + ');" class="btn btn-white btn-sm"><i class="fa fa-pencil"></i> 分配处理人 </button>' +
							'</td>'
						}
						else{
							table += '<td class="project-actions" style="float:left;">' +
							'<button onclick="javascript:deleteRecord(' + i + ',' + record.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#myModal1"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
							'</td>'
						}
					 	table += '<td>' + (record.disposalTime ==null?"":  record.disposalTime)+ '</td>'
						table += '<td><span class="pie">' + (record.finishTime ==null?"": record.finishTime) + '</span></td>'
						table += '<td>' + (record.site.address ==null?"": record.site.address) + '</td>'
						table += '<td>' + (record.site.telephone ==null?"": record.site.telephone) + '</td>'
						table += '<td>'
						for(var i=0;i<record.recordTreatCars.length;i++){
							var car=record.recordTreatCars[i].treatcar;
							table+=car.license+"  处理人:"+car.driver.realname+" 联系方式:"+(car.driver.telephone==null?"无": car.driver.telephone)+"</br>";
						}
						table += '</td>'
						table += '</tr>'
	
					})
					table += table_end
					$('#tableDiv').append(table)
					$('.footable').footable();
	
				}
			})
	
			$("#myModal").on('shown.bs.modal', function() {
				$.ajax({
					type : "POST",
					url : "car/queryDriverUnassign",
					success : function(driverList) {
						$("#driverSelect").empty();
						if (driverList.length == 0) {
							var option = new Option('-暂无空闲司机-')
							$("#driverSelect")[0].options.add(option);
						} else {
							$.each(driverList, function(i, driver) {
	
								var option = new Option(driver.realname, driver.id);
								option.setAttribute("name", driver.telephone);
								/* $("#editDriverId").append('<option name="'+driver.telephone+'" value="'+driver.id+'">''</option>') */
								$("#driverSelect")[0].options.add(option)
							});
						}
					}
				});
			})
	
			/*----------------------------------- 搜索全部按钮 ------------------------------------------*/
			$("#all_search").click(function() {
				$.ajax({
					type : "POST",
					url : "record/queryAllRecord",
					dataType : "json",
					contentType : "application/json",
					success : function(recordList) {
						$("#tableDiv").empty()
						var table = table_start
						$.each(recordList, function(i, record) {
							console.log(JSON.stringify(record.recordTreatCars))
							table += '<tr>'
							if (record.status == 0) {
								table += '<td class="project-status"><span class="label label-inverse">已完成</td>'
							} else if (record.status == 1) {
								table += '<td class="project-status"><span class="label label-danger">处理中</td>'
							} else if (record.status == 2) {
								table += '<td class="project-status"><span class="label label-primary">待处理</td>'
							} else{
								table+='<td class="project-status"><span class="label label-warning">待审核</td>'
							}
							table += '<td>' + (record.site.siteName ==null?"": record.site.siteName) + '</td>'
							//table += '<td class="project-manage">' + (record.car.driver.realname ==null?"":record.car.driver.realname) + '</td>' 
							table += '<td>' + (record.allocationTime ==null?"":  record.allocationTime) + '</td>'
							table += '<td>' + (record.sludgesWeight ==null?"0":  record.sludgesWeight) + '吨</td>'
							table += '<td><a href='+"record/jumpToSludgesOfOneRecord?recordId="+''+record.id+'>查看详情</a></td>'
							if(record.status==1||record.status==2){
								table += '<td class="project-actions" style="float:left;">' +
								'<button onclick="javascript:deleteRecord(' + i + ',' + record.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#myModal1"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'<button onclick="javascript:dealSite(' + record.siteId + ');" class="btn btn-white btn-sm"><i class="fa fa-pencil"></i> 分配处理人 </button>' +
								'</td>'
							}
							else{
								table += '<td class="project-actions" style="float:left;">' +
								'<button onclick="javascript:deleteRecord(' + i + ',' + record.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#myModal1"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'</td>'
							}
						 	table += '<td>' + (record.disposalTime ==null?"":  record.disposalTime)+ '</td>'
							table += '<td><span class="pie">' + (record.finishTime ==null?"": record.finishTime) + '</span></td>'
							table += '<td>' + (record.site.address ==null?"": record.site.address) + '</td>'
							table += '<td>' + (record.site.telephone ==null?"": record.site.telephone) + '</td>'
							table += '<td>'
							for(var i=0;i<record.recordTreatCars.length;i++){
								var car=record.recordTreatCars[i].treatcar;
								table+=car.license+"  处理人:"+car.driver.realname+" 联系方式:"+(car.driver.telephone==null?"无": car.driver.telephone)+"</br>";
							}
							table += '</td>'
							table += '</tr>'
		
						})
						table += table_end
						$('#tableDiv').append(table)
						$('.footable').footable();
	
					}
				})
	
			})
	
			/*----------------------------------- 按工厂搜索按钮 ------------------------------------------*/
			$(".site").click(function() {
				var siteId = parseInt(this.getAttribute("name"))
				$.ajax({
					type : "POST",
					url : "record/queryRecordBySiteId?siteId=" + siteId,
					dataType : "json",
					contentType : "application/json",
					success : function(recordList) {
						$("#tableDiv").empty()
						var table = table_start
						$.each(recordList, function(i, record) {
							console.log(JSON.stringify(record.recordTreatCars))
							table += '<tr>'
							if (record.status == 0) {
								table += '<td class="project-status"><span class="label label-inverse">已完成</td>'
							} else if (record.status == 1) {
								table += '<td class="project-status"><span class="label label-danger">处理中</td>'
							} else if (record.status == 2) {
								table += '<td class="project-status"><span class="label label-primary">待处理</td>'
							} else{
								table+='<td class="project-status"><span class="label label-warning">待审核</td>'
							}
							table += '<td>' + (record.site.siteName ==null?"": record.site.siteName) + '</td>'
							//table += '<td class="project-manage">' + (record.car.driver.realname ==null?"":record.car.driver.realname) + '</td>' 
							table += '<td>' + (record.allocationTime ==null?"":  record.allocationTime) + '</td>'
							table += '<td>' + (record.sludgesWeight ==null?"0":  record.sludgesWeight) + '吨</td>'
							table += '<td><a href='+"record/jumpToSludgesOfOneRecord?recordId="+''+record.id+'>查看详情</a></td>'
							if(record.status==1||record.status==2){
								table += '<td class="project-actions" style="float:left;">' +
								'<button onclick="javascript:deleteRecord(' + i + ',' + record.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#myModal1"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'<button onclick="javascript:dealSite(' + record.siteId + ');" class="btn btn-white btn-sm"><i class="fa fa-pencil"></i> 分配处理人 </button>' +
								'</td>'
							}
							else{
								table += '<td class="project-actions" style="float:left;">' +
								'<button onclick="javascript:deleteRecord(' + i + ',' + record.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#myModal1"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'</td>'
							}
						 	table += '<td>' + (record.disposalTime ==null?"":  record.disposalTime)+ '</td>'
							table += '<td><span class="pie">' + (record.finishTime ==null?"": record.finishTime) + '</span></td>'
							table += '<td>' + (record.site.address ==null?"": record.site.address) + '</td>'
							table += '<td>' + (record.site.telephone ==null?"": record.site.telephone) + '</td>'
							table += '<td>'
							for(var i=0;i<record.recordTreatCars.length;i++){
								var car=record.recordTreatCars[i].treatcar;
								table+=car.license+"  处理人:"+car.driver.realname+" 联系方式:"+(car.driver.telephone==null?"无": car.driver.telephone)+"</br>";
							}
							table += '</td>'
							table += '</tr>'
		
						})
						table += table_end
						$('#tableDiv').append(table)
						$('.footable').footable();
	
					}
				})
			})
			/*----------------------------------- 按司机搜索按钮 ------------------------------------------*/
			$(".driver").click(function() {
				var driverId = parseInt(this.getAttribute("name"))
				$.ajax({
					type : "POST",
					url : "record/queryRecordByDriverId?driverId=" + driverId,
					dataType : "json",
					contentType : "application/json",
					success : function(recordList) {
						$("#tableDiv").empty()
						var table = table_start
						$.each(recordList, function(i, record) {
							console.log(JSON.stringify(record.recordTreatCars))
							table += '<tr>'
							if (record.status == 0) {
								table += '<td class="project-status"><span class="label label-inverse">已完成</td>'
							} else if (record.status == 1) {
								table += '<td class="project-status"><span class="label label-danger">处理中</td>'
							} else if (record.status == 2) {
								table += '<td class="project-status"><span class="label label-primary">待处理</td>'
							} else{
								table+='<td class="project-status"><span class="label label-warning">待审核</td>'
							}
							table += '<td>' + (record.site.siteName ==null?"": record.site.siteName) + '</td>'
							//table += '<td class="project-manage">' + (record.car.driver.realname ==null?"":record.car.driver.realname) + '</td>' 
							table += '<td>' + (record.allocationTime ==null?"":  record.allocationTime) + '</td>'
							table += '<td>' + (record.sludgesWeight ==null?"0":  record.sludgesWeight) + '吨</td>'
							table += '<td><a href='+"record/jumpToSludgesOfOneRecord?recordId="+''+record.id+'>查看详情</a></td>'
							if(record.status==1||record.status==2){
								table += '<td class="project-actions" style="float:left;">' +
								'<button onclick="javascript:deleteRecord(' + i + ',' + record.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#myModal1"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'<button onclick="javascript:dealSite(' + record.siteId + ');" class="btn btn-white btn-sm"><i class="fa fa-pencil"></i> 分配处理人 </button>' +
								'</td>'
							}
							else{
								table += '<td class="project-actions" style="float:left;">' +
								'<button onclick="javascript:deleteRecord(' + i + ',' + record.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#myModal1"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'</td>'
							}
						 	table += '<td>' + (record.disposalTime ==null?"":  record.disposalTime)+ '</td>'
							table += '<td><span class="pie">' + (record.finishTime ==null?"": record.finishTime) + '</span></td>'
							table += '<td>' + (record.site.address ==null?"": record.site.address) + '</td>'
							table += '<td>' + (record.site.telephone ==null?"": record.site.telephone) + '</td>'
							table += '<td>'
							for(var i=0;i<record.recordTreatCars.length;i++){
								var car=record.recordTreatCars[i].treatcar;
								table+=car.license+"  处理人:"+car.driver.realname+" 联系方式:"+(car.driver.telephone==null?"无": car.driver.telephone)+"</br>";
							}
							table += '</td>'
							table += '</tr>'
		
						})
						table += table_end
						$('#tableDiv').append(table)
						$('.footable').footable();
	
					}
				})
			})
			/*----------------------------------- 按日期搜索按钮 ------------------------------------------*/
			$("#submit").click(function() {
				var startDate = $("#start_date_text").val()
				var endDate = $("#end_date_text").val()
				$.ajax({
					type : "POST",
					url : "record/queryRecordByDate?startDate=" + startDate + "&endDate=" + endDate,
					dataType : "json",
					contentType : "application/json",
					success : function(recordList) {
						$("#tableDiv").empty()
						var table = table_start
						$.each(recordList, function(i, record) {
							console.log(JSON.stringify(record.recordTreatCars))
							table += '<tr>'
							if (record.status == 0) {
								table += '<td class="project-status"><span class="label label-inverse">已完成</td>'
							} else if (record.status == 1) {
								table += '<td class="project-status"><span class="label label-danger">处理中</td>'
							} else if (record.status == 2) {
								table += '<td class="project-status"><span class="label label-primary">待处理</td>'
							} else{
								table+='<td class="project-status"><span class="label label-warning">待审核</td>'
							}
							table += '<td>' + (record.site.siteName ==null?"": record.site.siteName) + '</td>'
							//table += '<td class="project-manage">' + (record.car.driver.realname ==null?"":record.car.driver.realname) + '</td>' 
							table += '<td>' + (record.allocationTime ==null?"":  record.allocationTime) + '</td>'
							table += '<td>' + (record.sludgesWeight ==null?"0":  record.sludgesWeight) + '吨</td>'
							table += '<td><a href='+"record/jumpToSludgesOfOneRecord?recordId="+''+record.id+'>查看详情</a></td>'
							if(record.status==1||record.status==2){
								table += '<td class="project-actions" style="float:left;">' +
								'<button onclick="javascript:deleteRecord(' + i + ',' + record.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#myModal1"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'<button onclick="javascript:dealSite(' + record.siteId + ');" class="btn btn-white btn-sm"><i class="fa fa-pencil"></i> 分配处理人 </button>' +
								'</td>'
							}
							else{
								table += '<td class="project-actions" style="float:left;">' +
								'<button onclick="javascript:deleteRecord(' + i + ',' + record.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#myModal1"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'</td>'
							}
						 	table += '<td>' + (record.disposalTime ==null?"":  record.disposalTime)+ '</td>'
							table += '<td><span class="pie">' + (record.finishTime ==null?"": record.finishTime) + '</span></td>'
							table += '<td>' + (record.site.address ==null?"": record.site.address) + '</td>'
							table += '<td>' + (record.site.telephone ==null?"": record.site.telephone) + '</td>'
							table += '<td>'
							for(var i=0;i<record.recordTreatCars.length;i++){
								var car=record.recordTreatCars[i].treatcar;
								table+=car.license+"  处理人:"+car.driver.realname+" 联系方式:"+(car.driver.telephone==null?"无": car.driver.telephone)+"</br>";
							}
							table += '</td>'
							table += '</tr>'
		
						})
						table += table_end
						$('#tableDiv').append(table)
						$('.footable').footable();
					}
				})
			})
	
			/*----------------------------------- 确认修改 ------------------------------------------*/
			$("#saveEditButton").click(function() {
				var recordId = $("#recordId").val()
				var siteId = $("#siteId").val()
				var options = $("#driverSelect option:selected");
				var driverName = options.text()
				var driverId = $("#driverSelect").val()
				var telephone = options.attr("name")
				$.ajax({
					type : "POST",
					url : "record/editRecord",
					data : JSON.stringify({
						recordId : recordId,
						driverId : driverId,
						siteId : siteId
					}),
					dataType : "json",
					contentType : "application/json",
					success : function(data) {
						var result = data.result
						if (result == "SUCCESS") {
							alert("修改成功")
							var index = parseInt($("#trIndex").val())
							document.getElementById("table").rows[index + 1].cells[2].innerText = driverName;
							document.getElementById("table").rows[index + 1].cells[10].innerText = telephone;
							document.getElementById("table").rows[index + 1].cells[11].innerText = data.license;
							$('#myModal').modal('hide')
						} else if (result == "CONFLICT") {
							alert("车辆以出发,不可修改")
							$('#myModal').modal('hide')
						} else {
							alert("修改失败")
						}
					},
					error : function(data) {
						alert("修改失败")
					}
				})
			})
			/*----------------------------------- 确认删除 ------------------------------------------*/
			$("#deleteButton").click(function() {
				var recordId = $("#recordId").val()
				var driverName = $("#driverSelect").val()
				var index = parseInt($("#trIndex").val());
				$.ajax({
					type : "POST",
					url : "record/deleteRecord?recordId=" + recordId,
					success : function(result) {
						if (result == "SUCCESS") {
							document.getElementById("table").rows[index + 1].style.display = "none"
							$('#myModal1').modal('hide')
						} else {
							alert("删除失败")
						}
					},
					error : function(result) {
						alert("删除失败")
					}
				})
	
			})
	
		});
	
		/***************************** 手动任务分配************************************* */	
		function dealSite(siteId){
			$("#dealSiteId").val(siteId);
			//查询空闲处理车
			$.ajax({
	  				type : "POST",
	  				url : "car/queryTreatmentCarUnassign",
	  				success : function(carList) {
	  					$("#driverSelect").empty();
	  					$("#driverSelect").append('<option value="-1">暂不分配</option>')
	  					$.each(carList,function(i, car) {
	  						$("#driverSelect").append('<option id="'+car.id+'" value="'+car.id+'">'+car.driver.realname+'</option>')
	  					});
	  				}
	  			});
			//查询空闲运输车
			$.ajax({
					type : "POST",
					url : "car/queryCarrierUnassign",
					success : function(carList) {
						if(jQuery.isEmptyObject(carList))
							alert("暂无空闲车辆");
						else{
							console.log(carList)
							$("#carrierSelect").empty();
							$("#carrierSelect").append('<option value="-1">暂不分配</option>')
							$.each(carList,function(i, car) {
								$("#carrierSelect").append('<option id="'+car.id+'" value="'+car.id+'">'+car.driver.realname+'</option>')
							});
							$('#dealSiteModal').modal('show');
						}
					}
				});
		}
		
		$("#saveSiteDealBtn").click(function (){
			var dealSiteId=$("#dealSiteId").val();
			var driverSelect=$("#driverSelect").val();
			var transcarId=$("#carrierSelect").val();
			$.ajax({
	  			type : "POST",
	  			url : "record/assignDriverForRecord",
	  			data : {"siteId" : dealSiteId,
	  					"treatcarId" : driverSelect,
	  					"transcarId":transcarId
	  			},
	  			success : function(result) {
					if(result=="SUCCESS"){
	 					alert("分配成功");
	 					showNum();
	 				}
	  				else{
	  					alert("分配失败");
					}
	  			}
	  		});
			$('#dealSiteModal').modal('hide');
		});
		
		/*----------------------------------- 删除------------------------------------------*/
		function deleteRecord(index, recordId) {
			$("#recordId").val(recordId)
			$("#trIndex").val(index)
		}
	</script>

</body>

</html>
