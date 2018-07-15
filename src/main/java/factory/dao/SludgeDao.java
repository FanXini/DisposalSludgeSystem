package factory.dao;

import factory.entity.Sludge;
import factory.entity.SludgeFunction;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SludgeDao {

	public List<SludgeFunction> queryAllSludgeFunction();

	public List<Sludge> queryAllSludge();

	/*public List<Sludge> queryAllSludgeNotAssignFunc();*/

	public void deleteSludge(@Param("sludgeId") int sludgeId);

	public void editSludge(Sludge sludge);

	public List<Sludge> querySludgeBySiteId(@Param("siteId") int siteId);

	/*public List<Sludge> querySludgeNotAssignFuncBySiteId(@Param("siteId") int siteId);*/

	public List<Sludge> querySludgeByDriverId(@Param("driverId") int driverId);

	/*public List<Sludge> querySludgeNotAssignFuncByDriverId(@Param("driverId") int driverId);*/
	
	public List<Sludge> querySludegAssignFuncByDate(@Param("startDate") String startDate,@Param("endDate") String endDate);
	
	public List<Sludge> querySludegNotAssignFuncByDate(@Param("startDate") String startDate,@Param("endDate") String endDate);
	
	public List<Sludge> queryAllSludgeOfOneFactory(@Param("siteId") int siteId);
	
	public List<Sludge>querySludgeByDriverIdOfOneFacotry(@Param("driverId") int driverId,@Param("siteId") int siteId);
	
	public List<Sludge>querySludegByDateOfOneFactory(@Param("siteId") int siteId,@Param("startDate") String startDate,@Param("endDate") String endDate);

	public List<Sludge> querySludgeByDates(@Param("startDate") String startDate,@Param("endDate") String endDate,@Param("siteId") int siteId);

	public List<Sludge> querySludgeBySiteName(@Param("siteName") String siteName);
	
	public SludgeFunction querySludgeFunctionByFunction(@Param("function") String function);
	
	public void addSludgeFunction(SludgeFunction function);

}
