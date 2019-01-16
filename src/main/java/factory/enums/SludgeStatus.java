package factory.enums;

public enum SludgeStatus {
	
	/**
	 * 产出地到泥仓路上,对应数据库中0状态
	 * MWH表示智慧泥仓 Mud WareHouse
	 */
	FACTORYTOMWHRAOD,
	/**
	 * 已存放到泥仓,对应数据库中1状态
	 */
	STOREINMWH,
	/**
	 * 产出地到最终目的地的路上,对应数据库中2状态
	 */
	FACTORYTODESROAD,
	/**
	 * 从产出地运达最终目的地,对应数据库中3状态
	 */
	ARRIVEDESFROMFACTORY,
	/**
	 * 从智慧泥仓运往最终目的地的路上,对应数据库中4状态
	 */
	MWHTODESROAD,
	/**
	 * 从智慧泥仓运达最终目的,对应数据库中5状态
	 */
	ARRIVEDESFROMMWH,
	/**
	 * 新分配运输任务(污泥块还未产生),对应数据库中6状态
	 */
	VIRTUAL
	
	
	
	

}
