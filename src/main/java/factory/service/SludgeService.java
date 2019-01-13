package factory.service;

import factory.entity.Sludge;
import factory.entity.SludgeFunction;

import java.util.List;
import java.util.Map;

public interface SludgeService {
	
	public List<SludgeFunction> queryAllSludgeFunction();
	
	public List<Sludge> queryAllSludge(int inOutflag);
	
	public void deleteSludge(int sludgeId);
	
	public void editSludge(Sludge sludge);
	
	public List<Sludge> querySludgeBySiteId(int siteId);
	
	public List<Sludge> querySludgeBySiteIdAndFlag(int siteId,int inOuTflag);

	public List<Sludge> querySludgeByDriverId(int driverId);
	
	public List<Sludge> querySludgeByDriverIdAndInOutFlag(int driverId,int inOutFlag);
	
	public List<Sludge> querySludgeByDateAndInOutFlag(String startDate,String endDate,int inOutFlag);
	
	public List<Sludge> queryAllSludgeOfOneFactory(int siteId);
	
	public List<Sludge> querySludgeByDriverIdOfOneFacotry(Map<String, Integer> condition);
	
	public List<Sludge>querySludegByDateOfOneFactory(Map<String, Object> condition);
	
	public List<Sludge> querySludgeByDates(String startDate,String endDate, int siteId);
	
	public List<Sludge> querySludgeBySiteName(String siteName);
}
