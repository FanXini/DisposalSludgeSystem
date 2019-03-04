package factory.entity;

import java.io.Serializable;

public class SensorValue implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4552482725944455990L;
	private int id;
	private int sensorId;
	private String time;
	private double value1;
	private double value2;
	private char headInfo; // ���ͷ��Ϣ

	public SensorValue() {

	}

	public SensorValue(int sensorId, String time, double value1, double value2, char headInfo) {
		this.sensorId = sensorId;
		this.time = time;
		this.value1 = value1;
		this.value2 = value2;
		this.headInfo = headInfo;
	}

	public SensorValue(int sensorId, String time, double value1, char headInfo) {
		this.sensorId = sensorId;
		this.time = time;
		this.value1 = value1;
		this.headInfo = headInfo;
	}

	public SensorValue(int sensorId, double value1, double value2) {
		this.sensorId = sensorId;
		this.value1 = value1;
		this.value2 = value2;
	}

	public char getHeadInfo() {
		return headInfo;
	}

	public void setHeadInfo(char headInfo) {
		this.headInfo = headInfo;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
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

	public double getValue1() {
		return value1;
	}

	public void setValue1(double value1) {
		this.value1 = value1;
	}

	public double getValue2() {
		return value2;
	}

	public void setValue2(double value2) {
		this.value2 = value2;
	}

}
