package factory.enums;

public enum Result {
	/**
	 * INPUT表示表单提交数据格式不正确(为空或类型不一致)
	 */
	INPUT,
	
	/**
	 * SUCCESS表示处理正常
	 */
	SUCCESS,
	/**
	 * DUPLICATE表示DuplicateKeyException异常，
	 */
	DUPLICATE,
	/**
	 * ERROR表示出错
	 */
	ERROR,
	
	/**
	 * 修改信息冲突
	 */
	CONFLICT,
	/**
	 * 用户审核中
	 */
	AUDING,
	/**
	 * 禁止登陆
	 */	
	FORBID;
	
	
	
	

}
