package test;

import org.junit.Test;

public class splidt {

	public static void main(String args[]) {
			String teString="123;123;123;";
			String data[]=teString.split(";");
			for(int i=0;i<data.length;i++) {
				System.out.println(data[i]);
			}
		
	}
}
