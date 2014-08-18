import java.lang.System;
import java.lang.Exception;
import java.lang.Thread;

public class hello {
        public  hello() {
		System.out.println("constructor");
	}
	
	public static  void main(String[] args){
		System.out.println("Hello world!");

			System.out.println("exit? (Y/N)");
			String cmd = System.console().readLine();
		while(!cmd.equalsIgnoreCase("y")){
			try{
				Thread.sleep(1000);
			}catch(Exception e){
				e.printStackTrace();
			}
			cmd = System.console().readLine();
		}
	}
}
