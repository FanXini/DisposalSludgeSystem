package factory.entity;

public class Sensor{

	private int id;
	private int typeId;
	private int carId;
	private int siteId;
	private int status;
	private String serialNumber;
	private SensorType sensorType;
	private Car car;
	private Site site;
	private String placeSelect;
	private SensorValue sensorValue;
	public String getPlaceSelect() {
		return placeSelect;
	}
	public void setPlaceSelect(String placeSelect) {
		this.placeSelect = placeSelect;
	}
	public int getCarId() {
		return carId;
	}
	public void setCarId(int carId) {
		this.carId = carId;
	}
	public int getSiteId() {
		return siteId;
	}
	public void setSiteId(int siteId) {
		this.siteId = siteId;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getTypeId() {
		return typeId;
	}
	public void setTypeId(int typeId) {
		this.typeId = typeId;
	}
	public String getSerialNumber() {
		return serialNumber;
	}
	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}
	public SensorType getSensorType() {
		return sensorType;
	}
	public void setSensorType(SensorType sensorType) {
		this.sensorType = sensorType;
	}
	public Car getCar() {
		return car;
	}
	public void setCar(Car car) {
		this.car = car;
	}
	public Site getSite() {
		return site;
	}
	public void setSite(Site site) {
		this.site = site;
	}
	
	/**
	 * @return the sensorValue
	 */
	public SensorValue getSensorValue() {
		return sensorValue;
	}
	/**
	 * @param sensorValue the sensorValue to set
	 */
	public void setSensorValue(SensorValue sensorValue) {
		this.sensorValue = sensorValue;
	}
	@Override
	public String toString() {
		return "Sensor [id=" + id + ", typeId=" + typeId + ", carId=" + carId + ", siteId=" + siteId + ", status="
				+ status + ", serialNumber=" + serialNumber + ", sensorType=" + sensorType + ", car=" + car + ", site="
				+ site + "]";
	}
}
