package factory.config;

import java.util.concurrent.ThreadPoolExecutor;

import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Import;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import factory.controller.UserController;
import factory.serviceimpl.UserServiceImpl;

@Configurable
@Import({RedisConfig.class,DaoConfig.class})
@ComponentScan(basePackageClasses= {UserServiceImpl.class})
public class TestConfig {
	
	@Bean
	public ThreadPoolTaskExecutor getTastExecutor() {
		ThreadPoolTaskExecutor taskExecutor=new ThreadPoolTaskExecutor();
		taskExecutor.setCorePoolSize(5);
		taskExecutor.setKeepAliveSeconds(200);
		taskExecutor.setMaxPoolSize(10);
		taskExecutor.setQueueCapacity(20);
		taskExecutor.setRejectedExecutionHandler(new ThreadPoolExecutor.CallerRunsPolicy());
		return taskExecutor;
	}

}
