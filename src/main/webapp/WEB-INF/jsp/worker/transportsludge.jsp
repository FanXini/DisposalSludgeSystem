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
<link href="css/data/bootstrap-datetimepicker.min.css" rel="stylesheet" />



</head>

<body class="gray-bg">
	<!-- 用来存id -->
	<input id="sludgeId" type="hidden" />
	<input id="trIndex" type="hidden" />
	<!-- Modal -->

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
					<h4 class="modal-title">新增污泥运输记录</h4>
				</div>
				<div class="modal-body">
					<div class="container" style="width: 540px">
						<div class="form-group">
							<div>
								<label for="Groupname" class="col-sm-3 control-label">车牌号：</label>
								<div class="col-sm-9">
									<input type="text" class="form-control m-b control-label"
										id="addCarLicense" value="${requestScope.sludge.car.license}">
								</div>
							</div>
						</div>
						<div class="form-group">
							<div>
								<label for="Groupname" class="col-sm-3 control-label">司机：</label>
								<div class="col-sm-9">
									<input type="text" class="form-control m-b" id="addCarBrand"
										value="${sessionScope.user.realname}">
								</div>
							</div>
						</div>
						<div class="form-group">
							<div>
								<label for="Groupname" class="col-sm-3 control-label">污泥块编号：</label>
								<div class="col-sm-9">
									<input type="text" class="form-control m-b" id="addCarBrand"
										placeholder="请输入污泥块编号">
								</div>
							</div>
						</div>
						<div class="form-group">
							<div>
								<label for="Groupname" class="col-sm-3 control-label">污泥块重量：</label>
								<div class="col-sm-9">
									<input type="text" class="form-control m-b" id="addCarBrand"
										placeholder="请输入污泥块重量">
								</div>
							</div>
						</div>
						<div class="form-group">
							<div>
								<label for="Groupname" class="col-sm-3 control-label">目的地：</label>
								<div class="col-sm-9">
									<input type="text" class="form-control m-b" id="addCarBrand"
										placeholder="请输入运输目的地">
								</div>
							</div>
						</div>
						<div class="form-group">
							<div>
								<label for="Groupname" class="col-sm-3 control-label">污泥块生成时间：</label>
								<div class="col-sm-9">
									<input type="text" class="form-control m-b" id="addCarBrand"
										placeholder="请输入污泥块生成时间">
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






	<div class="wrapper wrapper-content animated fadeInRight">


		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h1 class="text-info"
							style="text-align: center; font-family: KaiTi; margin-top: -1%">污泥块去向记录</h1>
					</div>
					<div class="ibox-content project-list">

						<div class="col-lg-offset-2">

							<div class="" style="float: right">
								<div class="col-xs-1 query-department text-center">
									<button type="button" class="btn btn-primary"
										data-toggle="modal" data-target="#addCarModal">+ 污泥块运输登记</button>
								</div>
							</div>

							<!--<input type="text" class="form-control input-sm m-b-xs" id="filter" placeholder="搜索表格...">-->
						</div>

						<div id="tableDiv"></div>



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
				'<th>RFID</th>' +
				'<th>产地</th>' +
				'<th>目的地</th>' +
				'<th>处理人</th>' +
				'<th>污泥块重量</th>' +
				'<th>污泥功能</th>' +
				'<th data-hide="all">污泥产出时间</th>' +
				'<th data-hide="all">污泥到达时间</th>' +
				'<th data-hide="all">污泥运输车</th>' +
				'<th data-hide="all">处理人号码</th>' +
				'<th data-hide="all">处理污泥车车牌号</th>' +
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
				url : "sludge/transportsludgeofonedriver",
				data:JSON.stringify({
					id:${sessionScope.user.id }
				}),	
				dataType : "json",
				contentType : "application/json",			
				success : function(sludgeList) {
					$("#tableDiv").empty()
					var table = table_start
					$.each(sludgeList, function(i, sludge) {
						table += '<tr id="' + sludge.id + '">'
						if (sludge.rfidString != null) {
							table += '<td><span>' + sludge.rfidString + '</span></td>'
						} else {
							table += '<td class="project-status"><span class="label label-danger">未绑定RFID</td>'
						}
						table += '<td>' + (sludge.record.site.siteName==null?"":sludge.record.site.siteName)+ '</td>'
						table += '<td>' + (sludge.destinationAddress ==null?"":sludge.destinationAddress)+ '</td>'
						table += '<td class="project-manage">' +(sludge.car.driver.realname==null?"":sludge.car.driver.realname) + '</td>'
						if (sludge.weight == 0) {
							table += '<td><span class="label label-success">待输入</td>'
						} else {
							table += '<td>' + sludge.weight + '吨</td>'
						}
						if (sludge.functionId != 0) {
							table += '<td>' + sludge.sludgeFunction.function + '</td>'
						} else {
							table += '<td></td>'
						}
						table += '<td>' + (sludge.produceTime==null?"": sludge.produceTime)+ '</td>'
						table += '<td class="project-manager">' + (sludge.arrivalTime ==null?"": sludge.arrivalTime )+ '</td>'
						if (sludge.transcarId != 0) {
							table += '<td>' + sludge.transcarId + '</td>'
						} else {
							table += '<td></td>'
						}
						table += '<td>' + (sludge.car.driver.telephone==null?"":sludge.car.driver.telephone) + '</td>'
						table += '<td>' + ( sludge.car.license ==null?"": sludge.car.license)+ '</td>'
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
					url : "sludge/transportsludgeofonedriver",
				    data:JSON.stringify({
						id:${sessionScope.user.id }
					}),	
					success : function(sludgeList) {
						$("#tableDiv").empty()
						var table = table_start
						$.each(sludgeList, function(i, sludge) {
							table += '<tr id="' + sludge.id + '">'
							if (sludge.status == 0 ||sludge.status==2||sludge==4) {
								table += '<td class="project-status"><span class="label label-inverse">未到达</td>'
							} else if (sludge.status == 1||sludge.status == 3||sludge.status == 5) {
								table += '<td class="project-status"><span class="label label-primary">已到达</td>'
							} else {
								table += '<td></td>'
							}
							if (sludge.rfidString != null) {
								table += '<td><span>' + sludge.rfidString + '</span></td>'
							} else {
								table += '<td class="project-status"><span class="label label-danger">未绑定RFID</td>'
							}
							table += '<td>' + (sludge.record.site.siteName==null?"":sludge.record.site.siteName)+ '</td>'
							table += '<td>' + (sludge.destinationAddress ==null?"":sludge.destinationAddress)+ '</td>'
							table += '<td class="project-manage">' +(sludge.record.car.driver.realname==null?"":sludge.record.car.driver.realname)+ '</td>'
							if (sludge.weight == 0) {
								table += '<td><span class="label label-success">待输入</td>'
							} else {
								table += '<td>' + sludge.weight + '吨</td>'
							}
							if (sludge.functionId != 0) {
							table += '<td>' + sludge.sludgeFunction.function + '</td>'
						} else {
							table += '<td></td>'
						}
							table += '<td>' + (sludge.produceTime ==null?"": sludge.produceTime )+ '</td>'
							table += '<td class="project-manager">' + (sludge.arrivalTime ==null?"": sludge.arrivalTime ) + '</td>'
							if (sludge.transcarId != 0) {
								table += '<td>' + sludge.transcarId + '</td>'
							} else {
								table += '<td></td>'
							}
							table += '<td>' + (sludge.record.car.driver.telephone==null?"":sludge.record.car.driver.telephone) + '</td>'
							table += '<td>' + ( sludge.record.car.license ==null?"": sludge.record.car.license)+ '</td>'
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
					url : "sludge/querySludgeBySiteIdAndInOutFlag",
					data:JSON.stringify({
						siteId:parseInt(siteId),
						inOutFlag:parseInt($("#inOutSelect").val())
					}),
					dataType : "json",
					contentType : "application/json",
					success : function(sludgeList) {
						$("#tableDiv").empty()
						var table = table_start
						$.each(sludgeList, function(i, sludge) {
							table += '<tr id="' + sludge.id + '">'
							if (sludge.status == 0 ||sludge.status==2||sludge==4) {
								table += '<td class="project-status"><span class="label label-inverse">未到达</td>'
							} else if (sludge.status == 1||sludge.status == 3||sludge.status == 5) {
								table += '<td class="project-status"><span class="label label-primary">已到达</td>'
							} else {
								table += '<td></td>'
							}
							if (sludge.rfidString != null) {
								table += '<td><span>' + sludge.rfidString + '</span></td>'
							} else {
								table += '<td class="project-status"><span class="label label-danger">未绑定RFID</td>'
							}
							table += '<td>' + (sludge.record.site.siteName==null?"":sludge.record.site.siteName)+ '</td>'
							table += '<td>' + (sludge.destinationAddress ==null?"":sludge.destinationAddress)+ '</td>'
							table += '<td class="project-manage">' + (sludge.record.car.driver.realname==null?"":sludge.record.car.driver.realname) + '</td>'
							if (sludge.weight == 0) {
								table += '<td><span class="label label-success">待输入</td>'
							} else {
								table += '<td>' + sludge.weight + '吨</td>'
							}
							if (sludge.functionId != 0) {
							table += '<td>' + sludge.sludgeFunction.function + '</td>'
						} else {
							table += '<td></td>'
						}
							table += '<td>' + (sludge.produceTime ==null?"": sludge.produceTime ) + '</td>'
							table += '<td class="project-manager">' + (sludge.arrivalTime ==null?"":sludge.arrivalTime )+ '</td>'
							if (sludge.transcarId != 0) {
								table += '<td>' + sludge.transcarId + '</td>'
							} else {
								table += '<td></td>'
							}
							table += '<td>' + (sludge.record.car.driver.telephone==null?"":sludge.record.car.driver.telephone) + '</td>'
							table += '<td>' + ( sludge.record.car.license ==null?"": sludge.record.car.license)+ '</td>'
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
					url : "sludge/querySludgeByDateAndInOutFlag",
					data:JSON.stringify({
						startDate:startDate,
						endDate:endDate,
						inOutFlag:$("#inOutSelect").val()
					}),
					dataType : "json",
					contentType : "application/json",
					success : function(sludgeList) {
						$("#tableDiv").empty()
						var table = table_start
						$.each(sludgeList, function(i, sludge) {
							table += '<tr id="' + sludge.id + '">'
							if (sludge.status == 0 ||sludge.status==2||sludge==4) {
								table += '<td class="project-status"><span class="label label-inverse">未到达</td>'
							} else if (sludge.status == 1||sludge.status == 3||sludge.status == 5) {
								table += '<td class="project-status"><span class="label label-primary">已到达</td>'
							} else {
								table += '<td></td>'
							}
							if (sludge.rfidString != null) {
								table += '<td><span>' + sludge.rfidString + '</span></td>'
							} else {
								table += '<td class="project-status"><span class="label label-danger">未绑定RFID</td>'
							}
							table += '<td>' + (sludge.record.site.siteName==null?"":sludge.record.site.siteName)+ '</td>'
							table += '<td>' + (sludge.destinationAddress ==null?"":sludge.destinationAddress)+ '</td>'
							table += '<td class="project-manage">' + (sludge.record.car.driver.realname==null?"":sludge.record.car.driver.realname) + '</td>'
							if (sludge.weight == 0) {
								table += '<td><span class="label label-success">待输入</td>'
							} else {
								table += '<td>' + sludge.weight + '吨</td>'
							}
							if (sludge.functionId != 0) {
							table += '<td>' + sludge.sludgeFunction.function + '</td>'
						} else {
							table += '<td></td>'
						}
							table += '<td>' + (sludge.produceTime ==null?"": sludge.produceTime ) + '</td>'
							table += '<td class="project-manager">' + (sludge.arrivalTime ==null?"":sludge.arrivalTime )+ '</td>'
							if (sludge.transcarId != 0) {
								table += '<td>' + sludge.transcarId + '</td>'
							} else {
								table += '<td></td>'
							}
							table += '<td>' + (sludge.record.car.driver.telephone==null?"":sludge.record.car.driver.telephone) + '</td>'
							table += '<td>' + ( sludge.record.car.license ==null?"": sludge.record.car.license)+ '</td>'
							table += '</tr>'
	
						})
						table += table_end
						$('#tableDiv').append(table)
						$('.footable').footable();
	
	
					}
				})
			})
	
	
	
	
		});
	
		/*----------------------------------- 编辑 ------------------------------------------*/
	</script>

</body>

</html>
