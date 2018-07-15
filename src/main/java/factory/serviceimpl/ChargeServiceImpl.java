package factory.serviceimpl;

import factory.dao.ChargeDao;
import factory.entity.Charge;
import factory.service.ChargeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ChargeServiceImpl implements ChargeService{
	@Autowired
	private ChargeDao chargeDao;
	
	/**
	 *
	 */
	@Override
	public List<Charge> queryAllCharge() {
		// TODO Auto-generated method stub
		return chargeDao.queryAllCharge();
	}
	/**
	 *
	 */
	@Override
	public List<Charge> queryChargeBySiteName(String siteName) {
		// TODO Auto-generated method stub
		return chargeDao.queryChargeBySiteName(siteName);
	}

	/**
	 *
	 */
	@Override
	public List<Charge> queryChargeByDate(String startDate, String endDate) {
		// TODO Auto-generated method stub
		return chargeDao.queryChargeByDate(startDate, endDate);
	}
}
