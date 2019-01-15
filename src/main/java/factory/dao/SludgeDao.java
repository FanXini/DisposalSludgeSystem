package factory.dao;

import factory.entity.Sludge;
import factory.entity.SludgeFunction;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SludgeDao {

	public List<SludgeFunction> queryAllSludgeFunction();

	public List<Sludge> queryAllSludgeByInOutFlagWithMinorWareHouseId(@Param("inOutFlag") int inOutFlag,@Param("minorWareHouseId") int minorWareHouseId);

	/*public List<Sludge> queryAllSludgeNotAssignFunc();*/
	
	public void addOutMudWareHouseSludgeRecord(Sludge sludge);
	
	public void addSludge(Sludge sludge);

	public void deleteSludge(@Param("sludgeId") int sludgeId);

	public void editSludge(Sludge sludge);

	public List<Sludge> querySludgeBySiteId(@Param("siteId") int siteId);
	
	public List<Sludge> querySludgeBySiteIdAndInOutFlagWithMinorWareHouseId(@Param("siteId") int siteId,@Param("inOutFlag") int inOutFlag,@Param("minorWareHouseId") int minorWareHouseId);
	
	/*public List<Sludge> querySludgeNotAssignFuncBySiteId(@Param("siteId") int siteId);*/

	public List<Sludge> querySludgeByDriverId(@Param("driverId") int driverId);

	public List<Sludge> querySludgeByDriverIdAndInOutFlagWithMinorWareHouseId(@Param("driverId") int driverId,@Param("inOutFlag") int inOutFlag,@Param("minorWareHouseId") int minorWareHouseId);

	/*public List<Sludge> querySludgeNotAssignFuncByDriverId(@Param("driverId") int driverId);*/
	
	public List<Sludge> querySludgeByDateAndInOutFlagWithMinorWareHouseId(@Param("startDate") String startDate,@Param("endDate") String endDate,@Param("inOutFlag") int inOutFlag,@Param("minorWareHouseId") int minorWareHouseId);
	
	public List<Sludge> querySludgeByDate(@Param("startDate") String startDate,@Param("endDate") String endDate);
	
	//public List<Sludge> querySludegNotAssignFuncByDate(@Param("startDate") String startDate,@Param("endDate") String endDate);
	
	public List<Sludge> queryAllSludgeOfOneFactory(@Param("siteId") int siteId);
	
	public List<Sludge>querySludgeByDriverIdOfOneFacotry(@Param("driverId") int driverId,@Param("siteId") int siteId);
	
	public List<Sludge>querySludegByDateOfOneFactory(@Param("siteId") int siteId,@Param("startDate") String startDate,@Param("endDate") String endDate);

	public List<Sludge> querySludgeByDates(@Param("startDate") String startDate,@Param("endDate") String endDate,@Param("siteId") int siteId);

	public List<Sludge> querySludgeBySiteName(@Param("siteName") String siteName);
	
	public SludgeFunction querySludgeFunctionByFunction(@Param("function") String function);
	
	public void addSludgeFunction(SludgeFunction function);
	
public List<Sludge> transportsludgeofonedriver(@Param("driverId") int driverId);
	
	public void insertSludgeByDriver(Sludge sludge);
	
	public Sludge querysludgebydriverIdAndStatus(@Param("driverId") int driverId);
	
	public List<Sludge> fussyQuerysludgebyTransDriver(@Param("condition") String condition,@Param("driverId") int driverId);

}
