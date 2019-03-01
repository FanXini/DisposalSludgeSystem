package factory.entity;

import java.io.Serializable;

public class MainMudWareHouse implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1731182395643875699L;
	private int id;
	private String wareHouseName;
	private double longitude;
	private double latitude;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getWareHouseName() {
		return wareHouseName;
	}
	public void setWareHouseName(String wareHouseName) {
		this.wareHouseName = wareHouseName;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

}
