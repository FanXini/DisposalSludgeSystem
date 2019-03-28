package factory.entity;

import java.io.Serializable;

public class MinorMudWareHouse implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -2886200057051270798L;
	private int id;
	private int mainMudWareHouseId;
	private String serialNumber;
	private double capacity;
	private double remainCapacity;
	private double moistureDegree;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getMainMudWareHouseId() {
		return mainMudWareHouseId;
	}
	public void setMainMudWareHouseId(int mainMudWareHouseId) {
		this.mainMudWareHouseId = mainMudWareHouseId;
	}
	public double getCapacity() {
		return capacity;
	}
	public void setCapacity(double capacity) {
		this.capacity = capacity;
	}
	public double getRemainCapacity() {
		return remainCapacity;
	}
	public void setRemainCapacity(double remainCapacity) {
		this.remainCapacity = remainCapacity;
	}
	public double getMoistrueDegree() {
		return moistureDegree;
	}
	public void setMoistrueDegree(double moistrueDegree) {
		this.moistureDegree = moistrueDegree;
	}
	public String getSerialNumber() {
		return serialNumber;
	}
	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}
	
}
