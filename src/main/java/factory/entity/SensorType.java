package factory.entity;

import java.io.Serializable;

public class SensorType implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -3131139130609175100L;
	private int id;
	private String type;
	private String description;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getType() {
		return type;
	}
	public void setTypeName(String typeName) {
		this.type = typeName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
}
