package factory.tcpnet;

import java.net.ServerSocket;
import java.net.Socket;
import java.security.Provider.Service;

import javax.servlet.ServletConfig;

import javax.servlet.http.HttpServlet;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Component;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.context.ServletConfigAware;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.XmlWebApplicationContext;

import factory.dao.SensorDao;
import factory.service.SensorService;
import factory.service.UserService;
/**
 * 配置spring和junit整合，junit启动时加载springIOC容器 spring-test,junit
 */
@Component
public class Server implements InitializingBean,ServletConfigAware{
	
	@Autowired
	private ThreadPoolTaskExecutor taskExecuter;

	@Autowired
	private SensorDao sensorDao;
	@Override
	public void setServletConfig(ServletConfig arg0) {
		taskExecuter.submit(new ServerThread());
	}
	@Override
	public void afterPropertiesSet() throws Exception {
	}
	
	class ServerThread implements Runnable{

		@Override
		public void run() {
			try {
				int port = 8088;
				@SuppressWarnings("resource")
				ServerSocket server = new ServerSocket(port);
				while (true) {
					System.out.println("等待连接");
					Socket socket = server.accept();
					System.out.println("取得连接" + socket.getInetAddress());
					taskExecuter.submit(new SocketThread(socket, sensorDao));
				}

			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		
	}
	
		

}
