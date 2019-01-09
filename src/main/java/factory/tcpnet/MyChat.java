package factory.tcpnet;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;


public class MyChat 
{
	public static void main(String[] args) throws IOException 
	{
		ServerSocket server = null;
		try {
			server = new ServerSocket(8080);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("我是服务器，等待客户端连�?...");
		Socket ssoc = null;
		String sendStr = "你好，我是服务器�?";
		while(true){
		ssoc = server.accept();

		//读取客户端的请求信息
		InputStream in = ssoc.getInputStream();
		DataInputStream din = new DataInputStream(in);
		String receiveStr = null;
		byte[] rBuf = new byte[1024];
		din.read(rBuf);
		receiveStr = new String(rBuf,0,rBuf.length);
		System.out.println("我是服务器，客户端请求的信息�?"+receiveStr);

		//响应客户端的请求
		OutputStream out = ssoc.getOutputStream();
		DataOutputStream dout = new DataOutputStream(out);

		byte[] buf = sendStr.getBytes();
		out.write(buf);

		//关闭资源
		out.close();
		in.close();
		ssoc.close();

		}
	}
}
