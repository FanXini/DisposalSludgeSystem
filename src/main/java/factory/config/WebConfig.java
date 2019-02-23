package factory.config;

import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Import;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import factory.controller.UserController;
import factory.serviceimpl.UserServiceImpl;


@SuppressWarnings("deprecation")
@Configurable
/*开启事务支持 等同于xml配置方式的 <tx:annotation-driven />*/
@EnableTransactionManagement
/*启动spring mvc功能*/
@EnableWebMvc
//扫描这controller和serviceimpl两个包
@ComponentScan(basePackageClasses= {UserController.class,UserServiceImpl.class})
public class WebConfig extends WebMvcConfigurerAdapter{
	@Bean
	public ViewResolver viewResolver() { //配置JSP视图解析
		InternalResourceViewResolver resolver=new InternalResourceViewResolver();
		resolver.setPrefix("/WEB-INF/jsp/");
		resolver.setSuffix(".jsp");
		resolver.setExposeContextBeansAsAttributes(true);
		return resolver;
	}
	@Override     //配置静态资源的处理
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}

}
