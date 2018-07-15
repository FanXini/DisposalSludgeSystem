package factory.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import factory.dao.Role_authorityDao;
import factory.entity.Role_authority;
import factory.service.Role_authorityService;

@Service
public class Role_authorityServicelmpl implements Role_authorityService{
	@Autowired
	private Role_authorityDao role_authorityDao;
	@Override
	public List<Integer> queryAllRole_authority(int  role_id){
		
		return role_authorityDao.queryAllRole_authority(role_id);
	}
}