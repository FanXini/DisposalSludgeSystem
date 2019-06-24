package test;
 
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.ContextLoaderListener;

import factory.dao.CarDao;
import factory.entity.Car;
 
public class TEST extends BaseTest{
	
	@Autowired
	private static CarDao CarDao;
	public static class Tasker implements Callable<Car>{
 
		@Override
		public Car call() throws Exception {
			return CarDao.queryCarByDriverId(3);
		}
		
	}
 
	@Test
	public static void main(String[] args) throws InterruptedException, ExecutionException {
		ExecutorService threadPool = Executors.newFixedThreadPool(3);
		//List<Future<String>> futures = new ArrayList<Future<String>>();
		Future<Car> res = null;
			res = threadPool.submit(new Tasker());
			//futures.add(res);
		/*for(Future<String> future:futures){
			System.out.println(future.get());
		}*/
			System.out.println(res.get());
			//ContextLoaderListener
	}

}
