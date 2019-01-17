package factory.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import factory.entity.MainMudWareHouse;
import factory.entity.MinorMudWareHouse;

public interface MudWareHouseDao {

	public List<MinorMudWareHouse> queryMinorWareHouse();
	
	public List<MainMudWareHouse> queryMainWareHouse();
	
	public MinorMudWareHouse queryMinorMudWareHouseById(@Param("id") int id);
}
