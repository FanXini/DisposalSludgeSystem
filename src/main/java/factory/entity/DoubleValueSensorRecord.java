package factory.entity;

public class DoubleValueSensorRecord {
	private int id;
	private int sensorId;	
	private String time;
	private double value1;
	private double value2;
	public DoubleValueSensorRecord(int sensorId,String time,double value1,double value2){
		this.sensorId=sensorId;
		this.time=time;
		this.value1=value1;
		this.value2=value2;
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
