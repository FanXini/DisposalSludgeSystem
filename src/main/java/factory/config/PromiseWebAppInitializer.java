package factory.config;

import javax.servlet.MultipartConfigElement;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class PromiseWebAppInitializer extends AbstractAnnotationConfigDispatcherServletInitializer{

	@Override
	protected Class<?>[] getRootConfigClasses() {
		return new Class[] {RootConfig.class};
		//return null;
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		return new Class[] {WebConfig.class};
	}

	@Override
	protected String[] getServletMappings() {
		return new String[] {"/"};    //将DispatcherServlet映射到"/"
	}
	
	@Override
	protected void customizeRegistration(javax.servlet.ServletRegistration.Dynamic registration) {
		registration.setMultipartConfig(new MultipartConfigElement("/home/tomcat/webapps/promise/temp",10485760,20971520,0));
		//registration.setMultipartConfig(new MultipartConfigElement("F:\\WebProjectWorkspace\\promise\\src\\main\\webapp\\temp",10485760,20971520,0));
	}

	

}
