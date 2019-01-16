package factory.enums;

public enum CarStatus {

	/**
	 * 空闲状态，对应数据库中的0状态
	 */
	LEISURE,
	/**
	 * 在途中，对应数据库中的1状态
	 */
	ONTHEWAY,
	/**
	 * 已到达，对应数据库中的2状态
	 */
	
	ARRIVAL,
	/**
	 * 已派单，未出发，对应数据库中的3状态
	 */
	NODEPARTURE,
	/**
	 * 返程，对应数据库中的4状态
	 */	
	GETBACK
	
	
	
}
