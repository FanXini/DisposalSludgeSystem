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

<title>设备管理</title>

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

.col-sm-12 {
	top: auto;
}

.td {
	width: 400px;
}

.form-group {
	bottom: 5px;
}
</style>
</head>

<body>
	<!-- 模态框   信息删除确认 -->
	<div class="modal fade" id="delcfmOverhaul" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="delcfmOverhaul">删除</h4>
				</div>
				<div class="modal-body">
					确定删除本条记录？ <input id="sensorId" type="hidden" />
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">否</button>
					<button id="deleteButton" type="button" class="btn btn-primary">是</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
		>
	</div>

	<div class="modal inmodal" id="myModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content animated bounceInRight">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
					</button>
					<img alt="140x140" src="img/littercar.png" width="10%" height="10%" />
					<h4 class="modal-title">新增传感器</h4>
				</div>
				<div class="modal-body">
					<div class="container" style="width: 540px">
						<div class="form-group">
							<div>
								<label for="Groupname" class="col-sm-3 control-label">设备号：</label>
								<div class="col-sm-9">
									<input type="text" class="form-control m-b control-label"
										id="sensorSerialNumber" placeholder="请输入设备号">
								</div>
							</div>
						</div>
						<div class="form-group">
							<div>
								<label for="Groupname" class="col-sm-3 control-label">类型：</label>
								<div class="col-sm-9">
									<select id="sensorType_select" class="form-control m-b"
										name="account" onchange="hideGPSIDDIVInput()">
										<c:forEach items="${requestScope.sensorTypeList }"
											var="sensorType">
											<option>${sensorType.type}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="form-group" id="GPSIDDIV">
							<div>
								<label for="Groupname" class="col-sm-3 control-label">GPS 设备ID</label>
								<div class="col-sm-9">
									<input id="GPSID" class="form-control m-b"/>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div>
								<label for="Groupname" class="col-sm-3 control-label">位置：</label>
								<div class="col-sm-4">
									<select id="place_select" class="form-control m-b"
										name="account"
										onchange="set_city(this, document.getElementById('place'));">
										<option value="null">--请选择 --</option>
										<option value="site">工厂</option>
										<option value="slugeCar">车辆</option>
									</select>
								</div>

								<div class="col-sm-5">
									<select id="place" class="form-control m-b" name="account">
										<option value="null">--请选择--</option>
									</select>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-white" data-dismiss="modal">取消</button>
					<button id="addSensorButton" class="btn btn-primary">保存</button>
				</div>
			</div>
		</div>
	</div>
	<div class="search-content">
		<div class="col-sm-1">
			<div class="query-department text-center">
				<button type="button" class="btn btn-primary" data-toggle="modal"
					data-target="#myModal">+ 新增传感器</button>
			</div>
		</div>
		<div>
			<div class="col-sm-offset-1 col-sm-2 query-department">
				<!-- <form method="get" class="form-horizontal"> -->
				<div class="form-group">
					<div>
						<input type="text" class="form-control" placeholder="请输入设备号"
							id="query_serialNumber">
					</div>
				</div>
			</div>
			<div class="query-department">
				<div class="form-group">
					<div>
						<div class="col-sm-2">
							<select id="query_place_select" class="form-control m-b"
								name="account"
								onchange="set_city(this, document.getElementById('query_place'));">
								<option value="none">--请选择设备位置--</option>
								<option value="site">工厂</option>
								<option value="slugeCar">车辆</option>
							</select>
						</div>

						<div class="col-sm-2">
							<select id="query_place" class="form-control m-b" name="account">
								<option value="none">--请选择--</option>
							</select>
						</div>
					</div>
				</div>

			</div>
			<div class="query-department col-sm-2">
				<div class="form-group">
					<div>
						<select class="form-control m-b" name="account" id="query_type">
							<option value="-1">--请选择设备类型--</option>
							<c:forEach items="${requestScope.sensorTypeList }"
								var="sensorType">
								<option value="${sensorType.id}">${sensorType.type}</option>
							</c:forEach>

						</select>
					</div>
				</div>
			</div>
			<div class="query-department col-sm-1">
				<div class="form-group">
					<select class="form-control m-b" name="account" id="query_status">
						<option value="-1">状态</option>
						<option value="0">正常</option>
						<option value="1">异常</option>
					</select>
				</div>
			</div>
		</div>
		<div class="col-sm-1 query-department">
			<button id="queryButton" class="btn btn-primary" type="button">查询</button>
		</div>
	</div>

	</div>


	<div class="col-sm-12">
		<!-- Example Pagination -->
		<div class="example-wrap">
			<div class="ibox-content" id="tabelDiv"></div>
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


	<!-- Page-Level Scripts -->
	<script>
		/* 二级联动js */
		var carList = '${requestScope.carList}'
		var siteList = '${requestScope.siteList}'
		var carJson = eval("(" + carList + ")")
		var siteJson = eval("(" + siteList + ")")
		cities = new Object();
	
		cities['site'] = new Array();
	
		cities['slugeCar'] = new Array();
		for (var index in siteJson) {
	
			cities['site'][index] = siteJson[index].siteName
	
		}
	
		for (var index in carJson) {
	
			cities['slugeCar'][index] = carJson[index].license
	
		}
	
		var table_start = '<table id="table" class="table table-striped table-bordered table-hover dataTables-example">' +
			'<thead>' +
			'<tr>' +
			'<th>设备号</th>' +
			'<th>类型</th>' +
			'<th>位置</th>' +
			'<th>状态</th>' +
			'<th>操作</th>' +
			'</tr>' +
			'</thead>' +
			'<tbody>'
		var table_end = '</tbody>' +
			'<tfoot>' +
			'</tfoot>' +
			'</table>'
	
		function set_city(province, city) {
			var pv,
				cv;
	
			var i,
				ii;
	
			pv = province.value;
	
			cv = city.value;
	
			city.length = 1;
	
			if (pv == '0') return;
	
			if (typeof (cities[pv]) == 'undefined') return;
	
			for (i = 0; i < cities[pv].length; i++) {
	
				ii = i + 1;
	
				city.options[ii] = new Option();
	
				city.options[ii].text = cities[pv][i];
	
				city.options[ii].value = cities[pv][i];
	
			}
	
		}
			
		function hideGPSIDDIVInput(){
			var text=$("#sensorType_select option:selected").text()
			if(text=="GPS传感器"){
				$("#GPSIDDIV").show();
			}
			else{
				$("#GPSIDDIV").hide();
			}
			
		}
		/***************************** 查询所有传感器************************************* */
		$.ajax({
			type : "POST",
			url : "sensor/queryAllSensor",
			dataType : "json",
			contentType : "application/json",
			success : function(querySensorList) {
				$("#tabelDiv").empty()
				var table = table_start
				$.each(querySensorList, function(i, sensor) {
					table += '<tr class="gradeX" id="' + sensor.id + '">'
					table += '<td>' + sensor.serialNumber + '</td>'
					table += '<td>' + sensor.sensorType.type + '</td>'
					if (sensor.car.brand != null) {
						table += '<td>' + sensor.car.license + '</td>'
					} else if (sensor.site.siteName != null) {
						table += '<td>' + sensor.site.siteName + '</td>'
					} else {
						table += '<td></td>'
					}
					if (sensor.status == 0) {
						table += '<td class="project-status"><span class="label label-primary">正常</td>'
					} else if (sensor.status == 1) {
						table += '<td class="project-status"><span class="label label-danger">异常</td>'
					} else {
						table += '<td></td>'
					}
	
					table += '<td>' +
						'<button onclick="javascript:deleteSensor(' + sensor.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delcfmOverhaul"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
						'</td>'
					table += '</tr>'
				})
				table += table_end
				$('#tabelDiv').append(table)
				$('.dataTables-example').dataTable();
			}
		})
	
	
	
		/************************ 删除传感器************************************* */
		$("#deleteButton").click(function() {
			var sensorId = parseInt($("#sensorId").val())
			$.ajax({
				type : "POST",
				url : "sensor/deleteSensor",
				data : JSON.stringify({
					sensorId : sensorId,
				}),
				dataType : "json",
				contentType : "application/json",
				success : function(result) {
					/* document.getElementById("table").rows[tdIndex+1].style.display = "none" */
					if (result == "SUCCESS") {
						$("#" + sensorId.toString()).remove()
						$('#delcfmOverhaul').modal('hide')
					} else {
						alert("删除失败")
					}
				},
				error : function(data) {
					alert("删除失败")
				}
			})
		})
	
		/************************ 添加传感器************************************* */
		$("#addSensorButton").click(function() {
			var sensorSerialNumber = $("#sensorSerialNumber").val()
			var sensorType = $("#sensorType_select").val()
			var GPSID=$("#GPSID").val();
			var placeSelect = $("#place_select").val()
			var place = $("#place").val()
			var sensorInfo;
			if(sensorType=="GPS传感器"){
				sensorInfo=JSON.stringify({
					sensorSerialNumber : sensorSerialNumber,
					sensorType : sensorType,
					GPSID:GPSID,
					placeSelect : placeSelect,
					place : place
				})
			}
			else{
				sensorInfo=JSON.stringify({
					sensorSerialNumber : sensorSerialNumber,
					sensorType : sensorType,
					placeSelect : placeSelect,
					place : place
				})
			}
			if (sensorSerialNumber == "" || placeSelect == "null" || place == "null") {
				alert("设备信息不完善")
			} else if(!(/^[A-Z][0-9]{5}$/.test(sensorSerialNumber))){
				alert("请输入正确的设备号")
			} else {
				$.ajax({
					type : "POST",
					url : "sensor/addSensor",
					data : sensorInfo,
					dataType : "json",
					contentType : "application/json",
					success : function(data) {
						var result = data.result
						if (result == "SUCCESS") {
							alert("添加成功")
							var sensorId = parseInt(data.sensorId)
							/* var id=parseInt(Math.random()*10000+10000)
							alert(id) */
							var tr = '<tr class="gradeX" id="' + sensorId + '">'
							tr += '<td>' + sensorSerialNumber + '</td>'
							tr += '<td>' + sensorType + '</td>'
							tr += '<td>' + place + '</td>'
	
							tr += '<td class="project-status"><span class="label label-primary">正常</td>'
	
							tr += '<td>' +
								'<button onclick="javascript:deleteSensor(' + sensorId + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delcfmOverhaul"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'</td>'
							tr += '</tr>'
							$("tbody").append(tr)
							$('#myModal').modal('hide')
						} else if (result == "DUPLICATE") {
							alert("设备号冲突")
						} else if (result == "INPUT") {
							alert("请检查输入数据")
						} else {
							alert("添加失败")
						}
					},
					error:function(data){
						alert("添加失败")
					}
				})
			}
	
		})
	
		/*******************************按条件查询************************************* */
		$("#queryButton").click(function() {
			var sensorSerialNumber = $("#query_serialNumber").val()
			var sensorTypeId = $("#query_type").val()
			var placeSelect = $("#query_place_select").val()
			var status = $("#query_status").val()
			var place = $("#query_place").val()
//			alert("ssn:"+sensorSerialNumber + ",  " + sensorTypeId + ",  " + status + ",  " + placeSelect + ", " + place)
			if (sensorSerialNumber == '' && sensorTypeId == '-1' && status == '-1' && placeSelect == 'none' && place == 'none')
			{
				/***************************** 查询所有传感器************************************* */
				$.ajax({
					type : "POST",
					url : "sensor/queryAllSensor",
					dataType : "json",
					contentType : "application/json",
					success : function(querySensorList) {
						$("#tabelDiv").empty()
						var table = table_start
						$.each(querySensorList, function(i, sensor) {
							table += '<tr class="gradeX" id="' + sensor.id + '">'
							table += '<td>' + sensor.serialNumber + '</td>'
							table += '<td>' + sensor.sensorType.type + '</td>'
							if (sensor.car.brand != null) {
								table += '<td>' + sensor.car.license + '</td>'
							} else if (sensor.site.siteName != null) {
								table += '<td>' + sensor.site.siteName + '</td>'
							} else {
								table += '<td></td>'
							}
							if (sensor.status == 0) {
								table += '<td class="project-status"><span class="label label-primary">正常</td>'
							} else if (sensor.status == 1) {
								table += '<td class="project-status"><span class="label label-danger">异常</td>'
							} else {
								table += '<td></td>'
							}

							table += '<td>' +
									'<button onclick="javascript:deleteSensor(' + sensor.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delcfmOverhaul"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
									'</td>'
							table += '</tr>'
						})
						table += table_end
						$('#tabelDiv').append(table)
						$('.dataTables-example').dataTable();
					}
				})

			} else {
				if (sensorSerialNumber == '') {
					sensorSerialNumber = 'none'
				}
				$.ajax({
					type : "POST",
					url : "sensor/conditionalQuery",
					data : JSON.stringify({
						sensorSerialNumber : sensorSerialNumber,
						sensorTypeId : sensorTypeId,
						placeSelect : placeSelect,
						place : place,
						status : status
					}),
					dataType : "json",
					contentType : "application/json",
					success : function(querySensorList) {
						$("#tabelDiv").empty()
						var table = table_start
						$.each(querySensorList, function(i, sensor) {
							table += '<tr class="gradeX" id="' + sensor.id + '">'
							table += '<td>' + sensor.serialNumber + '</td>'
							table += '<td>' + sensor.sensorType.type + '</td>'
							if (sensor.car.brand != null) {
								table += '<td>' + sensor.car.license + '</td>'
							} else if (sensor.site.siteName != null) {
								table += '<td>' + sensor.site.siteName + '</td>'
							} else {
								table += '<td></td>'
							}
							if (sensor.status == 0) {
								table += '<td class="project-status"><span class="label label-primary">正常</td>'
							} else if (sensor.status == 1) {
								table += '<td class="project-status"><span class="label label-danger">异常</td>'
							} else {
								table += '<td></td>'
							}
	
							table += '<td>' +
								'<button onclick="javascript:deleteSensor(' + sensor.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delcfmOverhaul"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'</td>'
							table += '</tr>'
						})
						table += table_end
						$('#tabelDiv').append(table)
						$('.dataTables-example').dataTable();
					}
				})
			}
	
		})
	
		function deleteSensor(sensorId) {
			$("#sensorId").val(sensorId)
		}
	</script>
</body>

</html>
