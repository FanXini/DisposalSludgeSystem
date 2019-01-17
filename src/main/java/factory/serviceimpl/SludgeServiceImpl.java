package factory.serviceimpl;

import factory.dao.CarDao;
import factory.dao.MudWareHouseDao;
import factory.dao.SludgeDao;
import factory.entity.Sludge;
import factory.entity.SludgeFunction;
import factory.enums.CarStatus;
import factory.enums.SludgeStatus;
import factory.service.SludgeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class SludgeServiceImpl implements SludgeService {
	@Autowired
	private SludgeDao sludgeDao;
	
	@Autowired
	private CarDao carDao;
	
	@Autowired
	private MudWareHouseDao mudWareHouseDao;

	@Override
	public List<SludgeFunction> queryAllSludgeFunction() {
		return sludgeDao.queryAllSludgeFunction();
	}
	
	private static SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

	@Override
	public List<Sludge> queryAllSludgeByInOutFlagWithMinorWareHouseId(int inOutFlag,int minorWareHouseId) {
		List<Sludge> sludges = new ArrayList<Sludge>();
		sludges.addAll(sludgeDao.queryAllSludgeByInOutFlagWithMinorWareHouseId(inOutFlag,minorWareHouseId));
		/*Collections.sort(sludges, new Comparator<Sludge>() {
			public int compare(Sludge arg0, Sludge arg1) {
				return arg1.getProduceTime().compareTo(arg0.getProduceTime());
			}
		});*/
		return sludges;
	}
	
	@Override
	public void addSludge(Sludge sludge) {
		sludgeDao.addSludge(sludge);
		
	}
	@Override
	public void addOutSludge(Sludge sludge) {
		String function = sludge.getSludgeFunction().getFunction();
		//没有这个功能就新增一个功能
		SludgeFunction sludgeFunction = sludgeDao.querySludgeFunctionByFunction(function);
		if (sludgeFunction != null) {
			sludge.setFunctionId(sludgeFunction.getId());
		} else {
			SludgeFunction addSludgeFunction = new SludgeFunction();
			addSludgeFunction.setFunction(function);
			addSludgeFunction.setDescription(function);
			sludgeDao.addSludgeFunction(addSludgeFunction);
			sludge.setFunctionId(addSludgeFunction.getId());
		}
		if (sludge.getRfidString().equals("none")) {
			sludge.setRfidString(null);
		}
		if (sludge.getDestinationAddress().equals("none")) {
			sludge.setRfidString(null);
		}
		sludge.setStatus(SludgeStatus.MWHTODESROAD.ordinal()); //4表示从智慧仓到目的地的状态
		sludge.setProduceTime(format.format(new Date()));
		sludgeDao.addOutMudWareHouseSludgeRecord(sludge);
		//修改车的状态
		carDao.editWorkerCarStatusAndSiteId(sludge.getTranscarId(), CarStatus.ONTHEWAY.ordinal(), 0);
		
	}

	@Override
	public void deleteSludge(int sludgeId) {
		sludgeDao.deleteSludge(sludgeId);

	}

	@Override
	public void editSludge(Sludge sludge) {
		String function = sludge.getSludgeFunction().getFunction();
		SludgeFunction sludgeFunction = sludgeDao.querySludgeFunctionByFunction(function);
		if (sludgeFunction != null) {
			sludge.setFunctionId(sludgeFunction.getId());
		} else {
			SludgeFunction addSludgeFunction = new SludgeFunction();
			addSludgeFunction.setFunction(function);
			addSludgeFunction.setDescription(function);
			sludgeDao.addSludgeFunction(addSludgeFunction);
			sludge.setFunctionId(addSludgeFunction.getId());
		}
		if (sludge.getRfidString().equals("none")) {
			sludge.setRfidString(null);
		}
		if (sludge.getDestinationAddress().equals("none")) {
			sludge.setRfidString(null);
		}
		sludgeDao.editSludge(sludge);
	}

	@Override
	public List<Sludge> querySludgeBySiteId(int siteId) {
		// TODO Auto-generated method stub
		List<Sludge> sludges = new ArrayList<Sludge>();
		sludges.addAll(sludgeDao.querySludgeBySiteId(siteId));
		Collections.sort(sludges, new Comparator<Sludge>() {
			public int compare(Sludge arg0, Sludge arg1) {
				return arg1.getProduceTime().compareTo(arg0.getProduceTime());
			}
		});
		return sludges;
	}

	@Override
	public List<Sludge> querySludgeBySiteIdAndInOutFlagWithMinorWareHouseId(int siteId, int flag,int minorWareHouseId) {
		List<Sludge> sludges = new ArrayList<Sludge>();
		sludges.addAll(sludgeDao.querySludgeBySiteIdAndInOutFlagWithMinorWareHouseId(siteId,flag,minorWareHouseId));
		Collections.sort(sludges, new Comparator<Sludge>() {
			public int compare(Sludge arg0, Sludge arg1) {
				return arg1.getProduceTime().compareTo(arg0.getProduceTime());
			}
		});
		return sludges;
	}

	@Override
	public List<Sludge> querySludgeByDriverId(int driverId) {
		List<Sludge> sludges = new ArrayList<Sludge>();
		sludges.addAll(sludgeDao.querySludgeByDriverId(driverId));
		Collections.sort(sludges, new Comparator<Sludge>() {
			public int compare(Sludge arg0, Sludge arg1) {
				return arg1.getProduceTime().compareTo(arg0.getProduceTime());
			}
		});
		return sludges;
	}
	
	@Override
	public List<Sludge> querySludgeByDriverIdAndInOutFlagWithMinorWareHouseId(int driverId,int inOutFlag,int minorWareHouseId) {
		List<Sludge> sludges = new ArrayList<Sludge>();
		sludges.addAll(sludgeDao.querySludgeByDriverIdAndInOutFlagWithMinorWareHouseId(driverId,inOutFlag,minorWareHouseId));
		Collections.sort(sludges, new Comparator<Sludge>() {
			public int compare(Sludge arg0, Sludge arg1) {
				return arg1.getProduceTime().compareTo(arg0.getProduceTime());
			}
		});
		return sludges;
	}

	@Override
	public List<Sludge> querySludgeByDateAndInOutFlagWithMinorWareHouseId(String startDate, String endDate,int inOutFlag,int minorWareHouseId) {
		List<Sludge> sludges = new ArrayList<Sludge>();
		sludges.addAll(sludgeDao.querySludgeByDateAndInOutFlagWithMinorWareHouseId(startDate, endDate, inOutFlag,minorWareHouseId));
		//sludges.addAll(sludgeDao.querySludegAssignFuncByDate(startDate, endDate));
		//sludges.addAll(sludgeDao.querySludegNotAssignFuncByDate(startDate, endDate));
		Collections.sort(sludges, new Comparator<Sludge>() {
			public int compare(Sludge arg0, Sludge arg1) {
				return arg1.getProduceTime().compareTo(arg0.getProduceTime());
			}
		});
		return sludges;

	}

	@Override
	public List<Sludge> queryAllSludgeOfOneFactory(int siteId) {
		List<Sludge> sludges = new ArrayList<Sludge>();
		sludges.addAll(sludgeDao.querySludgeBySiteId(siteId));
		return sludges;
	}

	@Override
	public List<Sludge> querySludgeByDriverIdOfOneFacotry(Map<String, Integer> condition) {
		int siteId = condition.get("siteId");
		int driverId = condition.get("driverId");
		List<Sludge> sludges = new ArrayList<Sludge>();
		sludges.addAll(sludgeDao.querySludgeByDriverIdOfOneFacotry(driverId, siteId));
		return sludges;
	}

	@Override
	public List<Sludge> querySludegByDateOfOneFactory(Map<String, Object> condition) {
		int siteId = (int) condition.get("siteId");
		String startDate = String.valueOf(condition.get("startDate"));
		String endDate = String.valueOf(condition.get("endDate"));
		System.out.println(siteId + " " + startDate + " " + endDate);
		List<Sludge> sludges = new ArrayList<Sludge>();
		sludges.addAll(sludgeDao.querySludegByDateOfOneFactory(siteId, startDate, endDate));
		return sludges;
	}

	@Override
	public List<Sludge> querySludgeByDates(String startDate, String endDate, int siteId) {
		List<Sludge> sludges = new ArrayList<Sludge>();
		System.out.println("dates are:" + startDate + ":" + endDate);
		sludges.addAll(sludgeDao.querySludgeByDates(startDate, endDate, siteId));
		// Collections.sort(sludges, new Comparator<Sludge>() {
		// public int compare(Sludge arg0, Sludge arg1) {
		// return arg0.getProduceTime().compareTo(arg1.getProduceTime());
		// }
		// });
		return sludges;
	}

	@Override
	public List<Sludge> querySludgeBySiteName(String siteName) {
		List<Sludge> sludges = new ArrayList<Sludge>();
		sludges.addAll(sludgeDao.querySludgeBySiteName(siteName));
		// Collections.sort(sludges, new Comparator<Sludge>() {
		// public int compare(Sludge arg0, Sludge arg1) {
		// return arg0.getProduceTime().compareTo(arg1.getProduceTime());
		// }
		// });
		return sludges;
	}
	
	@Override
	public List<Sludge> transportsludgeofonedriver(int driverId) {
		// TODO Auto-generated method stub
		List<Sludge> sludges = new ArrayList<Sludge>();
		sludges.addAll(sludgeDao.transportsludgeofonedriver(driverId));
		return sludges;
	}
	@Override
	public void insertSludgeByDriver(Sludge sludge) {
		if (sludge.getSludgeFunction() != null) {
			String function = sludge.getSludgeFunction().getFunction();
			SludgeFunction sludgeFunctionInDB = sludgeDao.querySludgeFunctionByFunction(function);
			if(sludgeFunctionInDB!=null) {
				sludge.setFunctionId(sludgeFunctionInDB.getId());
			}
			else {
				SludgeFunction addSludgeFunction = new SludgeFunction();
				addSludgeFunction.setFunction(function);
				addSludgeFunction.setDescription(function);
				sludgeDao.addSludgeFunction(addSludgeFunction);
				sludge.setFunctionId(addSludgeFunction.getId());
			}
		}
		int minorMudWareHoseId=sludge.getMinorMudWareHouseId();
		sludge.setProduceTime(format.format(new Date()));
		sludgeDao.insertSludgeByDriver(sludge);
	}
	@Override
	public Sludge querysludgebydriverIdAndStatus(int driverId) {
		// TODO Auto-generated method stub	
		Sludge sludge = sludgeDao.querysludgebydriverIdAndStatus(driverId);
		return sludge;
	}
	@Override
	public List<Sludge> fussyQuerysludgebyTransDriver(String condition,int driverId) {
		List<Sludge> sludges = new ArrayList<Sludge>();
		sludges.addAll(sludgeDao.fussyQuerysludgebyTransDriver(condition,driverId));
		return sludges;
	}

}
