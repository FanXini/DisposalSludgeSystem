package factory.service;

import factory.entity.Sludge;
import factory.entity.SludgeFunction;

import java.util.List;
import java.util.Map;

public interface SludgeService {
	
	public List<SludgeFunction> queryAllSludgeFunction();
	
	public List<Sludge> queryAllSludgeByInOutFlagWithMinorWareHouseId(int inOutflag,int minorWareHouseId);
	
	public void deleteSludge(int sludgeId);
	
	public void editSludge(Sludge sludge);
	
	public List<Sludge> querySludgeBySiteId(int siteId);
	
	public List<Sludge> querySludgeBySiteIdAndInOutFlagWithMinorWareHouseId(int siteId,int inOuTflag,int minorWareHouseId);

	public List<Sludge> querySludgeByDriverId(int driverId);
	
	public List<Sludge> querySludgeByDriverIdAndInOutFlagWithMinorWareHouseId(int driverId,int inOutFlag,int minorWareHouseId);
	
	public List<Sludge> querySludgeByDateAndInOutFlagWithMinorWareHouseId(String startDate,String endDate,int inOutFlag,int minorWareHouseId);
	
	public List<Sludge> queryAllSludgeOfOneFactory(int siteId);
	
	public List<Sludge> querySludgeByDriverIdOfOneFacotry(Map<String, Integer> condition);
	
	public List<Sludge>querySludegByDateOfOneFactory(Map<String, Object> condition);
	
	public List<Sludge> querySludgeByDates(String startDate,String endDate, int siteId);
	
	public List<Sludge> querySludgeBySiteName(String siteName);
}
