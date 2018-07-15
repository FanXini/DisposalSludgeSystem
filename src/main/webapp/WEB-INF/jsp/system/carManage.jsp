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

<title>车队管理</title>

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

.col-sm-12 {
	top: auto;
}

.form-group {
	bottom: 5px;
}
</style>
</head>

<body onload="javascript:queryAllCar()">
	<!-- 模态框   信息删除确认 -->
	<div class="modal fade" id="delcfmOverhaul" tabindex="-1" role="dialog"
		aria-labelledby="editCarModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="delcfmOverhaul">删除</h4>
				</div>
				<div class="modal-body">
					确定删除本条记录？ <input id="carId" type="hidden" />
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">否</button>
					<button id="deleteButton" type="button" class="btn btn-primary">是</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	<!-- 修改车辆信息模态框 -->
	<div class="modal inmodal" id="editCarModal" tabindex="-1"
		role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content animated bounceInRight">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
					</button>
					<img alt="140x140" src="img/littercar.png" width="10%" height="10%" />
					<h4 class="modal-title">车辆信息</h4>
				</div>
				<div class="modal-body">
					<div class="container" style="width: 540px">
						<div class="form-group">
							<div>
								<label for="Groupname" class="col-sm-3 control-label">车牌号：</label>
								<input type="hidden" id="editCarId">
								<div class="col-sm-9">
									<input type="text" class="form-control m-b control-label"
										id="editCarLicense" placeholder="请输入车牌号">
								</div>
							</div>
						</div>
						<div class="form-group">
							<div>
								<label for="Groupname" class="col-sm-3 control-label">品牌：</label>
								<div class="col-sm-9">
									<input type="text" class="form-control m-b" id="editCarBrand"
										placeholder="请输入车子品牌">
								</div>
							</div>
						</div>
						<div class="form-group">
							<div>
								<label for="Groupname" class="col-sm-3 control-label">司机：</label>
								<div class="col-sm-9">
									<select class="form-control m-b" name="account"
										id="editDriverId">
										<%-- <c:forEach items="${requestScope.NoCarAssignedDriverList }"
											var="driver">
											<option name="${driver.telephone }" id="Car${driver.id}"
												value="${driver.id }">${driver.realname }</option>
										</c:forEach> --%>
									</select>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-white" data-dismiss="modal">取消</button>
					<button id="saveEditButton" type="button" class="btn btn-primary">保存</button>
				</div>
			</div>
		</div>
	</div>

	<!-- ***********************************新增车辆模态框************************************* -->
	<div class="modal inmodal" id="addCarModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content animated bounceInRight">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
					</button>
					<img alt="140x140" src="img/littercar.png" width="10%" height="10%" />
					<h4 class="modal-title">新增车辆</h4>
				</div>
				<div class="modal-body">
					<div class="container" style="width: 540px">
						<div class="form-group">
							<div>
								<label for="Groupname" class="col-sm-3 control-label">车牌号：</label>
								<div class="col-sm-9">
									<input type="text" class="form-control m-b control-label"
										id="addCarLicense" placeholder="请输入车牌号">
								</div>
							</div>
						</div>
						<div class="form-group">
							<div>
								<label for="Groupname" class="col-sm-3 control-label">品牌：</label>
								<div class="col-sm-9">
									<input type="text" class="form-control m-b" id="addCarBrand"
										placeholder="请输入车子品牌(型号)">
								</div>
							</div>
						</div>
						<div class="form-group">
							<div>
								<label for="Groupname" class="col-sm-3 control-label">司机：</label>
								<div class="col-sm-9">
									<select class="form-control m-b" name="account"
										id="addDriverId">
										<%-- <option value="0">--请选择--</option>
										<c:forEach items="${requestScope.NoCarAssignedDriverList }"
											var="driver">
											<option name="${driver.telephone }" id="noCar${driver.id}"
												value="${driver.id }">${driver.realname }</option>
										</c:forEach> --%>
									</select>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="reset" class="btn btn-white" data-dismiss="modal">重置</button>
					<button id="addCarButton" type="button" class="btn btn-primary">保存</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ********************************************查询框****************************************** -->

	<div class="search-left">
		<div class="col-xs-1 query-department text-center">
			<button type="button" class="btn btn-primary" data-toggle="modal"
				data-target="#addCarModal">+ 新增车辆</button>
		</div>
	</div>

	<div class="row" style="margin-top: 2%">
		<div class="search-right">
			<div class="col-xs-offset-5 col-xs-4 query-department">
				<form method="get" class="form-horizontal">
					<div class="form-group">
						<div>
							<input id="queryCondition" type="text" class="form-control"
								placeholder="请输入车牌号/车型/司机/司机号码,不输入则查询所有车辆">
						</div>
					</div>
			</div>
			<div class="col-xs-1 query-department">
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
	
		var table_start = '<table id="table" class="table table-striped table-bordered table-hover dataTables-example">' +
			'<thead>' +
			'<tr>' +
			'<th>车牌号</th>' +
			'<th>车型</th>' +
			'<th>司机</th>' +
			'<th>司机号码</th>' +
			'<th>设备</th>' +
			'<th>状态</th>' +
			'<th>操作</th>' +
			'</tr>' +
			'</thead>' +
			'<tbody>'
		var table_end = '</tbody>' +
			'<tfoot>' +
			'</tfoot>' +
			'</table>'
		$("#editCarModal").on('shown.bs.modal', function() {
			$.ajax({
				type : "POST",
				url : "user/queryNoCarAssignedDriverList",
				success : function(driverList) {
					$("#editDriverId").empty();
					var option1 = new Option('--暂不分配--', '0')
					$("#editDriverId")[0].options.add(option1);
					$.each(driverList, function(i, driver) {
						var option = new Option(driver.realname, driver.id);
						option.setAttribute("name", driver.telephone);
						/* $("#editDriverId").append('<option name="'+driver.telephone+'" value="'+driver.id+'">''</option>') */
						$("#editDriverId")[0].options.add(option)
					});
				}
			});
		})
	
		$("#addCarModal").on('shown.bs.modal', function() {
			$.ajax({
				type : "POST",
				url : "user/queryNoCarAssignedDriverList",
				success : function(driverList) {
					$("#addDriverId").empty();
					if (driverList.length == 0) {
						var option1 = new Option('--暂无可用司机--', '0')
						$("#addDriverId")[0].options.add(option1);
					} else {
						var option1 = new Option('--暂不分配--', '0')
						$("#addDriverId")[0].options.add(option1);
						$.each(driverList, function(i, driver) {
							var option = new Option(driver.realname, driver.id);
							option.setAttribute("name", driver.telephone);
							/* $("#editDriverId").append('<option name="'+driver.telephone+'" value="'+driver.id+'">''</option>') */
							$("#addDriverId")[0].options.add(option)
						});
	
					}
				}
			});
		})
	
	
		/***************************** 查询所有污泥车************************************* */
		function queryAllCar() {
			$.ajax({
				type : "POST",
				url : "car/queryAllCar",
				success : function(carList) {
					$("#tabelDiv").empty()
					var table = table_start
					$.each(carList, function(i, car) {
						table += '<tr class="gradeX" id="' + car.id + '">'
						table += '<td>' + car.license + '</td>'
						if (car.brand == null) {
							car.brand = ''
						}
						table += '<td>' + car.brand + '</td>'
						if (car.driver.realname != null) {
							table += '<td>' + car.driver.realname + '</td>'
							if (car.driver.telephone != null) {
								table += '<td>' + car.driver.telephone + '</td>'
							} else {
								table += '<td></td>'
							}
						} else {
							table += '<td></td>'
							table += '<td></td>'
						}
	
						table += '<td><a href="sensor/deviceDetail?id=' + car.id + '&location=' + car.license + '&locationId=0' + '">设备</a></td>'
						if (car.status == 0) {
							table += '<td class="project-status"><span class="label label-inverse">空闲</td>'
							table += '<td>' +
								'<button onclick="javascript:deleteCar(' + car.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delcfmOverhaul"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'<button onclick="javascript:editCar(' + car.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#editCarModal"><i class="fa fa-pencil"></i> 编辑 </button>' +
								'</td>'
						} else if (car.status == 1) {
							table += '<td class="project-status"><span class="label label-primary">在途中</td>'
							table += '<td>' +
								'<button onclick="javascript:deleteCar(' + car.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delcfmOverhaul"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'<button class="btn btn-white btn-sm"  disabled="disabled"><i class="fa fa-pencil"></i> 编辑 </button>' +
								'</td>'
						} else if (car.status == 2) {
							table += '<td class="project-status"><span class="label label-success">已到达</td>'
							table += '<td>' +
								'<button onclick="javascript:deleteCar(' + car.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delcfmOverhaul"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'<button class="btn btn-white btn-sm"  disabled="disabled"><i class="fa fa-pencil"></i> 编辑 </button>' +
								'</td>'
						} else if (car.status == 3) {
							table += '<td class="project-status"><span class="label label-danger">已派单</td>'
							table += '<td>' +
								'<button onclick="javascript:deleteCar(' + car.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delcfmOverhaul"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'<button onclick="javascript:editCar(' + car.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#editCarModal"><i class="fa fa-pencil"></i> 编辑 </button>' +
								'</td>'
	
						} else if (car.status == 4) {
							table += '<td class="project-status"><span class="label label-info">返程中</td>'
							table += '<td>' +
								'<button onclick="javascript:deleteCar(' + car.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delcfmOverhaul"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'<button onclick="javascript:editCar(' + car.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#editCarModal"><i class="fa fa-pencil"></i> 编辑 </button>' +
								'</td>'
						} else {
							table += '<td></td>'
							table += '<td>' +
								'<button onclick="javascript:deleteCar(' + car.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delcfmOverhaul"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'<button onclick="javascript:editCar(' + car.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#editCarModal"><i class="fa fa-pencil"></i> 编辑 </button>' +
								'</td>'
						}
						table += '</tr>'
					})
					table += table_end
					$('#tabelDiv').append(table)
					$('.dataTables-example').dataTable();
				}
			})
	
		}
	
	
	
		/************************ 删除汽车************************************* */
		$("#deleteButton").click(function() {
			var carId = parseInt($("#carId").val())
			$.ajax({
				type : "POST",
				url : "car/deleteCar?carId=" + carId,
				success : function(result) {
					if (result == "SUCCESS") {
						/* document.getElementById("table").rows[tdIndex+1].style.display = "none" */
						$("#" + carId.toString()).remove()
						$('#delcfmOverhaul').modal('hide')
					} else if (result == "ERROR") {
						alert("删除失败")
					}
				},
				error : function(data) {
					alert("删除失败")
				}
			})
		})
	
		/************************ 添加污泥车************************************* */
		$("#addCarButton").click(function() {
			var license = $("#addCarLicense").val()
			var brand = $("#addCarBrand").val()
			var Brand = brand
			var driverId = parseInt($("#addDriverId").val())
			var options = $("#addDriverId option:selected");
			var driverName = options.text();
			var telephone = options.attr("name");
			if (telephone == null) {
				telephone = ''
			}
			if (driverName == "--暂不分配--"||driverName=='--暂无可用司机--') {
				driverName = ''
			}
			if (license == '' || license == null) {
				alert("设备信息不完善")
			} else {
				if (brand == '' || brand == null) {
					brand = 'none'
				}
				$.ajax({
					type : "POST",
					url : "car/addCar",
					data : JSON.stringify({
						license : license,
						brand : brand,
						driverId : driverId
					}),
					dataType : "json",
					contentType : "application/json",
					success : function(data) {
						var result = data.result
						if (result == "SUCCESS") {
							alert("添加成功")
							var carId = parseInt(data.carId)
							var tr = '<tr class="gradeX" id="' + carId + '">'
							tr += '<td>' + license + '</td>'
							tr += '<td>' + Brand + '</td>'
							tr += '<td>' + driverName + '</td>'
							tr += '<td>' + telephone + '</td>'
							tr += '<td><a href="sensor/deviceDetail?id=' + carId + '&location=' + license + '&locationId=0' + '">设备</a></td>'
							tr += '<td class="project-status"><span class="label label-inverse">空闲</td>'
							tr += '<td>' +
								'<button onclick="javascript:deleteCar(' + carId + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delcfmOverhaul"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'<button onclick="javascript:editCar(' + carId + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#editCarModal"><i class="fa fa-pencil"></i> 编辑 </button>' +
								'</td>'
							tr += '</tr>'
							$("tbody").append(tr)
							$('#addCarModal').modal('hide')
							$("#noCar" + driverId.toString()).remove()
						} else if (result == "INPUR") {
							alert("请输入正确的车牌号")
						} else if (result == "DUPLICATE") {
							alert("车牌号冲突")
						} else {
							alert("添加失败")
						}
	
					},
					error : function(data) {
						alert("修改失败")
					}
				})
			}
	
		})
	
		/*----------------------------------- 确认修改 ------------------------------------------*/
		$("#saveEditButton").click(function() {
			var carId = $("#editCarId").val()
			var license = $("#editCarLicense").val()
			var brand = $("#editCarBrand").val()
			var Brand = brand
			var driverId = parseInt($("#editDriverId").val())
			var options = $("#editDriverId option:selected");
			var driverName = options.text();
			var telephone = options.attr("name")
			if (license == '' || license == null) {
				alert("请输入车牌号")
			} else if (driverName == '' || driverName == null) {
				alert("司机选择不正确")
			} else {
				if (brand == '' || brand == null) {
					brand = 'none'
				}
				var driver = {
					id : driverId,
					realname : driverName
				}
				$.ajax({
					type : "POST",
					url : "car/editCar",
					data : JSON.stringify({
						id : parseInt(carId),
						license : license,
						brand : brand,
						driverId : driverId,
						driver : driver
					}),
					dataType : "json",
					contentType : "application/json",
					success : function(result) {
						if (result == "SUCCESS") {
							alert("修改成功")
							var editCar = $("#" + carId.toString())
							if (driverId == 0) { //暂不分配车辆
								editCar.children("td").eq(0).text(license)
								editCar.children("td").eq(1).text(Brand)
								editCar.children("td").eq(2).text('')
								editCar.children("td").eq(3).text('')
	
							} else {
								var oriRealName = editCar.children("td").eq(2).text()
								var oriTelephone = editCar.children("td").eq(3).text()
								editCar.children("td").eq(0).text(license)
								editCar.children("td").eq(1).text(Brand)
								editCar.children("td").eq(2).text(driverName)
								editCar.children("td").eq(3).text(telephone)
							}
							$('#editCarModal').modal('hide')
						} else if (result == "DUPLICATE") {
							alert("车牌号冲突")
						} else if (result == "INPUT") {
							alert("请输入正确的车牌号")
						} else {
							alert("修改失败")
						}
					},
					error : function(edit) {
						alert("修改失败")
					}
				})
			}
		})
	
		/*******************************按条件查询************************************* */
		$("#queryButton").click(function() {
			var queryCondition = $("#queryCondition").val()
			if (queryCondition == '' || queryCondition == null) {
				queryCondition = 'none'
			}
			$.ajax({
				type : "POST",
				url : "car/fuzzyQueryCar?condition=" + queryCondition,
				success : function(queryCarList) {
					$("#tabelDiv").empty()
					var table = table_start
					$.each(queryCarList, function(i, car) {
						table += '<tr class="gradeX" id="' + car.id + '">'
						table += '<td>' + car.license + '</td>'
						table += '<td>' + car.brand + '</td>'
						if (car.driver.realname != null) {
							table += '<td>' + car.driver.realname + '</td>'
							if (car.driver.telephone != null) {
								table += '<td>' + car.driver.telephone + '</td>'
							} else {
								table += '<td></td>'
							}
						} else {
							table += '<td></td>'
							table += '<td></td>'
						}
	
						table += '<td><a href="sensor/deviceDetail?id=' + car.id + '&location=' + car.license + '&locationId=0' + '">设备</a></td>'
						if (car.status == 0) {
							table += '<td class="project-status"><span class="label label-inverse">空闲</td>'
							table += '<td>' +
								'<button onclick="javascript:deleteCar(' + car.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delcfmOverhaul"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'<button onclick="javascript:editCar(' + car.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#editCarModal"><i class="fa fa-pencil"></i> 编辑 </button>' +
								'</td>'
						} else if (car.status == 1) {
							table += '<td class="project-status"><span class="label label-primary">在途中</td>'
							table += '<td>' +
								'<button onclick="javascript:deleteCar(' + car.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delcfmOverhaul"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'<button class="btn btn-white btn-sm"  disabled="disabled"><i class="fa fa-pencil"></i> 编辑 </button>' +
								'</td>'
						} else if (car.status == 2) {
							table += '<td class="project-status"><span class="label label-success">已到达</td>'
							table += '<td>' +
								'<button onclick="javascript:deleteCar(' + car.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delcfmOverhaul"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'<button class="btn btn-white btn-sm"  disabled="disabled"><i class="fa fa-pencil"></i> 编辑 </button>' +
								'</td>'
						} else if (car.status == 3) {
							table += '<td class="project-status"><span class="label label-danger">已派单</td>'
							table += '<td>' +
								'<button onclick="javascript:deleteCar(' + car.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delcfmOverhaul"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'<button onclick="javascript:editCar(' + car.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#editCarModal"><i class="fa fa-pencil"></i> 编辑 </button>' +
								'</td>'
	
						} else if (car.status == 4) {
							table += '<td class="project-status"><span class="label label-info">返程中</td>'
							table += '<td>' +
								'<button onclick="javascript:deleteCar(' + car.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delcfmOverhaul"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'<button onclick="javascript:editCar(' + car.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#editCarModal"><i class="fa fa-pencil"></i> 编辑 </button>' +
								'</td>'
						} else {
							table += '<td></td>'
							table += '<td>' +
								'<button onclick="javascript:deleteCar(' + car.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delcfmOverhaul"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'<button onclick="javascript:editCar(' + car.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#editCarModal"><i class="fa fa-pencil"></i> 编辑 </button>' +
								'</td>'
						}
						table += '</tr>'
					})
					table += table_end
					$('#tabelDiv').append(table)
					$('.dataTables-example').dataTable();
				}
			})
	
	
		})
	
		/*----------------------------------- 编辑 ------------------------------------------*/
		function editCar(carId) {
			$("#editCarId").val(carId)
			var lisense = $("#" + carId.toString()).children("td").eq(0).text();
			var brand = $("#" + carId.toString()).children("td").eq(1).text();
			$("#editCarLicense").val(lisense)
			$("#editCarBrand").val(brand)
	
		}
		/*----------------------------------- 删除------------------------------------------*/
		function deleteCar(carId) {
			$("#carId").val(carId)
		}
	</script>
</body>

</html>
