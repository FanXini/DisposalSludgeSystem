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
			url : "mudWareHouse/queryWareHouse",
			/* data:JSON.stringify({
				userId:userId
			}), */
			dataType : "json",
			contentType : "application/json",
			success : function(mudWareHouse) {
				$("#capacity").val(parseInt(mudWareHouse.capcity)+"吨")
				var ctx = $("#myPieChart").get(0).getContext('2d');
				var myPieChart = new Chart(ctx, {
					type : "pie",
					data : {
						labels : [ "存储量", "剩余量" ],
						datasets : [ {
							data : [
									mudWareHouse.capcity
											- mudWareHouse.remainCapcity,
									mudWareHouse.remainCapcity ],
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

			}
		})

	})
</script>
<style type="text/css">
h1, h2 {
	text-align: center;
}

#capacityDiv {
	position: relative;
	width: 20%;
	left:40%
}
#chartAreat{
	position:relative;
	margin-top:5%
}
</style>

</head>

<body>
	<div class="container-fluid">
		<!-- 月消费模块 -->
		<div id="chartAreat">

			<h1 class="text-info" id="monthModelInfo">泥仓容量</h1>
			<div id="capacityDiv" class="input-group">
				<span class="input-group-addon">总容量</span> <input id="capacity"
					type="text" class="form-control" readonly />
			</div>

			<div id="canvas">
				<canvas id="myPieChart"></canvas>
			</div>
		</div>
	</div>



</body>

</html>
