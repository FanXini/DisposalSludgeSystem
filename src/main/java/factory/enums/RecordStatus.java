package factory.enums;

public enum RecordStatus {

	/**
	 * 处理完成状态，对应数据库中0状态
	 */
	ACCOMPLISH,
	/**
	 * 处理中,对应数据库中的1状态
	 */
	PROCESSING,
	/**
	 * 等待处理,对应数据库中的2状态
	 */
	WATINGPROCESS
}
