package factory.tcpnet;

import java.net.ServerSocket;
import java.net.Socket;
import java.security.Provider.Service;

import javax.servlet.ServletConfig;

import javax.servlet.http.HttpServlet;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.XmlWebApplicationContext;

import factory.dao.SensorDao;
import factory.service.SensorService;
import factory.service.UserService;
/**
 * 配置spring和junit整合，junit启动时加载springIOC容器 spring-test,junit
 */
@RunWith(SpringJUnit4ClassRunner.class)
// 告诉junit spring配置文件
@ContextConfiguration({ "classpath:spring/spring-dao.xml", "classpath:spring/spring-service.xml" })
public class Server  {

	@Autowired
	private SensorDao sensorDao;
	@Test
	public void run() {
		System.out.println(sensorDao);
		try {
			int port = 8088;
			@SuppressWarnings("resource")
			ServerSocket server = new ServerSocket(port);
			while (true) {
				System.out.println("等待连接");
				Socket socket = server.accept();
				System.out.println("取得连接" + socket.getInetAddress());
				new Thread(new SocketThread(socket, sensorDao)).start();
			}

		} catch (Exception e) {
			// TODO: handle exception
		}
	}

}
