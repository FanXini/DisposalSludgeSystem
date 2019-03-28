package factory.config;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.concurrent.ThreadPoolExecutor;

import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.context.annotation.FilterType;
import org.springframework.context.annotation.Import;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

@Configurable
@Import({DaoConfig.class,RedisConfig.class})
@ComponentScan(excludeFilters= {@Filter(type=FilterType.ANNOTATION,value=EnableWebMvc.class)})
public class RootConfig {
	
	@Bean
	public MultipartResolver multipartResolver() {
		return new StandardServletMultipartResolver();
	}
	
	@Bean 
	public DateFormat getDateFormate() {
		return new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	}
	
	@Bean
	public ThreadPoolTaskExecutor getTastExecutor() {
		ThreadPoolTaskExecutor taskExecutor=new ThreadPoolTaskExecutor();
		taskExecutor.setCorePoolSize(10);
		taskExecutor.setKeepAliveSeconds(1);
		taskExecutor.setMaxPoolSize(100);
		taskExecutor.setQueueCapacity(200);
		taskExecutor.setRejectedExecutionHandler(new ThreadPoolExecutor.CallerRunsPolicy());
		return taskExecutor;
	}
	
}
