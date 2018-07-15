package factory.dao;

import java.util.List;

import factory.entity.Role;

public interface RoleDao {
	public List<Role> queryAllRole(int id);
}
