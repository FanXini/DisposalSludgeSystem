package factory.entity;

public class Role_authority {
    private Integer id;
	private Integer role_id;
	private Integer authority_id;
	
	public Integer getId(){
		return id;
	}
	public void setId(Integer id){
		this.id = id;
	}
	
	public Integer getRole_id(){
		return role_id;
	}
	public void setRole_id(Integer role_id){
		this.role_id = role_id;
	}
	
	public Integer getAuthority_id(){
		return authority_id;
	}
	public void setAuthority_id(Integer authority_id){
		this.authority_id = authority_id;
	}
	/*//存放权限关联表的数据
	public String toString(){
		return "Role_authority [id=" + id + ", role_id=" + role_id + ", authority_id=" + authority_id + "]";
	}*/
}
