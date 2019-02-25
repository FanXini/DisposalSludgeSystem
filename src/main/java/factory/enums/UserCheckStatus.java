package factory.enums;

public enum UserCheckStatus {
	
	/**
	 * 审核失败，对应数据库中0状态
	 */
	FAILURE,
	/**
	 * 审核通过，对应数据库中1状态
	 */
	SUCCESS,
	/**
	 * 等待审核，对应数据库中2状态
	 */
	
	WAITINGCHECK
}
