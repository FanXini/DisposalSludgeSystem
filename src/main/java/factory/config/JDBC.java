package factory.config;
@SuppressWarnings("unused")
public class JDBC {
	
	public static final String DRIVERCLASS="com.mysql.jdbc.Driver";
	
	public static final String URL="jdbc:mysql://119.23.29.190/disposalsludgesystem?useUnicode=true&characterEncoding=utf8";
	
	public static final String USERNAME="fanxin";
	
	public static final String PASSWORD="123456";
	
	 /*c3p0连接池的私有属性 */
	/*最大连接线程数*/
	public static final int MAXPOOLSIZE=30;
	/*最小保持连接线程数*/
	public static final int MINPOOLSIZE=10;
	// 最大空闲时间,7200秒内未使用则连接被丢弃。若为0则永不丢弃。Default: 0
	public static final int MAXIDLETIME=7200;
	//连接池在无空闲连接可用时一次性创建的新数据库连接数
	public static final int ACQUIREINCREMENT=3;
	//JDBC的标准参数，用以控制数据源内加载d的PreparedStatements数量
	public static final int MAXSTATEMENTS=1000;
	//预连接池线程数量
	public static final int INITIALPOOLSIZE=10;
	/*关闭连接后不自动commit*/
	public static final boolean AUTOCOMMITONCLOSE=false;
	/*获取连接超时时间*/
	public static final int CHECKOUTTIMEOUT=10000;
	/*当获取连接失败重试次数*/
	public static final int ACQUIRERETRYATTEMPTS=30;
	
	
	
}
