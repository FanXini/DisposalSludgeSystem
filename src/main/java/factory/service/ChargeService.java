package factory.service;

import factory.entity.Charge;

import java.util.List;

public interface ChargeService {
	
	public List<Charge> queryAllCharge();
	
	public List<Charge> queryChargeBySiteName(String siteName);
	
	public List<Charge> queryChargeByDate(String startDate, String endDate);

}
