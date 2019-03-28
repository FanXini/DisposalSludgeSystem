package factory.entity;

import java.io.Serializable;

public class Sludge implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -6192198481895077268L;
	private int id;
	private int recordId;
	private int functionId;
	private int minorMudWareHouseId;
	private String produceTime;
	private String arrivalTime;
	private String destinationAddress;
	private String rfidString;
	private int status;
	private Record record;
	private SludgeFunction sludgeFunction;
	private float weight;
	private int transcarId;
	private Car car;
	private User user;
	private MinorMudWareHouse minorMudWareHouse;
	
	
	public Car getCar() {
		return car;
	}
	public void setCar(Car car) {
		this.car = car;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public int getMinorMudWareHouseId() {
		return minorMudWareHouseId;
	}
	public void setMinorMudWareHouseId(int minorMudWareHouseId) {
		this.minorMudWareHouseId = minorMudWareHouseId;
	}
	public MinorMudWareHouse getMinorMudWareHouse() {
		return minorMudWareHouse;
	}
	public void setMinorMudWareHouse(MinorMudWareHouse minorMudWareHouse) {
		this.minorMudWareHouse = minorMudWareHouse;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getRecordId() {
		return recordId;
	}
	public void setRecordId(int recordId) {
		this.recordId = recordId;
	}
	public int getFunctionId() {
		return functionId;
	}
	public void setFunctionId(int functionId) {
		this.functionId = functionId;
	}
	public String getProduceTime() {
		return produceTime;
	}
	public void setProduceTime(String produceTime) {
		this.produceTime = produceTime;
	}
	public String getArrivalTime() {
		return arrivalTime;
	}
	public void setArrivalTime(String arrivalTime) {
		this.arrivalTime = arrivalTime;
	}
	public String getDestinationAddress() {
		return destinationAddress;
	}
	public void setDestinationAddress(String destinationAddress) {
		this.destinationAddress = destinationAddress;
	}

	public String getRfidString() {
		return rfidString;
	}
	public void setRfidString(String rfidString) {
		this.rfidString = rfidString;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Record getRecord() {
		return record;
	}
	public void setRecord(Record record) {
		this.record = record;
	}
	public SludgeFunction getSludgeFunction() {
		return sludgeFunction;
	}
	public void setSludgeFunction(SludgeFunction sludgeFunction) {
		this.sludgeFunction = sludgeFunction;
	}
	public float getWeight() {
		return weight;
	}
	public void setWeight(float weight) {
		this.weight = weight;
	}
	public int getTranscarId() {
		return transcarId;
	}
	public void setTranscarId(int transcarId) {
		this.transcarId = transcarId;
	}
	
}
