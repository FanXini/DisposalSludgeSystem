package factory.dao;

import factory.entity.Charge;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ChargeDao {

	public List<Charge> queryAllCharge();
	
	public List<Charge> queryChargeBySiteName(@Param("siteName") String siteName);
	
	public List<Charge> queryChargeByDate(@Param("startDate") String startDate, @Param("endDate") String endDate);

}
