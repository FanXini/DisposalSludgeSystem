package factory.tcpnet;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
//import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;



public class SqlOperator01 {

	protected static String dbClassName = "com.mysql.jdbc.Driver";
//	protected static String dbUrl = "jdbc:mysql://localhost:3306/disposalsludgesystem?characterEncoding=utf8";
	protected static String dbUrl = "jdbc:mysql://119.23.29.190:3306/DisposalSludgeSystem?characterEncoding=utf8";
//	protected static String dbUrl = "jdbc:mysql://115.157.200.88:3306/iot_2017?characterEncoding=utf8";
	protected static String dbUser = "fanxin";
	protected static String dbPwd = "123456";
//	protected static String dbUser = "root";
//	protected static String dbPwd = "zxx123";
	private static Connection conn = null;
	
	private SqlOperator01()
	{
		if (conn == null)
		{
			try {
				Class.forName(dbClassName).newInstance();
				conn = DriverManager.getConnection(dbUrl, dbUser, dbPwd);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
	}
	
	public static void close()
	{
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("conn close failed.");
		}
		conn = null;
	}
	
	private static ResultSet excuteResult(String sql)
	{
		if(conn == null)
		{
			new SqlOperator01();
		}
		try {
			return (ResultSet) conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE).executeQuery(sql);
		} catch (SQLException e) {
			return null;
		}
	}
	
