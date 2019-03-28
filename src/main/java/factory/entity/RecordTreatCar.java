package factory.entity;



public class RecordTreatCar {

	private int id;
	private int recordId;
	private int treatmentcarId;
	private Car treatmentcar;
	public int getTreatcarId() {
		return treatmentcarId;
	}
	public void setTreatcarId(int treatmentcarId) {
		this.treatmentcarId = treatmentcarId;
	}
	public Car getTreatcar() {
		return treatmentcar;
	}
	public void setTreatcar(Car treatmentcar) {
		this.treatmentcar = treatmentcar;
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
}
