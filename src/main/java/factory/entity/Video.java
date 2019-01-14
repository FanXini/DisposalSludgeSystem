package factory.entity;
public class Video {
	private int id;
	private int carId;
	private String license;
	private String serialNumber;
	private String videoRTMPid;
	private String videoHLSid;
	private int delStatus;
	private Car car;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCarId() {
		return carId;
	}
	public void setCarId(int carId) {
		this.carId = carId;
	}
	public String getLicense() {
		return license;
	}
	public void setLicense(String license) {
		this.license = license;
	}
	public String getSerialNumber() {
		return serialNumber;
	}
	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}
	public String getVideoRTMPid() {
		return videoRTMPid;
	}
	public void setVideoRTMPid(String videoRTMPid) {
		this.videoRTMPid = videoRTMPid;
	}
	public String getVideoHLSid() {
		return videoHLSid;
	}
	public void setVideoHLSid(String videoHLSid) {
		this.videoHLSid = videoHLSid;
	}
	public int getDelStatus() {
		return delStatus;
	}
	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}
	public Car getCar() {
		return car;
	}
	public void setCar(Car car) {
		this.car = car;
	}
	
}
