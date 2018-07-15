package factory.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Util {

	//Ìí¼Ó´«¸ÐÆ÷id
		public static  String  addsensorIdtoSensorSet(String sensorIdSet,int sensorId){
			if(sensorIdSet==null){
				sensorIdSet="";
			}
			if(sensorIdSet==""){
				sensorIdSet+=String.valueOf(sensorId);
			}
			else{
				sensorIdSet+=","+String.valueOf(sensorId);
			}
			return sensorIdSet;		
		}
		
		public static String deleteSensorIdOfSensorIdSet(String sensorIdSet,int sensorId){
			List<String> temp=Arrays.asList(sensorIdSet.split(","));
			List<String> sensorIdLists=new ArrayList<String>(temp);
			if(sensorIdLists.contains(String.valueOf(sensorId))){
				sensorIdLists.remove(String.valueOf(sensorId));
				String newSensorIdSet="";
				if(sensorIdLists.size()>0){
					for(String id:sensorIdLists){
						newSensorIdSet+=id+",";
					}
					newSensorIdSet=newSensorIdSet.substring(0,newSensorIdSet.length()-1);
				}
				System.out.println(newSensorIdSet);
				return newSensorIdSet;
			}
			else{
				return sensorIdSet;
			}
		}

}
