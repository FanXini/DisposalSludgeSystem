package factory.service;

import java.util.List;
import factory.entity.Role_authority;

public interface Role_authorityService {
	/**
	 * 
	 * @author:刘见宇
	 * @data:2018年6月11日
	 * @time:下午21:24:51 
	 * @param username
	 * @return
	 * @description:查询用户的role_id
	 */
	public List<Integer> queryAllRole_authority(int  role_id);
}