	private static ResultSet excuteQuery(String sql) {
		try {
			if(conn==null)
			new SqlOperator01();
			return (ResultSet) conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public static int excuteUpdate(String sql)
	{
		try {
			if(conn == null)
			{
				new SqlOperator01();
			}
			return conn.createStatement().executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Update sql failed..");
		}
		return -1;
	}
	
	public static int insertSensorInfo(String sensorId, String sensorType, String status, String value1, String value2, String value3, String recordTime, String remark)
	{
		String sql = "";
		if(value1=="" || ("").equals(value1))
		{
			System.out.println("No value..please check.");
		}
		else if(value2=="" || ("").equals(value2))
		{
			sql = "insert into SENSOR_COL(sensorId,sensorType,status,value1,recordTime,remark) values ('"+sensorId+"','"+sensorType+"','"+status+"','"+Float.parseFloat(value1)+"','"+recordTime+"','"+remark+"' "+")";
		}
		else if(value3=="" || ("").equals(value3))
		{
			sql = "insert into SENSOR_COL(sensorId,sensorType,status,value1,value2,recordTime,remark) values ('"+sensorId+"','"+sensorType+"','"+status+"','"+Float.parseFloat(value1)+"','"+Float.parseFloat(value2)+"','"+recordTime+"','"+remark+"' "+")";
		}
		else
		{
			sql = "insert into SENSOR_COL(sensorId,sensorType,status,value1,value2,value3,recordTime,remark) values ('"+sensorId+"','"+sensorType+"','"+status+"','"+Float.parseFloat(value1)+"','"+Float.parseFloat(value2)+"', '"+Float.parseFloat(value3)+"', '"+recordTime+"','"+remark+"' "+")";
		}
		int i = SqlOperator01.excuteUpdate(sql);
		if(i>0)
		{
			return i;
		}
		return -1;
	}
	
	
	
	/*public static int updateEntity(String entityId, String status,String statusType)
	{
		int i = 0;
		String sql = "update entity_info set entityStatus = '"+status+"' , statusType = '"+statusType+"' where entityId = '"+entityId+"'";
		i = SqlOperator01.excuteUpdate(sql);
		return i;
	}
	
	public static int insertMainInfo(String entityId, String status,String userId,String cause,String recordTime)
	{
		int i = 0;
		String sql = "insert into maintain_info(entityId,status,userId,cause,recordTime) values ('"+entityId+"','"+status+"','"+userId+"','"+cause+"','"+recordTime+"' "+")";
		i = SqlOperator01.excuteUpdate(sql);
		return i;
	}
	
	public static int updateMainInfo(String entityId, String status,String cause,String recordTime)
	{
		int i = 0;
		String sql = "update maintain_info set status = '"+status+"' , cause = '"+cause+"' , recordTime = '"+recordTime+"' where entityId in (select a.entityId from (select entityId from MAINTAIN_INFO where entityId='"+entityId+"' order by recordTime desc limit 1) a)";
		i = SqlOperator01.excuteUpdate(sql);
		return i;
	}*/
	//zxx...
	
	public static int searchSensor_id(String serial_number){
		//根据传感器标识号查找sensor_id
		int sensor_id = 0;
		//String car_id = null;
		String sql = "select id FROM sensor where serial_number = '"+serial_number+"'";
		ResultSet rs1 = SqlOperator01.excuteQuery(sql);
		try {
			if(rs1.next()){
			sensor_id = Integer.parseInt(rs1.getString("id"));
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//car_id = rs1.getString("car_id");
		return sensor_id;
	}
	
	/**
	 * gps部分，car方面
	 */
	public static int searchCarid(String serial_number){
		//根据传感器标识号查询car_id
		int car_id = 0;
		String sql = "select car_id FROM sensor where serial_number = '"+serial_number+"'";
		ResultSet rs1 = SqlOperator01.excuteQuery(sql);
		try {
			if(rs1.next()){
			car_id = Integer.parseInt(rs1.getString("car_id"));
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return car_id;
	}
	
	public static int searchCarStatus(int car_id){
		//根据car_id查询污泥处理车的状�??
		int status = 0;
		String sql = "select status FROM car where id = "+car_id+"";
		ResultSet rs1 = SqlOperator01.excuteQuery(sql);
		try {
			if(rs1.next()){
			status = Integer.parseInt(rs1.getString("status"));
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return status;
	}
	
	public static int searchRecordid(int car_id){
		int record_id = 0;
		String sql = "select id from record where car_id = '"+car_id+"' and status = "+0+"";
		ResultSet rs1 = SqlOperator01.excuteQuery(sql);
		try {
			if(rs1.next()){
				record_id = Integer.parseInt(rs1.getString("id"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return record_id;
	}
	
	public static int insertGpsrecord(int sensor_id, String time,
			float longitude, float latitude, int record_id) {
		//插入GPS传感器记�?
		String sql = "insert into gps_record(sensor_id,time,longitude,latitude,record_id) values ("+sensor_id+",'"+time+"',"+longitude+","+latitude+","+record_id+")";
		int i = SqlOperator01.excuteUpdate(sql);
		//close();
		if(i>0){
			return i;
		}
		return -1;
	}
	
	public static int updateCarGps(int car_id, float longitude, float latitude){
		//更新car表中的经纬度字段，即更新车的位置信息
		String sql = "update car set longitude = "+longitude+" and latitude = "+latitude+" where id = "+car_id+"";
		int i = SqlOperator01.excuteUpdate(sql);
		if(i>0){
			return i;
		}
		return -1;
	}
	
	
	/**
	 * 超声波传感器部分，site方面
	 * 
	 * */
	public static int searchSiteid(String serial_number){
		//根据传感器标识号查询site_id
		int site_id = 0;
		String sql = "select site_id from sensor where serial_number = '"+serial_number+"'";
		ResultSet rs1 = SqlOperator01.excuteQuery(sql);
		try {
			if(rs1.next()){
			site_id = Integer.parseInt(rs1.getString("site_id"));
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return site_id;
	}
	
	public static int searchSiteStatus(int site_id){
		//根据site_id查询污泥处理厂的状�??
		int status = 0;
		String sql = "select status FROM site where id = '"+site_id+"'";
		ResultSet rs1 = SqlOperator01.excuteQuery(sql);
		try {
			if(rs1.next()){
			status = Integer.parseInt(rs1.getString("status"));
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close();
		}
		return status;
	}
	
	public static void updateSiteSis(int site_id, int sensor_id){
		String sql = "update site set sensor_id_set = "+sensor_id+" where id = "+site_id+"";
		SqlOperator01.excuteUpdate(sql);
	}
	
	public static int insertUltrasonicrecord(int sensor_id, String time, float value){
		//插入超声笔传感器记录
		String sql = "insert into ultrasonic_record(sensor_id,time,value) values ("+sensor_id+",'"+time+"',"+value+")";
		int i = SqlOperator01.excuteUpdate(sql);
		if(i>0){
			return i;
		}
		return -1;
		
	}
	/*public static String searchDepth(String site_id) throws Exception{
		String depth = null;
		String sql = "select depth FROM site where id=?";
		PreparedStatement sta = conn.prepareStatement(sql);
		sta.setString(1,site_id)
		ResultSet rs1 = sta.executeQuery();
		if(rs1.next()){
			depth = rs1.getString("depth");
		}
		return depth;
	}*/
	public static int insertRecord(String allocation_time, int site_id, int status){
		String sql = "insert into record(allocation_time,site_id,status) values ('"+allocation_time+"',"+site_id+","+status+")";
		int i = SqlOperator01.excuteUpdate(sql);
		if(i>0){
			return i;
		}
		return -1;
		/*String sql = "insert into record(allocation_time,site_id,status) values (?,?,?)";
		PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		pstmt.setString(1,allocation_time);
		pstmt.setInt(2,site_id);
		pstmt.setInt(3,status);
		pstmt.executeUpdate();
		ResultSet rs = (ResultSet) pstmt.getGeneratedKeys();
		if(rs.next()){
			record_id = rs.getInt(1);
		}
		return record_id;*/
	}
	
	public static int updateDisposal_time(int site_id, String disposal_time, int status){
		//site_id作为条件参数，更新相应的处理时间
		int i = 0;
		String sql = "update record set disposal_time = '"+disposal_time+"' , status = "+status+" where site_id = "+site_id+" and disposal_time is null and finish_time is null";
//		String sql = "update record set disposal_time = '"+disposal_time+"' where site_id = "+site_id+" and disposal_time is null and finish_time is null";
		i = SqlOperator01.excuteUpdate(sql);
		if(i>0){
			return i;
		}
		return -1;
	}
	
	/*
	 * record表中更新disposal_time和finish_time
	 * */
	public static int updateFinish_time(int site_id, String finish_time, int status){
		//site_id作为条件参数，更新相应的处理时间
		int i = 0;
		int record_id = 0;
		//int car_id = 0;
		String sql = "select id from record where site_id = "+site_id+" and finish_time is null";
		ResultSet rs1 = SqlOperator01.excuteQuery(sql);
		try {
			if(rs1.next()){
				record_id = rs1.getInt("id");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String sql01 = "update record set finish_time = '"+finish_time+"' , status = "+status+" where id = "+record_id+"";
		i = SqlOperator01.excuteUpdate(sql01);
		return record_id;
	}
	
	public static int insertSludge(String produce_time, int record_id){
		int i;
		String sql = "insert into sludge(produce_time,record_id) values ('"+produce_time+"', "+record_id+")";
		i = SqlOperator01.excuteUpdate(sql);
		if(i>0){
			return i;
		}
		return -1;
	}
	
	public static int updateSiteStatus(int site_id, int status){
		//site_id作为条件参数，跟新site表中的status
		int i = 0;
		String sql = "update site set status = "+status+" where id = "+site_id+"";
		i = SqlOperator01.excuteUpdate(sql);
		if(i>0){
			return i;
		}
		return i;
	}
	
	public static int searchCarid(int record_id){
		int car_id = 0;
		String sql = "select car_id from record where id = "+record_id+"";
		ResultSet rs1 = SqlOperator01.excuteQuery(sql);
		try {
			if(rs1.next()){
				car_id = Integer.parseInt(rs1.getString("car_id"));
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return car_id;
	}
	
	public static void updateCarstatus(int car_id, int status){
		String sql = "update car set status = "+status+",site_id = null where id = "+car_id+"";
		SqlOperator01.excuteUpdate(sql);
	}
	
	public static void updateSVR(int sensor_id, String value){
		String sql = "update sensor_value_realtime set value = '"+value+"' where sensor_id = "+sensor_id+"";
		SqlOperator01.excuteUpdate(sql);
	}
	
}
