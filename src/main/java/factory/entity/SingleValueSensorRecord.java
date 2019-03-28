package factory.entity;

import java.io.Serializable;

public class SingleValueSensorRecord implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4441886439921531726L;
	private int id;
	private int sensorId;
	private String time;
	private double value;
	
	public SingleValueSensorRecord(int sensorId,String time,double value) {
		this.sensorId=sensorId;
		this.time=time;
		this.value=value;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSensorId() {
		return sensorId;
	}
	public void setSensorId(int sensorId) {
		this.sensorId = sensorId;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public double getValue() {
		return value;
	}
	public void setValue(double value) {
		this.value = value;
	}
	
}
