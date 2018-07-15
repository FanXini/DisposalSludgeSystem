package factory.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import factory.dao.RoleDao;
import factory.entity.Role;
import factory.service.RoleService;

@Service
public class RoleServicelmpl implements RoleService{
	@Autowired
	private RoleDao roleDao;
	@Override
	public List<Role> queryAllRole(int id) {
		/*
		 * 遍历role表的所有内容
		 */
		return roleDao.queryAllRole(id);
	}
	
}
