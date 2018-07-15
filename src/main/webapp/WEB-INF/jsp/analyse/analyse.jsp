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

	<title>数据分析</title>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width,initial-scale=1" />

	<script src="js/other/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/plugins/data/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript" src="js/plugins/data/bootstrap-datetimepicker.zh-CN.js"></script>
	<link rel="stylesheet" href="css/bootstrap.min.css" />
	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
	<link rel="stylesheet" href="css/data/bootstrap-datetimepicker.min.css" />
	<link rel="stylesheet" href="css/style.css" />

	<script>
		$(function(){
			$(".form_date").datetimepicker({
				format: "yyyy-mm-dd hh:00",
				language: 'zh-CN',
				weekStart: 1,
				todayBtn: true,
				autoClose: 1,
				startView: 2,
				todayHighlight: 1,
				minView: 1
			});
		})
	</script>

</head>

<body class="gray-bg">

<!--Charge page-->
<div class="wrapper wrapper-content animated fadeInRight">
	<div class="row">
		<div class="col-sm-12">
			<div class="ibox float-e-margins">
				<div class="ibox-title">
					<h1 class="text-info"
						style="text-align: center;font-family:KaiTi; margin-top:-1%">数据分析</h1>
				</div>
				<div class="ibox-content project-list">
					<div class="col-lg-offset-2">
						<div class="form-inline">

							<div class="form-group" id="start_date">
								<label class="sr-only">起始时间</label>
								<div class="input-group date form_date">
										<span class="input-group-addon">起始时间&nbsp;<i
												class="fa fa-calendar-o"></i></span> <input id="start_date_text" type="text" class="form-control" readonly /> <span
										class="input-group-addon"><span
										class="glyphicon glyphicon-remove"></span></span>
								</div>
							</div>

							<div class="form-group" id="end_date">
								<label class="sr-only">截止时间</label>
								<div class="input-group date form_date">
										<span class="input-group-addon">截止时间&nbsp;<i
												class="fa fa-calendar-o"></i></span>
									<input id="end_date_text" type="text" class="form-control" readonly /> <span
										class="input-group-addon"><span
										class="glyphicon glyphicon-remove"></span></span>
								</div>
							</div>

							<div class="form-group col-lg-offset-1" id="siteList" style="margin-top:4px;">
								<label class="sr-only">工厂</label>
								<div class="input-group">
									<div class="btn-group">
										<button class="btn btn-default" disabled="disabled">选择工厂</button>
										<button class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
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

							<button class="btn btn-primary" id="submit"
									style="margin-top:3px">查询</button>
						</div>
					</div>

					<div id="main" style="width:100%;height:450px;"></div>

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
<!-- echarts -->
<script src="js/plugins/echarts/echarts.min.js"></script>

<script type="text/javascript">
	var myChart = echarts.init(document.getElementById('main'));
	var siteName = "湖南通莱科技公司";//湖南星科环保科技有限公司
	var siteId;
	$.ajax( {
		type : "POST",
		url : "analyse/querySludgeBySiteName?siteName=" + siteName,
		dataType : "json",
		contentType : "application/json",
		success : function(sludgeList) {
			var columLabel=[siteName];
			var columName = new Array();
			var columnValue = new Array();

			$.each(sludgeList, function(i, sludge) {
				columName.push(sludge.produceTime.split(" ")[0]);
				columnValue.push(sludge.weight);
			})

			buildChart(columLabel,columName,columnValue);
		}
	});

	/*----------------------------------- 按工厂搜索按钮 ------------------------------------------*/
	$(".site").click(function() {
		siteName = this.innerText
		siteId = parseInt(this.getAttribute("name"))
/* 		alert(siteId+",site:"+siteName) */
		var startDate = $("#start_date_text").val()
		var endDate = $("#end_date_text").val()

		$.ajax( {
			type : "POST",
//			url : "analyse/querySludgeBySiteName?siteName=" + siteName,
//			url : "analyse/querySludgeBySiteName?siteName=" + siteId+ "&startDate=" + startDate + "&endDate=" + endDate,
			url : "analyse/querySludgeByDates?startDate=" + startDate + "&endDate=" + endDate+"&siteId="+siteId,
			dataType : "json",
			contentType : "application/json",
			success : function(sludgeList) {
				var columLabel=[siteName];
				var columName = new Array();
				var columnValue = new Array();

				$.each(sludgeList, function(i, sludge) {
					columName.push(sludge.produceTime.split(" ")[0]);
					columnValue.push(sludge.weight);
				})

				buildChart(columLabel,columName,columnValue);
			}
		});
	});

	/*----------------------------------- 按日期和工厂搜索按钮 ------------------------------------------*/
	$("#submit").click(function() {
		var startDate = $("#start_date_text").val()
		var endDate = $("#end_date_text").val()
		if(siteId != null && siteId != "")
		{
			alert("请选择工厂");
		}
		$.ajax({
			type : "POST",
			url : "analyse/querySludgeByDates?startDate=" + startDate + "&endDate=" + endDate+"&siteId="+siteId,
			dataType : "json",
			contentType : "application/json",
			success : function(sludgeList) {
				var columLabel=[];
				var columName = new Array();
				var columnValue = new Array();

				$.each(sludgeList, function(i, sludge) {
					columName.push(sludge.produceTime.split(" ")[0]);
					columnValue.push(sludge.weight);
				})

				buildChart(columLabel,columName,columnValue);
			}
		})
	});

	function buildChart(columLabel,columName,columnValue)
	{
		var chart = document.getElementById('main');
		var echart = echarts.init(chart);
		var option = {
			title : {
				text: columLabel,
				x: 'center',
				align: 'right'
			},
			tooltip : {
				trigger: 'axis',
				axisPointer : {
					type : 'shadow'
				}
			},

			legend: {
				data:columLabel,
				x:'left'
			},

			dataZoom: [
				{
					show: true,
					realtime: true,
					start: 0,
					end: 100
				}
			],
			grid: {
				left: '5%',
				right: '5%',
				bottom: '5%',
				top:'15%',
				containLabel: true
			},
			toolbox: {
				show : true,
				feature : {
					//dataZoom:{yAxisIndex:'none'},
					mark : {show: true},
					dataView : {show: true, readOnly: false},
					magicType : {show: true, type: ['line', 'bar']},
					restore : {show: true},
					saveAsImage : {show: true}
				}
			},
			calculable : true,
			xAxis : [
				{
					axisLable:{
						show: true,
						rotate: 45,
						interval:0,
					},
					min:0,
					type : 'category',
					data : columName
				}
			],
			yAxis : [
				{
					min:0,
					type : 'value'
				}
			],
			series :[ {
				name:columLabel,
				type:'bar',
				data: columnValue
			}
			]
		};
		echart.setOption(option);
	}

</script>

</body>

</html>
