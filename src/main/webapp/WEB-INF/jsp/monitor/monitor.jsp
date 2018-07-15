<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>实时监控</title>
     <meta charset="UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1.0" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" >
    <meta name="renderer" content="webkit">
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico">
    <link href="css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css?v=4.1.0" rel="stylesheet">
		<style>
			html,
			body {
				height: 100%;
			}		
			
			.box1 {
				width: 100px;
				float: center;
				display: inline;
				border: inherit 1px solid;
				padding: 8px 8px;
			}
			
			.box2 {
				width: 100px;
				float: center;
				display: inline;
				border: inherit 1px solid;
				padding: 8px 8px;
			}
			
			.box3 {
				width: 100px;
				float: center;
				display: inline;
				border: inherit 1px solid;
				padding: 8px 8px;
			}
			
			.box4 {
				width: 100px;
				float: center;
				display: inline;
				border: inherit 1px solid;
				padding: 8px 8px;
			}
			
			.box5 {
				width: 50px;
				height:50px;
				float: center;
				display: inline;
				border: inherit 1px solid;
				padding: 5px 5px;
			}
			
			.box6 {
				width: 50px;
				float: center;
				display: inline;
				border: inherit 1px solid;
				padding: 5px 5px;
			}
			
			.btn-sm {
				padding: 8px 24px !important;
				font-size: 16px !important;
			}
			
			.video {
				padding: 0px 0px;
				margin-bottom: 0px;
				margin-top: 0px;
			}
			
			.img-thumbnail {
				width: auto;
				height: auto;
				margin: 5px auto 5px auto;
			}
			
			
			
			.divlicense {
				float: center;
				left: 50%;
				top: 50%;				
				margin: 15px 15px 15px 15px;
				font-family: Georgia;
				font-size: 16px;
				vertical-align: middle;
				text-align: center;
			}
			 .div2 {
               margin: auto; 
            }
            
            #page-wrapper{
            	position:relative;
            	top:5%;
            	left:-10%;
            	
            }
		</style>

	</head>

	<body>
		<script src="https://open.ys7.com/sdk/js/1.3/ezuikit.js"></script>
        <!--右侧部分开始-->
		<div id="page-wrapper"  class="container-fluid">
			<div class="row clearfix video">
			
				<div class="col-md-4 column">
					<div>
						<video class="box5" id="myPlayer0" poster="" controls playsInline webkit-playsinline autoplay>
					    <source src="rtmp://rtmp.open.ys7.com/openlive/f01018a141094b7fa138b9d0b856507b" type="" />
						<source src="http://hls.open.ys7.com/openlive/f01018a141094b7fa138b9d0b856507b.m3u8" type="application/x-mpegURL" />    
						</video>
					</div>
					<div class="divlicense">
						<img class="box5" alt="140x140" src="img/littercar.png" width="10%" height="10%" />
						<p class="box6" style="text-align:center;">湘A&nbsp;34611</p>
					</div>
				</div>

				<div class="col-md-4 column">
					<div>
						<video class="box5" id="myPlayer1" poster="" controls playsInline webkit-playsinline autoplay>
					    <source src="rtmp://rtmp.open.ys7.com/openlive/f01018a141094b7fa138b9d0b856507b" type="" />
					    <source src="http://hls.open.ys7.com/openlive/f01018a141094b7fa138b9d0b856507b.m3u8" type="application/x-mpegURL" />
						</video>
					</div>

					<div class="divlicense">
						<img class="box5" alt="140x140" src="img/littercar.png" width="10%" height="10%" />
						<p class="box6" style="text-align:center;">湘A&nbsp;25431</p>
					</div>
				</div>
				<div class="col-md-4 column">
					<div>
						<video class="box5" id="myPlayer2" poster="" controls playsInline webkit-playsinline autoplay>
					    <source src="rtmp://rtmp.open.ys7.com/openlive/f01018a141094b7fa138b9d0b856507b" type="" />
					    <source src="http://hls.open.ys7.com/openlive/f01018a141094b7fa138b9d0b856507b.m3u8" type="application/x-mpegURL" />
						</video>
					</div>
					<div class="divlicense">
						<img class="box5" alt="140x140" src="img/littercar.png" width="10%" height="10%" />
						<p class="box6" style="text-align:center;">湘A&nbsp;36097</p>
					</div>
				</div>
			</div>
			<div class="row clearfix video">
				<div class="col-md-4 column">
					<div>
						<video class="box5" id="myPlayer3" poster="" controls playsInline webkit-playsinline autoplay>
					    <source src="rtmp://rtmp.open.ys7.com/openlive/f01018a141094b7fa138b9d0b856507b" type="" />
					    <source src="http://hls.open.ys7.com/openlive/f01018a141094b7fa138b9d0b856507b.m3u8" type="application/x-mpegURL" />
						</video>
					</div>
					<div class="divlicense">
						<img class="box5" alt="140x140" src="img/littercar.png" width="10%" height="10%" />
						<p class="box6" style="text-align:center;">湘A&nbsp;54123</p>
					</div>
				</div>
				<div class="col-md-4 column">
					<div>
						<video class="box5" id="myPlayer4" poster="" controls playsInline webkit-playsinline autoplay>
					    <source src="rtmp://rtmp.open.ys7.com/openlive/f01018a141094b7fa138b9d0b856507b" type="" />
					    <source src="http://hls.open.ys7.com/openlive/f01018a141094b7fa138b9d0b856507b.m3u8" type="application/x-mpegURL" />
						</video>
					</div>
		
					<div class="divlicense">
						<img class="box5" alt="140x140" src="img/littercar.png" width="10%" height="10%" />
						<p class="box6" style="text-align:center;">湘A&nbsp;89654</p>
					</div>
				</div>
				<div class="col-md-4 column">
					<div>
						<video class="box5" id="myPlayer5" poster="" controls playsInline webkit-playsinline autoplay>
					    <source src="rtmp://rtmp.open.ys7.com/openlive/f01018a141094b7fa138b9d0b856507b" type="" />
					    <source src="http://hls.open.ys7.com/openlive/f01018a141094b7fa138b9d0b856507b.m3u8" type="application/x-mpegURL" />
						</video>
					</div>
		
					<div class="divlicense">
						<img class="box5" alt="140x140" src="img/littercar.png" width="10%" height="10%" />
						<p class="box6" style="text-align:center;">湘A&nbsp;28796</p>
					</div>
				</div>
			</div>
		</div>
