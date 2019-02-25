package factory.config;
@SuppressWarnings("unused")
public class JDBC {
	
	public static final String DRIVERCLASS="com.mysql.jdbc.Driver";
	
	public static final String URL="jdbc:mysql://kaihuoguodian.xin/disposalsludgesystem?useUnicode=true&characterEncoding=utf8";
	
	public static final String USERNAME="root";
	
	public static final String PASSWORD="123456";
	
	 /*c3p0连接池的私有属性 */
	/*最大连接线程数*/
	public static final int MAXPOOLSIZE=30;
	/*最小保持连接线程数*/
	public static final int MINPOOLSIZE=10;
	/*关闭连接后不自动commit*/
	public static final boolean AUTOCOMMITONCLOSE=false;
	/*获取连接超时时间*/
	public static final int CHECKOUTTIMEOUT=10000;
	/*当获取连接失败重试次数*/
	public static final int ACQUIRERETRYATTEMPTS=2;
	
	
	
}
