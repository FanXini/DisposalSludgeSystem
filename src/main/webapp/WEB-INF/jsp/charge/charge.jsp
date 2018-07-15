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

    <title>收费清单</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <link rel="shortcut icon" href="favicon.ico">
    <link href="css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/footable/footable.core.css" rel="stylesheet">
    <link href="css/style.css?v=4.1.0" rel="stylesheet">
    <link href="css/data/bootstrap-datetimepicker.min.css" rel="stylesheet" />

</head>

<body class="gray-bg">
<!-- 用来存操作id -->
<input id="chargeId" type="hidden" />
<input id="trIndex" type="hidden" />

<!--Charge page-->
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h1 class="text-info"
                        style="text-align: center;font-family:KaiTi; margin-top:-1%">收费清单</h1>
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
                                    <%--<span class="input-group-addon"><span--%>
                                        <%--class="glyphicon glyphicon-calendar"></span></span>--%>
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
                                    <%--<span class="input-group-addon"><span--%>
                                        <%--class="glyphicon glyphicon-calendar"></span></span>--%>
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
                                                <li><a class="btn btn-primary site"
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

                    <div id="tabelDiv">
                    </div>

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
        var table_start = '<table id="table" class="footable table-hover table table-stripped toggle-arrow-tiny" data-page-size="8">' +
                '<thead>' +
                '<tr>' +
                '<th>厂家</th>' +
                '<th>日期</th>' +
                '<th>吨数</th>' +
                '<th>单价</th>' +
                '<th>折扣</th>' +
                '<th>总价</th>' +
                '<th>操作</th>' +
                '</tr>' +
                '</thead>' +
                '<tbody>'
        var tabel_end = '</tbody>' +
                '<tfoot>' +
                '<tr>' +
                '<td colspan="5">' +
                '<ul class="pagination pull-right"></ul>' +
                '</td>' +
                '</tr>' +
                '<tr>'+
                '<td colspan="5">' +
                '<div ><strong>注意：</strong> 请在30日内完成付款，谢谢。</div>' +
                '<div >' +
                '<address>' +
                '<strong>湖南省嵌入式与网络技术重点实验室</strong><br/>'+
                '<abbr title="Phone">总机：</abbr> (+86)18273138660'+
                '</address>'+
                '</address>'+
                '</td>'+
                '</tr>'+
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

        $.ajax({
            type : "POST",
            url : "charge/queryAllCharge",
            dataType : "json",
            contentType : "application/json",
            success : function(chargeList) {
                $("#tabelDiv").empty()
                var tabel = table_start
                $.each(chargeList, function(i,charge) {
                    tabel += '<tr id="' + charge.id + '">'
                    tabel += '<td>' + charge.record.site.siteName + '</td>'
                    tabel += '<td><span class="pie">' + charge.productTime + '</span></td>'
                    tabel += '<td>' + charge.weight+'</td>'
                    tabel += '<td>￥' +
                            '<input type="text" id="price" value="180.0" placeholder="180.00" onchange="checkNum('+charge.id+',this.value)" style="width:60px;border:0px">'+
                            '</td>'
                    tabel += '<td>' +
                            '<input type="text" id="discount" value="1.00" placeholder="1.00" onchange="checkNum1('+charge.id+',this.value)" style="width:60px;border:0px"/>'+
                            '</td>'
                    tabel += '<td>' +
                            '<input type="text" id="totalprice" value="" style="width:60px;border:0px">'+
                            '</td>'
                    tabel += '<td class="project-actions">' +
                           '<button onclick="javascript:calculatePrice(' + charge.id + ');" class="btn btn-white btn-sm" data-toggle="modal"> 计算 </button>' +
                            '</td>'
                    tabel += '</tr>'

                    function totalPrice()
                    {
                        var chargeTr = $("#" + charge.id.toString());
                        var weight = chargeTr.children("td").eq(2).text();
                        var price = chargeTr.children("td").eq(3).find("input").val();
                        var discount = chargeTr.children("td").eq(4).find("input").val();
                        var totalPrice = weight*price*discount;
                        chargeTr.children("td").eq(5).text(totalPrice);
                    }
                    totalPrice();
                })
                tabel += tabel_end
                $('#tabelDiv').append(tabel)
                $('.footable').footable();
            }
        })

        /*----------------------------------- 按工厂搜索按钮 ------------------------------------------*/
        $(".site").click(function() {
            var siteName = this.innerText
            $.ajax({
                type : "POST",
                url : "charge/queryChargeBySiteName?siteName=" + siteName,
                dataType : "json",
                contentType : "application/json",
                success : function(chargeList) {
                    $("#tabelDiv").empty()
                    var tabel = table_start
                    $.each(chargeList, function(i, charge) {
                        tabel += '<tr id="' + charge.id + '">'
                        tabel += '<td>' + charge.record.site.siteName + '</td>'
                        tabel += '<td><span class="pie">' + charge.productTime + '</span></td>'
                        tabel += '<td>' + charge.weight+'</td>'
                        tabel += '<td>￥' +
                                '<input type="text" id="price" value="180.0" onchange="checkNum('+charge.id+',this.value)" style="width:60px;border:0px">'+
                                '</td>'
                        tabel += '<td>' +
                                '<input type="text" id="discount" value="1.00" onchange="checkNum1('+charge.id+',this.value)" style="width:60px;border:0px"/>'+
                                '</td>'
                        tabel += '<td>' +
                                '<input type="text" id="totalprice" value ="" style="width:60px;border:0px">'+
                                '</td>'
                        tabel += '<td class="project-actions">' +
                                '<button onclick="javascript:calculatePrice(' + charge.id + ');" class="btn btn-white btn-sm" data-toggle="modal"> 计算 </button>' +
                                '</td>'
                        tabel += '</tr>'
                    })
                    tabel += tabel_end
                    $('#tabelDiv').append(tabel)
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
                url : "charge/queryChargeByDate?startDate=" + startDate + "&endDate=" + endDate,
                dataType : "json",
                contentType : "application/json",
                success : function(chargeList) {
                    $("#tabelDiv").empty()
                    var tabel = table_start
                    $.each(chargeList, function(i,charge) {
                        tabel += '<tr id="' + charge.id + '">'
                        tabel += '<td>' + charge.record.site.siteName + '</td>'
                        tabel += '<td><span class="pie">' + charge.productTime + '</span></td>'
                        tabel += '<td>' + charge.weight+'</td>'
                        tabel += '<td>￥' +
                                '<input type="text" id="price" value="180.0" onchange="checkNum('+charge.id+',this.value)" style="width:60px;border:0px">'+
                                '</td>'
                        tabel += '<td>' +
                                '<input type="text" id="discount" value="1.00" onchange="checkNum1('+charge.id+',this.value)" style="width:60px;border:0px"/>'+
                                '</td>'
                        tabel += '<td>' +
                                '<input type="text" id="totalprice" value="" style="width:60px;border:0px">'+
                                '</td>'
                        tabel += '<td class="project-actions">' +
                                '<button onclick="javascript:calculatePrice(' + charge.id + ');" class="btn btn-white btn-sm" data-toggle="modal"> 计算 </button>' +
                                '</td>'
                        tabel += '</tr>'
                    })
                    tabel += tabel_end
                    $('#tabelDiv').append(tabel)
                    $('.footable').footable();
                }
            })
        })
    });

    /*----------------------------------- 输入校验 ------------------------------------------*/
    function checkNum(chargeId,value){
        if(! value.match(/^\d+.\d$/)) // ^表示开始  $表示结束 小数点后一位
        {
            var chargeTr = $("#" + chargeId.toString());
            chargeTr.children("td").eq(3).find("input").val("");
            alert("请输入正确的格式,如:180.0");
        }
    }

    function checkNum1(chargeId,value){
        if(! value.match(/^[0-1].\d\d$/)) // ^表示开始  $表示结束 小数点后两位,共五位
        {
            var chargeTr = $("#" + chargeId.toString());
            chargeTr.children("td").eq(4).find("input").val("");
            alert("请输入正确的格式,如:0.88");
        }
    }
    /*----------------------------------- 编辑 ------------------------------------------*/
    function calculatePrice(chargeId) {

        var chargeTr = $("#" + chargeId.toString());
        var weight = chargeTr.children("td").eq(2).text();
        var price = chargeTr.children("td").eq(3).find("input").val();
        var discount = chargeTr.children("td").eq(4).find("input").val();
        var totalPrice = weight*price*discount;
        chargeTr.children("td").eq(5).text("￥"+totalPrice);
//        alert(chargeId+":"+weight+","+price+","+discount)
    }

</script>

</body>

</html>
