package factory.tcpnet;

import java.io.BufferedWriter;
import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;

import org.springframework.stereotype.Component;

@Component
public class RunMain {

	public RunMain() {
		System.out.println("hahaehahahaa");
    	Path s = Paths.get("F:\\test.txt");
		Charset charset = Charset.forName("UTF-8");
		char chars[] = new char[2];
		chars[0] = 'a';
		chars[1] = 'b';
		try (BufferedWriter oStream = Files.newBufferedWriter(s, charset, StandardOpenOption.APPEND);
				PrintWriter writer = new PrintWriter(oStream)) {
			writer.println(chars);
		} catch (Exception e) {
			// TODO: handle exception
		}
		try {
			Class clazz;
			clazz = Class.forName("facotry.tcpnet.Server");
			Object obj = clazz.newInstance();
			Method mainMethod = clazz.getMethod("main", String[].class);
			// public static void main(String[] args)
			mainMethod.invoke(obj, (Object) new String[] { "a", "b", "c" }); // String[]随便赋值的
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
