package factory.entity;

public class Record {
	private int id;
	private String allocationTime;
	private String disposalTime;
	private String finishTime;
	private int carId;
	private int siteId;
	private int status;
	private double sludgesWeight;
	private double pretreatAmount;
	private Car car;
	private Site site;
	private float charge;
	public double getSludgesWeight() {
		return sludgesWeight;
	}
	public void setSludgesWeight(double sludgesWeight) {
		this.sludgesWeight = sludgesWeight;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getAllocationTime() {
		return allocationTime;
	}
	public void setAllocationTime(String allocationTime) {
		this.allocationTime = allocationTime;
	}
	public String getDisposalTime() {
		return disposalTime;
	}
	public void setDisposalTime(String disposalTime) {
		this.disposalTime = disposalTime;
	}
	public String getFinishTime() {
		return finishTime;
	}
	public void setFinishTime(String finishTime) {
		this.finishTime = finishTime;
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
	public float getCharge() {
		return charge;
	}
	public void setCharge(float charge) {
		this.charge = charge;
	}
	
	public double getPretreatAmount() {
		return pretreatAmount;
	}
	public void setPretreatAmount(double pretreatAmount) {
		this.pretreatAmount = pretreatAmount;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Record [id=" + id + ", allocationTime=" + allocationTime + ", disposalTime=" + disposalTime
				+ ", finishTime=" + finishTime + ", carId=" + carId + ", siteId=" + siteId + ", status=" + status
				+ ", sludgesWeight=" + sludgesWeight + ", pretreatAmount=" + pretreatAmount + ", car=" + car + ", site="
				+ site + ", charge=" + charge + "]";
	}
}
