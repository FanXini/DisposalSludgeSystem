package factory.entity;

import java.util.List;


public class Site {

	private int id;
	private String siteName;
	private String serialNumber;
	private String address;
	private String longitude;
	private String latitude;
	private String telephone;
	private float depth;
	private int manageId;
	private String sensorIdSet;
	private User manage;
	private List<Sensor> sensors;
	private int status;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSiteName() {
		return siteName;
	}
	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}
	public String getSerialNumber() {
		return serialNumber;
	}
	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public float getDepth() {
		return depth;
	}
	public void setDepth(float depth) {
		this.depth = depth;
	}
	public int getManageId() {
		return manageId;
	}
	public void setManageId(int manageId) {
		this.manageId = manageId;
	}
	public String getSensorIdSet() {
		return sensorIdSet;
	}
	public void setSensorIdSet(String sensorIdSet) {
		this.sensorIdSet = sensorIdSet;
	}
	public User getManage() {
		return manage;
	}
	public void setManage(User manage) {
		this.manage = manage;
	}
	/**
	 * @return the status
	 */
	public int getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(int status) {
		this.status = status;
	}
	/**
	 * @return the sensors
	 */
	public List<Sensor> getSensors() {
		return sensors;
	}
	/**
	 * @param sensors the sensors to set
	 */
	public void setSensors(List<Sensor> sensors) {
		this.sensors = sensors;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Site [id=" + id + ", siteName=" + siteName + ", serialNumber="
				+ serialNumber + ", address=" + address + ", longitude="
				+ longitude + ", latitude=" + latitude + ", telephone="
				+ telephone + ", depth=" + depth + ", manageId=" + manageId
				+ ", sensorIdSet=" + sensorIdSet + ", manage=" + manage
				+ ", sensors=" + sensors + ", status=" + status + "]";
	}
}
