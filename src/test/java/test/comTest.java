package test;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import factory.entity.Sensor;

public class comTest {

	public static void main(String args[]){
		Sensor sensor=new Sensor();
		Sensor sensor2=new Sensor();
		sensor.setSerialNumber("2");
		sensor2.setSerialNumber("1");
		List<Sensor> sensors=new ArrayList<Sensor>();
		sensors.add(sensor);
		sensors.add(sensor2);
		Collections.sort(sensors,new Comparator
			    <Sensor>
			    (){
			      public int compare(Sensor arg0, Sensor arg1) {
			        return arg0.getSerialNumber().compareTo(arg1.getSerialNumber());
			      }
			    });
		for(Sensor sensor3:sensors){
			System.out.println(sensor3.getSerialNumber());
		}
	}

}
