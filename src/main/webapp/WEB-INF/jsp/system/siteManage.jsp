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
	float:left;
	margin:10px auto 30px 35px;
    
}
.query-site-btn {
	padding: 1 1;
	float:right;
	margin:10px 35px 30px auto;
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
	<div class="modal fade" id="delModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">
						删除<input id="delId" type="hidden" />
					</h4>
			</div>
				<div class="modal-body" id="delModalContent"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">否</button>
					<button id="delSubmit" type="button" class="btn btn-primary">是</button>
			</div>
		</div> <!-- /.modal-content --></div> <!-- /.modal -->
	</div>

	<!-- 模态框   增加站点 -->
	<div class="modal inmodal" id="addModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
		
		<div class="modal-content animated bounceInRight">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
					</button> <img alt="140x140" src="img/littercar.png" width="10%" height="10%" />
					<h4 class="modal-title">新增站点</h4>
			</div>
				<div class="modal-body">
					<div class="container" style="width: 540px;">
					
						<form class="form-inline" id="addForm">
						<div class="col-sm-6" style="margin: 0 auto; width:500px;">
							<div class="form-group" style="width:450px; margin: 5px auto; display:block">
								<label for="addSerialNumber">编&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</label> 
								<input type="text" style="width:375px" placeholder="请输入F开头的站点编号" id="addSerialNumber" class="form-control" autocomplete="off"  name="serialNumber">
							</div>
							<div class="form-group" style="width:450px; margin: 5px auto; display:block">
								<label for="addSiteName">站&nbsp;&nbsp;点&nbsp;&nbsp;名：</label> 
								<input type="text" style="width:375px" placeholder="请输入站点名" id="addSiteName" class="form-control" autocomplete="off" name="siteName">
							</div>
							<div id="distpickerAdd" style="width:450px; margin: 5px auto; display:block">
								<div style="float:left"><label>省&nbsp;&nbsp;市&nbsp;&nbsp;区：</label> </div>
								<div class="form-group" style="width:125px;float:left;">
									<select id="addProvince" class="form-control" data-province="广东省" style="width:125px"></select>
								</div>
								<div class="form-group" style="width:125px; float:left">
									<select id="addCity" class="form-control" data-city="深圳市" style="width:125px"></select>
								</div>
								<div class="form-group" style="width:125px;bfloat:left"> 
									<select id="addRegion" class="form-control" style="width:125px;"></select>
								</div>
							</div>
							<div class="form-group" style="width:450px; margin: 5px auto; display:block">
								<label for="addAddress">详细地址：</label> 
								<textarea placeholder="请输入详细地址" style="vertical-align: top; height:50px;width:375px" rows="2" id="addAddress" class="form-control m-b control-label" autocomplete="off" name="address"></textarea>
							</div>
							</div>
							<!-- <div class="col-sm-6">
							<div class="form-group"><label for="addManager">负责人：</label> <input type="text"
								placeholder="请输入负责人" id="addManager" class="form-control m-b control-label" name="manager" autocomplete="off" list="addManagerList"/>
								<datalist id="addManagerList">
								</datalist>
							</div> 
							<div class="form-group"><label for="addManagerTel">负责人电话：</label> <input type="text"
								placeholder="请输入负责人电话" id="addManagerTel" class="form-control m-b control-label" autocomplete="off" name="managerTel">
							</div> 
							<div class="form-group"><label for="addTel">电话：</label> <input type="text"
								placeholder="请输入站点电话" id="addTel" class="form-control m-b control-label" autocomplete="off" name="tel">
							</div>
							
							<div class="form-group"><label for="addAddress">详细地址：</label> <input type="text"
								placeholder="请输入详细地址" id="addAddress" class="form-control m-b control-label" autocomplete="off" name="address">
							</div>
							<!-- 
							</div>-->
								
						</form>
				</div>
			</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-white" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="addSite">保存</button>
			</div>
		</div>
	</div>
	</div>

	<!-- 模态框   编辑站点 -->
	<div class="modal inmodal" id="editModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content animated bounceInRight">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
					</button> <img alt="140x140" src="img/littercar.png" width="10%" height="10%" />
					<h4 class="modal-title">编辑站点<input id="editId" type="hidden" /></h4>
			</div>
				<div class="modal-body">
					<div class="container" style="width: 540px">
						<form class="form-inline" id="editForm">
							<div class="form-group" style="width:250px; margin: 5px auto; display:block; float:left">
								<label for="editSerialNumber">编&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</label> 
								<input type="text" id="editSerialNumber" style="width:180px" class="form-control" disabled="true">
							</div>
							<div class="form-group" style="width:250px; margin: 5px auto; display:block; float:left"> 
								<label for="editSiteName">站&nbsp;&nbsp;点&nbsp;名：</label> 
								<input type="text" style="width:180px" placeholder="请输入站点名" id="editSiteName" class="form-control" autocomplete="off" name="siteName">
							</div>							
							
							<!-- <div id="distpickerEdit">
								<div class="form-group"><label for="editProvince">省：</label> <select id="editProvince"
									class="form-control"></select>
							</div>
								<div class="form-group"><label for="editCity">市：</label> <select id="editCity"
									class="form-control"></select>
							</div>
								<div class="form-group"><label for="editRegion">区：</label> <select id="editRegion"
									class="form-control"></select>
							</div>
							</div> -->
							<!--<div class="form-group"><label for="editAddress">详细地址：</label>
							<input type="text" placeholder="请输入详细地址" id="editAddress" class="form-control m-b control-label" autocomplete="off" name="address">
							</div>  -->
							<div class="form-group" style="width:250px; margin: 5px auto; display:block; float:left">
								<label for="editManager">负&nbsp;&nbsp;责&nbsp;人：</label>
								<select class="form-control m-b" id="editManager" style="width:175px" name="manager"></select>
							</div>
							<div class="form-group" style="display:none">
								<label for="editManagerTel">负责人电话：</label> 
								<input type="hidden" id="editManagerTel" class="form-control" disabled="true">
							</div>
							<div class="form-group" style="width:250px; margin: 5px auto; display:block; float:left">
								<label for="editTel">电&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;话：</label> 
								<input type="text" style="width:180px" placeholder="请输入站点电话" id="editTel" class="form-control m-b control-label" autocomplete="off" name="tel">
							</div>
							<div class="form-group">
								<label for="editAddress">详细地址：</label> 
								<textarea style="vertical-align: top; height:50px;width:430px" rows="2" placeholder="请输入详细地址" id="editAddress" class="form-control m-b control-label" autocomplete="off" name="address"></textarea>
							</div>
							<!-- <div class="form-group" style="width:80%;"><label for="addSensor">传感器：</label> <select
								id="addSensor" data-placeholder="选择传感器" class="chosen-select" style="width:80%;" multiple
								tabindex="4">
									<option value="">请选择传感器</option>
									<option value="110000" hassubinfo="true">G12</option>
									<option value="120000" hassubinfo="true">G23</option>
									<option value="130000" hassubinfo="true">G222</option>
									<option value="140000" hassubinfo="true">G0120</option>
							</select>
							</div> -->
						</form>
				</div>
			</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-white" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="editSite">保存</button>
			</div>
		</div>
	</div> <!-- /.modal -->
	</div>

	<!-- 搜索栏 -->
	<div class="search-content">
		<div class="add-site-btn">
			<button type="button" class="btn btn-primary" data-toggle="modal"
				data-target="#addModal">+ 新增站点</button>
		</div>
		<div class="query-site-btn">
			<div class="form-inline">
				<div><input type="text" class="form-control" placeholder="请输入编号/厂名/地址/电话" id="queryInput">
					<button id="querySubmit" class="btn btn-primary" type="button">查询</button>
			</div>
		</div>
	</div>
	</div>

	<!-- 站点列表 -->
	<div class="col-sm-12">
		<!-- Example Pagination -->
		<div class="example-wrap">
			<div id="tabelDiv" class="ibox-content">
				<%-- <table class="table table-striped table-bordered table-hover dataTables-example" id="siteTable">
					<thead>
						<tr>
							<th data-field="id">编号</th>
							<th data-field="siteName">厂名</th>
							<th data-field="address">地址</th>
							<th data-field="tel">电话</th>
							<th data-field="manager">负责人</th>
							<th data-field="device">设备</th>
							<th data-field="sensors">操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${requestScope.siteList }" var="site">
							<tr>
								<td>${site.serialNumber}</td>
								<td>${site.siteName}</td>
								<td>${site.address}</td>
								<td>${site.telephone}</td>
								<td>${site.manage.username}</td>
								<td><c:forEach items="${site.sensors}" var="sensor">
										${sensor.serialNumber}&nbsp;
									</c:forEach></td>
								<td>
									<div>
										<button onclick="" class="btn btn-white btn-sm" data-toggle="modal"
											data-target="#editModel">
											<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
										</button>
										<button
											onclick="javascript:deleteSite('${site.id}','${site.serialNumber}','${site.siteName}');"
											class="btn btn-white btn-sm" data-toggle="modal"
											data-target="#delModal">
											<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
										</button>
								</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table> --%>
		</div>
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
	<script src="js/system/form-validate-siteManage.js"></script> 
	<!-- distpicker --> 
	<script src="js/distpicker/distpicker.data.js"></script> 
	<script src="js/distpicker/distpicker.js"></script>
	<script src="js/distpicker/main.js"></script> 
	<!-- Chosen --> 
	<script src="js/plugins/chosen/chosen.jquery.js"></script> 
	
	<!-- baidu map -->
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=5TmZTw10oplDe4ZehEM6UjnY6rDgocd8"></script>
	<!-- Page-Level Scripts --> 
	<script>
		
	$("#distpickerAdd").distpicker();
	$("#distpickerEdit").distpicker();
	var addValidate;
	var editValidate;

	var table_start = '<table id="siteTable" class="table table-striped table-bordered table-hover dataTables-example">'
			+ '<thead>'
			+ '<tr>'
			+ '<th data-field="id">编号</th>'
			+ '<th data-field="siteName">厂名</th>'
			+ '<th data-field="address">地址</th>'
			+ '<th data-field="tel">电话</th>'
			+ '<th data-field="manager">负责人</th>'
/* 			+ '<th data-field="device">设备</th>' */
			+ '<th data-field="status">状态</th>'
			+ '<th data-field="sensors">操作</th>'
			+ '</tr>'
			+ '</thead>'
			+ '<tbody>'
	var table_end = '</tbody>' + '<tfoot>' + '</tfoot>' + '</table>';
	showTable();

	/***************************** 查询所有站点************************************* */
	function showTable(){
	$.ajax({
			type : "POST",
			url : "system/queryAllSite",
			dataType : "json",
			contentType : "application/json",
			success : function(siteList) {
				$("#tabelDiv").empty();
				var table = table_start;
				$.each(siteList,function(i, site) {
					table += '<tr class="gradeX" id="' + site.id + '">';
					table += '<td>' + site.serialNumber + '</td>';
					table += '<td>' + site.siteName + '</td>';
					table += '<td>' + site.address	+ '</td>';
					table += '<td>' + site.telephone + '</td>';
					if(!jQuery.isEmptyObject(site.manage)){
						table += '<td style="width:8%;">' + site.manage.realname + '</td>';
					}
					else{
						table += '<td style="width:8%;">未设置</td>';
					}
					/* table += '<td>';
					if (!jQuery.isEmptyObject(site.sensors)) {
						var sensorNumber = site.sensors.length;
						$.each(site.sensors,function(i,sensor) {
							if (!jQuery.isEmptyObject(sensor)) {
								table += '<a href="sensor/deviceDetail?id='+site.id+'&location='+site.siteName+'&locationId=1'+'">'+sensor.serialNumber+'</a>';
							}
							if (i < sensorNumber - 1)
								table += ",";
							});
					}
					table += '</td>'; */
					if (site.status == 0) {
						table += '<td class="project-status"><span class="label label-inverse">正常</td>';
					} else if (site.status == 1) {
						table += '<td class="project-status"><span class="label label-primary">处理中</td>';
					} else if (site.status == 2) {
						table += '<td class="project-status"><span class="label label-danger">待处理</td>';
					} else {			
						table += '<td></td>';
					}
					table += '<td style="width:15%;"><div><button onclick="editSite(' + site.id + ')" class="btn btn-white btn-sm" data-toggle="modal" data-target="#editModal">';
					table += '<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button>';
					table += '<button onclick="deleteSite(' + site.id + ',\'' + site.serialNumber + '\',\''
							+ site.siteName + '\');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delModal">';
					table += '<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>';
					table += '</div></td></tr>';
				});

				table += table_end
				$('#tabelDiv').append(table)
				$('.dataTables-example').dataTable();
			}
	});
	}	
	
	/***************************** 模糊查询************************************* */
	$("#querySubmit").click(function(){
		var data = $("#queryInput").val();
		data = $.trim(data);
		$.ajax({
			type : "POST",
			url : "system/fuzzyQuerySite",
			data : "queryStr=" + data,
			success : function(siteList) {
				$("#tabelDiv").empty();
				var table = table_start;
				$.each(siteList,function(i, site) {
					table += '<tr class="gradeX" id="' + site.id + '">';
					table += '<td>' + site.serialNumber + '</td>';
					table += '<td>' + site.siteName + '</td>';
					table += '<td>' + site.address + '</td>';
					table += '<td>' + site.telephone + '</td>';
					if(!jQuery.isEmptyObject(site.manage)){
						table += '<td style="width:8%;">' + site.manage.realname + '</td>';
					}
					else{
						table += '<td style="width:8%;">未设置</td>';
					}
					table += '<td>';
					if (!jQuery.isEmptyObject(site.sensors)) {
						var sensorNumber = site.sensors.length;
						$.each(site.sensors,function(i,sensor) {
							if (!jQuery.isEmptyObject(sensor)) {
								table += '<a href="sensor/deviceDetail?id='+site.id+'&location='+site.siteName+'&locationId=1'+'">'+sensor.serialNumber+'</a>';
							}
							if (i < sensorNumber - 1)
								table += ",";
						});
					}
					table += '</td>';
					if (site.status == 0) {
						table += '<td class="project-status"><span class="label label-inverse">正常</td>';
					} 
					else if (site.status == 1) {
						table += '<td class="project-status"><span class="label label-primary">处理中</td>';
					} else if (site.status == 2) {
						table += '<td class="project-status"><span class="label label-danger">待处理</td>';
					} else {
						table += '<td></td>';
					}
					table += '<td style="width:15%;"><div><button onclick="editSite(' + site.id + ')" class="btn btn-white btn-sm" data-toggle="modal" data-target="#editModal">';
					table += '<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button>';
					table += '<button onclick="deleteSite(' + site.id + ',\'' + site.serialNumber + '\',\''
						+ site.siteName + '\');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delModal">';
					table += '<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>';
					table += '</div></td></tr>';
				});
				table += table_end
				$('#tabelDiv').append(table)
				$('.dataTables-example').dataTable();
			}
		});
	});

	$("#addModal").on('shown.bs.modal', function(){
		$("#addSerialNumber").val("");
		$("#addSiteName").val("");
		$("#addTel").val("");
		$("#addDepth").val("");
		$("#addAddress").val("");
	});
	//表单校验
	addValidate=validateAddForm();
	/***************************** 新增站点提交************************************* */
	$("#addSite").click(function(){
		var addSerialNum=$("#addSerialNumber").val();
		var addSiteName=$("#addSiteName").val();
		if(addValidate.form()){
			$.ajax({
    				type : "POST",
    				url : "system/querySiteSerialNumberAndName",
    				data : "serialNumber=" + addSerialNum+"&siteName="+addSiteName,
    				success : function(result) {
    					if (result.result == "1") 
    						alert("编号或站点已存在，请重新输入");
    					else {
							var serialNumber=$("#addSerialNumber").val();
							var siteName=$("#addSiteName").val();
							var telephone=$("#addTel").val();
							var depth=$("#addDepth").val();
							var address=$("#addProvince").val()+$("#addCity").val()+$("#addRegion").val()+$("#addAddress").val();
							//百度地图创建地址解析器
							var myGeo = new BMap.Geocoder();
							//解析地址为经纬度
							myGeo.getPoint(address,function(point){
								if(point){
									//alert(point.lng+","+point.lat);
									$.ajax({
										type : "POST",
										url : "system/addSite",
										data : JSON.stringify({
											serialNumber : serialNumber,
											siteName : siteName,
											address : address,
											telephone : telephone,
											depth : depth,
											longitude : point.lng,
											latitude : point.lat,
										}),
										dataType : "json",
										contentType : "application/json",
										success : function(result) {
											if (result.result == "success") {
												alert("添加成功");
												//alert(result.siteId);
												$('#addModal').modal('hide');
												showTable();
											} else {
												alert("添加失败");
											}
										}
									});
								}
								else{
									alert("找不到该地址");
								}
							},"深圳市");
						}
					}
    			});
    		}
	});
	/***************************** 编辑按钮************************************* */
	var currentOption;
	function editSite(siteId) {
		$("#editManager").empty();
		$.ajax({
			type : "POST",
			url : "system/queryAllManagerBySite",
			data : "siteId="+siteId,
			success : function(editManagerList) {
				$("#editManagerList").empty();
				if (!jQuery.isEmptyObject(editManagerList)){
					$.each(editManagerList,function(i,manager) {
						$("#editManager").append('<option value="'+manager.id+'">'+manager.realname+'</option>');
					});
				}else{
					$("#editManager").append('<option value="0">--暂无成员可设置--</option>');
					$("#editManager").val(0);
				}
			}
		});
		$("#editId").val(siteId);
		$.ajax({
			type : "POST",
			url : "system/querySiteManagerById",
			data : "siteId=" + siteId,
			success : function(site){
				//alert(site.siteName);
				$("#editSerialNumber").val(site.serialNumber);
				$("#editSiteName").val(site.siteName);
				$("#editAddress").val(site.address);
				if(!jQuery.isEmptyObject(site.manage)){
					$("#editManager").val(site.manage.id);
					$("#editManagerTel").val(site.manage.telephone);
				}
				else{
					if($("#editManager").val()!=0)
					$("#select_id").prepend("<option value='0'>--请选择--</option>");
					$("#editManagerTel").val('');
				}
				$("#editTel").val(site.telephone);
				$("#editDepth").val(site.depth);
			}
		});
		//表单校验
		editValidate=validateEditForm();
	}
	
	//编辑模态框联动
	$("#editManager").change(function(){
		var managerId = $("#editManager").val();
		if(managerId != 0){
			$.ajax({
				type : "POST",
				url : "system/queryManagerTel",
				data : "manager=" + manager,
				success : function(result) {
					if (result.result == "success") {
						$("#editManagerTel").val(result.managerTel);
					}else{
						$("#editManagerTel").val('');
					}
				}
			});
		}else{
			$("#editManagerTel").val('');
		}
	});
	
	/***************************** 编辑站点提交************************************* */
	$("#editSite").click(function(){
		if(editValidate.form()){
		var id=$("#editId").val();
		var serialNumber=$("#editSerialNumber").val();
		var siteName=$("#editSiteName").val();
		var manager=$("#editManager").val();
		var telephone=$("#editTel").val();
		var depth=$("#editDepth").val();
		var address=$("#editAddress").val();
		//百度地图创建地址解析器
		var myGeo = new BMap.Geocoder();
		//解析地址为经纬度
		myGeo.getPoint(address,function(point){
			if(point){
				//alert(point.lng+","+point.lat);
				$.ajax({
					type : "POST",
					url : "system/editSite",
					data : JSON.stringify({
						id : id,
						serialNumber : serialNumber,
						siteName : siteName,
						address : address,
						managerId : managerId,
						telephone : telephone,
						depth : depth,
						longitude : point.lng,
						latitude : point.lat,
					}),
					dataType : "json",
					contentType : "application/json",
					success : function(result) {
						if (result.result == "success") {
							alert("更改成功");
							$("tr[id="+id+"]").children("td").eq(1).text(siteName);
							$("tr[id="+id+"]").children("td").eq(2).text(address);
							$("tr[id="+id+"]").children("td").eq(3).text(telephone);
							$("tr[id="+id+"]").children("td").eq(4).text(manager);
							$('#editModal').modal('hide');
						} else {
							alert("更改失败");
						}
					}
				});
			}
			else{
				alert("找不到该地址");
			}
		},"长沙市");
		}
	});

	/***************************** 删除按钮************************************* */
	function deleteSite(siteId, serialNumber, siteName) {
		var delContent = "确定删除站点：" + serialNumber + siteName + "?";
		$("#delModalContent").html(delContent);
		$("#delId").val(siteId);
	}
	/***************************** 删除站点************************************* */
	$("#delSubmit").click(function() {
		var siteId = $("#delId").val();
		$.ajax({
			type : "POST",
			url : "system/deleteSite",
			data : "siteId=" + siteId,
			success : function() {
				$('#delModal').modal('hide');
				window.location.href = "system/jumpToSite";
			}
		});
	});
	
</script>
	
</body>

</html>
