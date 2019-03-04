package factory.entity;

import java.io.Serializable;

public class SludgeFunction implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4040945985924644130L;
	private int id;
	private String function;
	private String description;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFunction() {
		return function;
	}
	public void setFunction(String function) {
		this.function = function;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}

}
