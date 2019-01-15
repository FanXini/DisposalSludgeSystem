package factory.dao;

import java.util.List;

import factory.entity.MainMudWareHouse;
import factory.entity.MinorMudWareHouse;

public interface MudWareHouseDao {

	public List<MinorMudWareHouse> queryMinorWareHouse();
	
	public List<MainMudWareHouse> queryMainWareHouse();
}
