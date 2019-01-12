package factory.entity;

public class MudWareHouse {
	
	private int id;
	private String wareHouseName;
	private double longitude;
	private double latitude;
	private double capcity;
	private double remainCapcity;
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
	public double getCapcity() {
		return capcity;
	}
	public void setCapcity(double capcity) {
		this.capcity = capcity;
	}
	public double getRemainCapcity() {
		return remainCapcity;
	}
	public void setRemainCapcity(double remainCapcity) {
		this.remainCapcity = remainCapcity;
	}

}
