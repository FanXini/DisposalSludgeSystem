package factory.entity;
public class Video {
	private int id;
	private int car_id;
	private String license;
	private String serial_number;
	private String video_RTMPid;
	private String video_HLSid;
	private int del_status;
	private Car car;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCar_id() {
		return car_id;
	}
	public void setCar_id(int car_id) {
		this.car_id = car_id;
	}
	public String getLicense() {
		return license;
	}
	public void setLicense(String license) {
		this.license = license;
	}
	public String getSerial_number() {
		return serial_number;
	}
	public void setSerial_number(String serial_number) {
		this.serial_number = serial_number;
	}
	public String getVideo_RTMPid() {
		return video_RTMPid;
	}
	public void setVideo_RTMPid(String video_RTMPid) {
		this.video_RTMPid = video_RTMPid;
	}
	public String getVideo_HLSid() {
		return video_HLSid;
	}
	public void setVideo_HLSid(String video_HLSid) {
		this.video_HLSid = video_HLSid;
	}
	public int getDel_status() {
		return del_status;
	}
	public void setDel_status(int del_status) {
		this.del_status = del_status;
	}
	public Car getCar() {
		return car;
	}
	public void setCar(Car car) {
		this.car = car;
	}	
}
