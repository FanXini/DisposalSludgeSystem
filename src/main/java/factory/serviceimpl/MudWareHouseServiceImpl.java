package factory.serviceimpl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import factory.dao.MudWareHouseDao;
import factory.entity.MainMudWareHouse;
import factory.entity.MinorMudWareHouse;
import factory.service.MudWareHouseService;
@Service
public class MudWareHouseServiceImpl implements MudWareHouseService{

	@Autowired 
	private MudWareHouseDao mudWareHouseDao;
	@Override
	public List<MinorMudWareHouse> queryMinorWareHouse() {
		List<MinorMudWareHouse> minorMudWareHouselist=new ArrayList<>();
		minorMudWareHouselist.addAll(mudWareHouseDao.queryMinorWareHouse());
		return minorMudWareHouselist;
	}
	@Override
	public List<MainMudWareHouse> queryMainWareHouse() {
		// TODO Auto-generated method stub
		List<MainMudWareHouse> mainMudWareHouselist=new ArrayList<>();
		mainMudWareHouselist.addAll(mudWareHouseDao.queryMainWareHouse());
		return mainMudWareHouselist;
	}
}
