package factory.serviceimpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import factory.dao.MudWareHouseDao;
import factory.entity.MudWareHouse;
import factory.service.MudWareHouseService;
@Service
public class MudWareHouseServiceImpl implements MudWareHouseService{

	@Autowired 
	private MudWareHouseDao mudWareHouseDao;
	@Override
	public MudWareHouse queryWareHouse() {
		return mudWareHouseDao.queryWareHouse();
	}

}
