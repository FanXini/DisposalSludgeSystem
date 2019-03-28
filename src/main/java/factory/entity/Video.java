package factory.entity;

import java.io.Serializable;

public class Video implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3528609198445731027L;
	private int id;
	private int carId;
	private int siteId;
	private String license;
	private String serialNumber;
	private String videoRTMPid;
	private String videoHLSid;
	private int delStatus;
	private Car car;
	private Site site;
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
	
	public int getSiteId() {
		return siteId;
	}
	public void setSiteId(int siteId) {
		this.siteId = siteId;
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
	public Site getSite() {
		return site;
	}
	public void setSite(Site site) {
		this.site = site;
	}
}
