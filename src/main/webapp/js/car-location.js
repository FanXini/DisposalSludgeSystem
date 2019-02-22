/**
 * 
 */
var gpsUserId = "";
var mds = "";
var locationMap={};
function createLocation(longitude,latitude) {
    var o = new Object();
    o.longitude = longitude;
    o.latitude = latitude;
    return o;
}

function getLocation(deviceId, serialNumber) {
		if (gpsUserId == "" || mds == "") {
			var location= getLocationWithoutMDS(deviceId, serialNumber);
		} else {
			var location=getLocationWithMDS(deviceId, serialNumber);
		}
		//alert(JSON.stringify(locationMap))
	}

	function getLocationWithoutMDS(deviceId, serialNumber) {
		$.ajax({
			type : "GET",
			async : false,
			url : "http://api.18gps.net/GetDateServices.asmx/loginSystem?LoginName=teamluo123456&LoginPassword=123456&LoginType=ENTERPRISE&language=cn&ISMD5=0&timeZone=+08&apply=WEB",
			data : "",
			dataType : "jsonp",
			success : function(data) {
				gpsUserId = data.id;
				mds = data.mds;
				$.ajax({
					type : "GET",
					url : "http://api.18gps.net/GetDateServices.asmx/GetDate?method=loadUser&user_id=" + deviceId + "&mds=" + mds,
					data : "",
					dataType : "jsonp",
					async:false,
					success : function(data2) {
						if (data2.errorCode == "200") {
							long_la = data2.data[0].jingdu + "_" + data2.data[0].weidu;
							var loc=new createLocation(data2.data[0].jingdu,data2.data[0].weidu);
							locationMap[deviceId]=loc;
						} else if (data2.errorCode == 403) {
							getLocation(deviceId, serialNumber);
						}
					}
				});
			}
		});

	}

	function getLocationWithMDS(deviceId, serialNumber) {
		$.ajax({
			type : "GET",
			url : "http://api.18gps.net/GetDateServices.asmx/GetDate?method=loadUser&user_id=" + deviceId + "&mds=" + mds,
			data : "",
			dataType : "jsonp",
			async:false,
			success : function(data2) {
				if (data2.errorCode == "200") {
					long_la = data2.data[0].jingdu + "_" + data2.data[0].weidu;
					var loc=new createLocation(data2.data[0].jingdu,data2.data[0].weidu);
					locationMap[deviceId]=loc;
				} else if (data2.errorCode == 403) {
					getLocationWithMDS(deviceId, serialNumber);
				}
			}
		});
	}