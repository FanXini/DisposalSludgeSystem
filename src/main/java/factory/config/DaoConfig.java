package factory.config;

import java.beans.PropertyVetoException;
import java.io.IOException;

import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.mapper.MapperScannerConfigurer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

import com.mchange.v2.c3p0.ComboPooledDataSource;

@Configuration
public class DaoConfig {

	@Bean
	public ComboPooledDataSource getComboPooledDataSource() throws PropertyVetoException {
		ComboPooledDataSource pool=new ComboPooledDataSource();
		pool.setDriverClass(JDBC.DRIVERCLASS);
		pool.setJdbcUrl(JDBC.URL);
		pool.setUser(JDBC.USERNAME);
		pool.setPassword(JDBC.PASSWORD);
		pool.setMaxPoolSize(JDBC.MAXPOOLSIZE);
		pool.setMinPoolSize(JDBC.MINPOOLSIZE);
		pool.setAutoCommitOnClose(JDBC.AUTOCOMMITONCLOSE);
		pool.setCheckoutTimeout(JDBC.CHECKOUTTIMEOUT);
		pool.setAcquireRetryAttempts(JDBC.ACQUIRERETRYATTEMPTS);
		return pool;
	}
	
	@Bean
	public DataSourceTransactionManager getTransactionManager(ComboPooledDataSource jdbcDataSource) {
		DataSourceTransactionManager dataSourceTransactionManager=new DataSourceTransactionManager();
		dataSourceTransactionManager.setDataSource(jdbcDataSource);
		return dataSourceTransactionManager;
	}
	
	@Bean(name="sqlSessionFactory")
	public SqlSessionFactoryBean getSqlSessionFactoryBean(ComboPooledDataSource jdbcDataSource) throws IOException {
		SqlSessionFactoryBean factoryBean=new SqlSessionFactoryBean();
		//注入数据库连接池
		factoryBean.setDataSource(jdbcDataSource);
		//配置MyBaties全局配置文件:mybatis-config.xml
		factoryBean.setConfigLocation(new ClassPathResource("mybatis-config.xml"));
		//扫描entity使用别名
		factoryBean.setTypeAliasesPackage("factory.entity");
		//扫描sql配置文件:mapper需要的要的xml文件
		Resource[] resources=new PathMatchingResourcePatternResolver().getResources("classpath:mapper/*.xml");
		//factoryBean.setMapperLocations(new ClassPathResource[] {new ClassPathResource("mapper/EventDao.xml"),new ClassPathResource("mapper/ImageDao.xml")});
		factoryBean.setMapperLocations(resources);
		return factoryBean;
	}
	
	@Bean
	public MapperScannerConfigurer getMapperScannerConfigurer(SqlSessionFactoryBean factoryBean) {
		MapperScannerConfigurer mapperScannerConfigurer=new MapperScannerConfigurer();
		//注入sqlSessionFactory
		mapperScannerConfigurer.setSqlSessionFactoryBeanName("sqlSessionFactory");
		//给出要扫描的Dao接口
		mapperScannerConfigurer.setBasePackage("factory.dao");
		return mapperScannerConfigurer;
	}
}

