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
	<!-- 用来存id -->
	<input id="recordId" type="hidden" />
	<input id="trIndex" type="hidden" />


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
							</a>
							<ul class="dropdown-menu dropdown-user">
								<li><a href="#">选项 01</a></li>
								<li><a href="#">选项 02</a></li>
							</ul>
							<a class="close-link"> <i class="fa fa-times"></i>
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
				'<th>任务分配时间</th>' +
				'<th>污泥处理量</th>' +
				/* '<th>产生污泥块量</th>' + */
				'<th data-hide="all">污泥处理开始时间</th>' +
				'<th data-hide="all">污泥处理完成时间</th>' +
				'<th data-hide="all">工厂地址</th>' +
				'<th data-hide="all">工厂联系号码</th>' +
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
	
			$(".form_date").hide()
			$("#submit").hide()
	
			$("#factory_search").click(function() {
				$("#siteList").show()
				$(".form_date").hide()
				$("#submit").hide()
			})
	
	
			$("#date-search").click(function() {
				$("#siteList").hide()
				$(".form_date").show()
				$("#submit").show()
			})
	
			$.ajax({
				type : "POST",
				url : "record/queryAllRecordOfOneDriver",
				data:JSON.stringify({
					id:${sessionScope.user.id}
				}),
				dataType : "json",
				contentType : "application/json",
				success : function(recordList) {
					$("#tableDiv").empty()
					var table = table_start
					$.each(recordList, function(i, record) {
						var per=parseInt(Math.random()*100)
						table+='<tr>'
						if(record.status==0){
							table += '<td class="project-status"><span class="label label-primary">已完成</td>'
						}
						else if(record.status==1){
							table += '<td class="project-status"><span class="label label-danger">处理中</td>'
						}
						else if(record.status==2){
							table += '<td class="project-status"><span class="label label-inverse">待处理</td>'
						}
						else{
							table+='<td></td>'
						}
						table += '<td>' + record.site.siteName + '</td>'
						/* table += '<td class="project-completion">' +
							'<small>污泥处理量：'+per+' %</small>' +
							'<div class="progress progress-mini">' +
							'<div style="width: '+per+'%;" class="progress-bar"></div>' +
							'</div>' +
							'</td>' */
						table += '<td>' + record.allocationTime + '</td>'
						if (record.sludge.weight == 0) {
							table += '<td><span class="label label-success">待输入</td>'
						} else {
							table += '<td>' + record.sludge.weight + '吨</td>'
						}
						table += '<td>' + record.disposalTime + '</td>'
						table += '<td><span class="pie">' + record.finishTime + '</span></td>'
						table += '<td>' + record.site.address + '</td>'
						table += '<td>' + record.site.telephone + '</td>'
						table += '</tr>'
	
					})
					table += table_end
					$('#tableDiv').append(table)
					$('.footable').footable();
	
				}
			})
	
			/*----------------------------------- 搜索全部按钮 ------------------------------------------*/
			$("#all_search").click(function() {
				$.ajax({
				type : "POST",
				url : "record/queryAllRecordOfOneDriver",
				data:JSON.stringify({
					id:${sessionScope.user.id}
				}),
				dataType : "json",
				contentType : "application/json",
				success : function(recordList) {
					$("#tableDiv").empty()
					var table = table_start
					$.each(recordList, function(i, record) {
						table+='<tr>'
						if(record.status==0){
							table += '<td class="project-status"><span class="label label-primary">已完成</td>'
						}
						else if(record.status==1){
							table += '<td class="project-status"><span class="label label-danger">处理中</td>'
						}
						else if(record.status==2){
							table += '<td class="project-status"><span class="label label-inverse">待处理</td>'
						}
						else{
							table+='<td></td>'
						}
						table += '<td>' + record.site.siteName + '</td>'
						table += '<td>' + record.allocationTime + '</td>'
						if (record.sludge.weight == 0) {
							table += '<td><span class="label label-success">待输入</td>'
						} else {
							table += '<td>' + record.sludge.weight + '吨</td>'
						}
						table += '<td>' + record.disposalTime + '</td>'
						table += '<td><span class="pie">' + record.finishTime + '</span></td>'
						table += '<td>' + record.site.address + '</td>'
						table += '<td>' + record.site.telephone + '</td>'
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
				var siteId = this.getAttribute("name")
				$.ajax({
					type : "POST",
					url : "record/queryRecordBySiteIdOfOneDriver",
					data:JSON.stringify({
						driverId:${sessionScope.user.id},
						siteId:siteId
					}),
					dataType : "json",
					contentType : "application/json",
					success : function(recordList) {
						$("#tableDiv").empty()
					var table = table_start
					$.each(recordList, function(i, record) {
						table+='<tr>'
						if(record.status==0){
							table += '<td class="project-status"><span class="label label-primary">已完成</td>'
						}
						else if(record.status==1){
							table += '<td class="project-status"><span class="label label-danger">处理中</td>'
						}
						else if(record.status==2){
							table += '<td class="project-status"><span class="label label-inverse">待处理</td>'
						}
						else{
							table+='<td></td>'
						}
						table += '<td>' + record.site.siteName + '</td>'
						table += '<td>' + record.allocationTime + '</td>'
						if (record.sludge.weight == 0) {
							table += '<td><span class="label label-success">待输入</td>'
						} else {
							table += '<td>' + record.sludge.weight + '吨</td>'
						}
						table += '<td>' + record.disposalTime + '</td>'
						table += '<td><span class="pie">' + record.finishTime + '</span></td>'
						table += '<td>' + record.site.address + '</td>'
						table += '<td>' + record.site.telephone + '</td>'
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
					url : "record/queryRecordByDateOfOneDriver",
					dataType : "json",
					data:JSON.stringify({
						driverId:${sessionScope.user.id},
						startDate:startDate,
						endDate:endDate
					}),
					contentType : "application/json",
					success : function(recordList) {
						$("#tableDiv").empty()
					var table = table_start
					$.each(recordList, function(i, record) {
						table+='<tr>'
						if(record.status==0){
							table += '<td class="project-status"><span class="label label-primary">已完成</td>'
						}
						else if(record.status==1){
							table += '<td class="project-status"><span class="label label-danger">处理中</td>'
						}
						else if(record.status==2){
							table += '<td class="project-status"><span class="label label-inverse">待处理</td>'
						}
						else{
							table+='<td></td>'
						}
						table += '<td>' + record.site.siteName + '</td>'
						table += '<td>' + record.allocationTime + '</td>'
						if (record.sludge.weight == 0) {
							table += '<td><span class="label label-success">待输入</td>'
						} else {
							table += '<td>' + record.sludge.weight + '吨</td>'
						}
						table += '<td>' + record.disposalTime + '</td>'
						table += '<td><span class="pie">' + record.finishTime + '</span></td>'
						table += '<td>' + record.site.address + '</td>'
						table += '<td>' + record.site.telephone + '</td>'
						table += '</tr>'
	
					})
					table += table_end
					$('#tableDiv').append(table)
					$('.footable').footable();
	
					}
				})
			})
	
		});
	
		
	</script>

</body>

</html>