<!-- 全局js -->
    <script src="js/jquery.min.js?v=2.1.4"></script>
    <script src="js/bootstrap.min.js?v=3.3.6"></script>
    <script src="js/plugins/metisMenu/jquery.metisMenu.js"></script>
    <script src="js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
    <script src="js/plugins/layer/layer.min.js"></script>

    <!-- 自定义js -->
    <script src="js/hAdmin.js?v=4.1.0"></script>
    <script type="text/javascript" src="js/index.js"></script>

    <!-- 第三方插件 -->
    <script src="js/plugins/pace/pace.min.js"></script>
    
    <script>
    var player = new EZUIPlayer('myPlayer');
    player.on('error', function(){
        console.log('error');
    });
    player.on('play', function(){
        console.log('play');
    });
    player.on('pause', function(){
        console.log('pause');
    });
    
    var player = new EZUIPlayer('myPlayer0');
    player.on('error', function(){
        console.log('error');
    });
    player.on('play', function(){
        console.log('play');
    });
    player.on('pause', function(){
        console.log('pause');
    });
    
    var player = new EZUIPlayer('myPlayer1');
    player.on('error', function(){
        console.log('error');
    });
    player.on('play', function(){
        console.log('play');
    });
    player.on('pause', function(){
        console.log('pause');
    });
    
     var player = new EZUIPlayer('myPlayer2');
    player.on('error', function(){
        console.log('error');
    });
    player.on('play', function(){
        console.log('play');
    });
    player.on('pause', function(){
        console.log('pause');
    });
     var player = new EZUIPlayer('myPlayer3');
    player.on('error', function(){
        console.log('error');
    });
    player.on('play', function(){
        console.log('play');
    });
    player.on('pause', function(){
        console.log('pause');
    });
     var player = new EZUIPlayer('myPlayer4');
    player.on('error', function(){
        console.log('error');
    });
    player.on('play', function(){
        console.log('play');
    });
    player.on('pause', function(){
        console.log('pause');
    });
     var player = new EZUIPlayer('myPlayer5');
    player.on('error', function(){
        console.log('error');
    });
    player.on('play', function(){
        console.log('play');
    });
    player.on('pause', function(){
        console.log('pause');
    });
    
    
    </script>
    

</html>