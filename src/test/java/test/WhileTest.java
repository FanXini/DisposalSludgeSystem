package test;

public class WhileTest {

	public static void main(String agrs[]) {
		int i=0;
		while(true) {
			i++;
			if(i>10) {
				break;
			}
			if(i>4&&i<8) {
				continue;
			}
			System.out.println(i);
		}
	}
	
}
