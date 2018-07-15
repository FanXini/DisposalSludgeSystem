package test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.mysql.fabric.xmlrpc.base.Array;

public class temp {

	public static void main(String args[]) {
		String aString = "1,2,3";
		String haha[]=aString.split(",");
		
		if(haha[0].equals("")){
			System.out.println("haha");
		}
		/*aString+="2";
		System.out.println(aString.length());
		System.out.println("***************888");*/
		/*for(String string:haha){
			System.out.println(string);
		}*/
		//addsensorIdtoSensorSet(aString,2);
		deleteSensorIdOfSensorIdSet(aString, 1);
		
	}
	
	public static void  addsensorIdtoSensorSet(String sensorIdSet,int sensorId){
		String senserIdArray[]=sensorIdSet.split(",");
		System.out.println(senserIdArray.length);
		int size=senserIdArray.length;
		if(size==1 &&senserIdArray[0]==""){
			sensorIdSet+=String.valueOf(sensorId);
		}
		else{
			sensorIdSet+=","+String.valueOf(sensorId);
		}
		System.out.println("½á¹û"+sensorIdSet);
		String temp[]=sensorIdSet.split(",");
		System.out.println(temp.length);
		
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
