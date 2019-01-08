<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<script type="text/javascript">
	if (window.XMLHttpRequest) { // code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
	} else { // code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.open("GET", "CD.xml", false);
	xmlhttp.send();
	xmlDoc = xmlhttp.responseXML;

	x = xmlDoc.getElementsByTagName("CD");
	i = 0;

	function displayCD() {
		alert(x[i].getElementsByTagName("TITLE"));
		artist = (x[i].getElementsByTagName("ARTIST")[0].childNodes[0].nodeValue);
		title = (x[i].getElementsByTagName("TITLE")[0].childNodes[0].nodeValue);
		year = (x[i].getElementsByTagName("YEAR")[0].childNodes[0].nodeValue);
		txt = "Artist: " + artist + "<br />Title: " + title + "<br />Year: " + year;
		document.getElementById("showCD").innerHTML = txt;
	}

	function next() {
		if (i < x.length - 1) {
			i++;
			displayCD();
		}
	}

	function previous() {
		if (i > 0) {
			i--;
			displayCD();
		}
	}
</script>
</head>
<body onload="displayCD()">

	<div id='showCD'></div>
	<br />
	<input type="button" onclick="previous()"
		value="<<" />
<input type="button" onclick="next()" value=">>" />

</body>
</html>

