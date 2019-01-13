<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%-- <%@ taglib prefix="s" uri="/struts-tags"%> --%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'MonthConsume.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1.0" />
<link href="css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
<link href="css/style.css?v=4.1.0" rel="stylesheet">
<script type="text/javascript" src="js/other/Chart.js"></script>
<script src="js/jquery.min.js?v=2.1.4"></script>
<script src="js/bootstrap.min.js?v=3.3.6"></script>
<title>月消费</title>
<script>
	$(function() {

		var userId =
<%=session.getAttribute("id")%>
	;

		$.ajax({
			type : "POST",
			url : "mudWareHouse/queryMinorWareHouse",
			/* data:JSON.stringify({
				userId:userId
			}), */
			dataType : "json",
			contentType : "application/json",
			success : function(minorWareHouseList) {
				$.each(minorWareHouseList, function(i, minorWareHouse){
					$("#serialNumber_"+i).html(minorWareHouse.serialNumber+"号仓"+"("+minorWareHouse.moistrueDegree+")");
					$("#capacity_"+i).val(minorWareHouse.capacity+"吨");
					var ctx = $("#myPieChart_"+i).get(0).getContext('2d');
					var myPieChart = new Chart(ctx, {
						type : "pie",
						data : {
							labels : [ "存储量", "剩余量" ],
							datasets : [ {
								data : [
									minorWareHouse.capacity
												- minorWareHouse.remainCapacity,
												minorWareHouse.remainCapacity ],
								backgroundColor : [ 'rgba(255, 99, 132, 1)', /*前面三项是rgb(red,green,blue)后面一项的透明度*/
								'rgba(54, 162, 235, 1)'
								/* 		'rgba(255, 206, 86, 1)',
										'rgba(75, 192, 192, 1)',
										'rgba(153, 102, 255,1)',
										'rgba(255, 159, 64, 1)',
										'rgba(245,242,34,1)' */
								]
							} ]
						}

					})
				})

			}
		})

	})
</script>
<style type="text/css">
h1, h2 {
	text-align: center;
}

.capacityDiv {
	position: relative;
	width: 45%;
	left: 25%
}


#chartAreat {
	position: relative;
	margin-top: 5%
}
</style>

</head>

<body class="gray-bg">
	<!-- <div class="container-fluid">
		月消费模块

		<h1 class="text-info" id="monthModelInfo">泥仓容量</h1>
		<div id="capacityDiv" class="input-group">
			<span class="input-group-addon">总容量</span> <input id="capacity"
				type="text" class="form-control" readonly />
		</div>

		<div id="canvas">
			<canvas id="myPieChart"></canvas>
		</div>
	</div> -->

	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-4">
				<h1 class="text-info" id="serialNumber_0"></h1>
				<div  class="input-group capacityDiv">
					<span class="input-group-addon">总容量</span> <input id="capacity_0"
						type="text" class="form-control" readonly />
				</div>
				

				<div>
					<canvas id="myPieChart_0" class="canvas"></canvas>
				</div>
			</div>
			<div class="col-sm-4">
				<h1 class="text-info" id="serialNumber_1"></h1>
				<div class="input-group capacityDiv">
					<span class="input-group-addon">总容量</span> <input id="capacity_1"
						type="text" class="form-control" readonly />
				</div>

				<div>
					<canvas id="myPieChart_1" class="canvas"></canvas>
				</div>
			</div>
			<div class="col-sm-4">
				<h1 class="text-info" id="serialNumber_2"></h1>
				<div  class="input-group capacityDiv">
					<span class="input-group-addon">总容量</span> <input id="capacity_2"
						type="text" class="form-control" readonly />
				</div>

				<div>
					<canvas id="myPieChart_2" class="canvas"></canvas>
				</div>
			</div>


		</div>
	</div>

	<!-- 自定义js -->
	<script src="js/content.js?v=1.0.0"></script>



	<script>
		$(document).ready(function() {
			$('.contact-box').each(function() {
				animationHover(this, 'pulse');
			});
		});
	</script>





</body>

</html>
