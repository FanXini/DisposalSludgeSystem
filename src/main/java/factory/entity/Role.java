package factory.entity;

public class Role {
	private Integer id;
	private String role_name;
	private String description;
	private Integer del_status;
	
	public Integer getId(){
		return id;
	}
	public void setId(Integer id){
		this.id = id;
	}
	
	public String getRole_name(){
		return role_name;
	}
	public void setRole_name(String role_name){
		this.role_name = role_name;
	}
	
	public String getdescription(){
		return  description;
	}
	public void setdescription(String description){
		this.description = description;
	}
	
	public int setdel_status(){
		return del_status;
	}
	public void getdel_status(Integer del_status){
		this.del_status =del_status;
	}
}
