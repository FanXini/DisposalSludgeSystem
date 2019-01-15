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

<title>污泥块去向记录</title>

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
<link href="css/plugins/dataTables/dataTables.bootstrap.css">
<link href="css/data/bootstrap-datetimepicker.min.css" rel="stylesheet" />

<style>
#customers {
	font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
	width: 100%;
	border-collapse: collapse;
}

#customers td, #customers th {
	font-size: 1em;
	border: 1px solid #6A5ACD;
	padding: 3px 7px 2px 7px;
}

#customers th {
	font-size: 1.1em;
	text-align: left;
	padding-top: 5px;
	padding-bottom: 4px;
	background-color: #6A5ACD;
	color: #ffffff;
}

#customers tr.alt td {
	color: #000000;
	background-color: #6A5ACD;
}
</style>
</head>

</head>

<body class="gray-bg">
	<!-- 用来存id -->
	<input id="sludgeId" type="hidden" />
	<input id="trIndex" type="hidden" />
	  <body>
	<%
		java.text.SimpleDateFormat simpleDateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.util.Date currentTime = new java.util.Date();
		String time = simpleDateFormat.format(currentTime).toString();
	%>

	<!-- Modal -->

	<!-- ***********************************新增车辆模态框************************************* -->
	<div class="modal inmodal" id="addSludgeModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content animated bounceInRight">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
					</button>
					<img alt="140x140" src="img/littercar.png" width="10%" height="10%" />
					<h4 class="modal-title">新增污泥运输记录</h4>
				</div>
				<div class="modal-body">
					<div class="container" style="width: 540px">
						<div class="form-group">
							<div>
								<label for="Groupname" class="col-sm-3 control-label">车牌号：</label>
								<div class="col-sm-9">
									<input type="text" class="form-control m-b control-label"
										id="CarLicense"
										value="${requestScope.sludgeList.get(0).car.license}">
								</div>
							</div>
						</div>
						<div class="form-group">
							<div>
								<label for="Groupname" class="col-sm-3 control-label">司机：</label>
								<div class="col-sm-9">
									<input type="text" class="form-control m-b" id="CarDriver"
										value="${sessionScope.user.realname}">
								</div>
							</div>
						</div>
						<div class="form-group">
							<div>
								<label for="Groupname" class="col-sm-3 control-label">任务编号：</label>
								<div class="col-sm-9">
									<input type="text" class="form-control m-b" id="addRecordId"
										value=" ">
								</div>
							</div>
						</div>
						<div class="form-group">
							<div>
								<label for="Groupname" class="col-sm-3 control-label">污泥块编号：</label>
								<div class="col-sm-9">
									<input type="text" class="form-control m-b" id="addSludgeRFID"
										placeholder="请输入污泥块编号">
								</div>
							</div>
						</div>
						<div class="form-group">
							<div>
								<label for="Groupname" class="col-sm-3 control-label">污泥块重量：</label>
								<div class="col-sm-9">
									<input type="text" class="form-control m-b"
										id="addSludgeWeight" placeholder="请输入污泥块重量">
								</div>
							</div>
						</div>
						<div class="form-group">
							<div>
								<label for="Groupname" class="col-sm-3 control-label">目的地：</label>
								<div class="col-sm-9">
									<input type="text" class="form-control m-b" id="addDestination"
										placeholder="请输入运输目的地">
								</div>
							</div>
						</div>
						<div class="form-group">
							<div>
								<label for="Groupname" class="col-sm-3 control-label">生成时间：</label>
								<div class="col-sm-9">
									<input type="text" class="form-control m-b" id="addProduceTime"
										value="<%=time%>">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="reset" class="btn btn-white" data-dismiss="modal">重置</button>
					<button id="addSludgeButton" type="button" class="btn btn-primary">提交</button>
				</div>
			</div>
		</div>
	</div>

	<div class="col-sm-12">
		<div class="ibox float-e-margins">
			<div class="ibox-title">
				<h1 class="text-info"
					style="text-align: center; font-family: KaiTi; margin-top: -1%">运输司机工作记录</h1>
			</div>
			<div class="ibox-content project-list">
				<div class="search-left">
					<div class="col-xs-1 query-department text-center">
						<button type="button" class="btn btn-primary" data-toggle="modal"
							data-target="#addSludgeModal">+ 新增污泥块运输记录</button>
					</div>
				</div>

				<div class="row">
					<div class="search-right">
						<div class="col-xs-offset-5 col-xs-4 query-department">
							<form method="get" class="form-horizontal">
								<div class="form-group">
									<div>
										<input id="queryCondition" type="text" class="form-control"
											placeholder="请输入任务编号/污泥块编号/污泥块产地/运输目的地">
									</div>
								</div>
						</div>
						<div class="col-xs-1 query-department">
							<button id="queryButton" class="btn btn-primary" type="button">查询</button>
						</div>
					</div>

				</div>

				<!-- 记录列表 -->
				<!-- Example Pagination -->
				<div class="form-horizontal" id=sludgeList>
					<div class="contact-box" id="${sludge.id}">
						<table id=customers >
							<tr>
								<th>任务编号</th>
								<th>污泥块编号</th>
								<th>污泥块生成时间</th>
								<th>污泥块产地</th>
								<th>运输目的地</th>
								<th>污泥块重量</th>
							</tr>
							<tr id=row>
								<c:forEach items="${requestScope.sludgeList}" var="sludge">
									<td>${sludge.recordId}</td>
									<td>${sludge.rfidString}</td>
									<td>${sludge.produceTime}</td>
									<td>${sludge.record.site.siteName}</td>
									<td>${sludge.destinationAddress}</td>
									<td>${sludge.weight}</td>
							</tr>
							</c:forEach>
						</table>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 全局js -->
	<script src="js/jquery.min.js?v=2.1.4"></script>
	<script src="js/bootstrap.min.js?v=3.3.6"></script>
	<script src="js/jquery.min.js?v=2.1.4"></script>
	<script src="js/bootstrap.min.js?v=3.3.6"></script>
	<!-- jQuery Validation plugin javascript--> 
	<script src="js/plugins/data/bootstrap-datetimepicker.min.js"></script>
	<script src="js/plugins/data/bootstrap-datetimepicker.zh-CN.js"></script>
	<script src="js/plugins/footable/footable.all.min.js"></script>
	
	<!-- Data Tables -->
	<script src="js/plugins/dataTables/jquery.dataTables.js"></script> 
	<script src="js/plugins/dataTables/dataTables.bootstrap.js"></script>
	<script src="js/plugins/validate/jquery.validate.min.js"></script> 
	<script src="js/plugins/validate/messages_zh.min.js"></script>
	<script src="js/system/form-validate-siteManage.js"></script> 
	<!-- distpicker --> 
	<script src="js/distpicker/distpicker.data.js"></script> 
	<script src="js/distpicker/distpicker.js"></script>
	<script src="js/distpicker/main.js"></script> 
	<!-- Chosen --> 
	<script src="js/plugins/chosen/chosen.jquery.js"></script> 
	<!-- 自定义js -->
	<script src="js/content.js?v=1.0.0"></script>
	<script src="http://cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>  
	<script src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>  
	<script>
	$(document).ready(function() {
		$("#addSludgeModal").on('shown.bs.modal', function() {
	 	var driverId = ${sessionScope.user.id}
	 		$.ajax({
			type : "POST",
			url : "sludge/querysludgebydriverIdAndStatus",
			data : "driverId="+driverId,
			success : function(sludge) {
						if(sludge==""){
							alert('当前未分配污泥运输任务，无需添加记录')
						}					
						else{
							$("#addRecordId").val(sludge.recordId);
						}
					}
				});
			});

	   
	   $("#addSludgeButton").click(function() {
	   var rfidString = $("#addSludgeRFID").val();
	   var produceTime = $("#addProduceTime").val();
	   var recordId = $("#addRecordId").val();
	   var destinationAddress = $("#addDestination").val();
	   var weight = $("#addSludgeWeight").val();
	   var transcarId = ${requestScope.sludgeList.get(0).transcarId};
	   $.ajax({
	   		type:"POST",
	   		url : "sludge/insertSludgeByDriver",
	   		data : JSON.stringify({
	   			rfidString : rfidString,
	   			produceTime : produceTime,
	   			recordId : recordId,
	   			destinationAddress : destinationAddress,
	   			weight : weight,
	   			transcarId : transcarId
	   		}),
	   		contentType : "application/json",
	   		dataType : "text",
	   		success : function(result) {
					alert("污泥记录添加成功");
					$('#addSludgeModal').modal('hide');
					location.reload(true);
				} 
	   });
	   });
	  });
	  
	  /*******************************按条件查询************************************* */
	  $("#queryButton").click(function() {
			var queryCondition = $("#queryCondition").val()
			var driverId = ${sessionScope.user.id}
			if (queryCondition == '' || queryCondition == null) {
				queryCondition = 'none'
			}
			$.ajax({
				type : "POST",
				url : "sludge/fussyQuerysludgebyTransDriver",
				data : {
						condition : queryCondition,
						driverId : driverId
					},
				success : function(sludges) {
				  var rowhead = '<table><tr>'+
					    '<th>任务编号</th>'+
					    '<th>污泥块编号</th>'+
					    '<th>污泥块生成时间</th>'+
					    '<th>污泥块产地</th>'+
					    '<th>运输目的地</th>'+
					    '<th>污泥块重量</th>'+
						'</tr>';
					var rows = "";
					$.each(sludges, function(i, sludge) {		
					   rows +='<tr>'+
					    '<td>'+sludge.recordId+'</td>'+
					    '<td>'+sludge.rfidString+'</td>'+
					    '<td>'+sludge.produceTime+'</td>'+
					    '<td>'+sludge.record.site.siteName+'</td>'+
					    '<td>'+sludge.destinationAddress+'</td>'+
					    '<td>'+sludge.weight+'</td>'+
						'</tr>';
					});
					 $("#customers").html(rowhead+rows+'<table>');
				}
			})
	
	
		})
	
	</script>
</body>

</html>
