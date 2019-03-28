/*package factory.util;

import java.util.HashMap;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

public class RecordCache {

	private  volatile  ConcurrentHashMap<Integer, HashMap<String, List<Integer>>> recordCache;
	
	public ConcurrentHashMap getRecordCache() {
		if(recordCache==null) {
			synchronized (RecordCache.class) {
				if(recordCache==null) {
					recordCache=new ConcurrentHashMap<>();
				}
			}
		}
	}
}
*/