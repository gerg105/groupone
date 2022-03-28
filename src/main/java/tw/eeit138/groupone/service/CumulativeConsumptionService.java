package tw.eeit138.groupone.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import tw.eeit138.groupone.dao.CumulativeConsumptionRepository;
import tw.eeit138.groupone.model.CumulativeConsumptionBean;

@Service
public class CumulativeConsumptionService {
	@Autowired
	CumulativeConsumptionRepository cumulativeConsumptionDao;

	public void deleteConsumption(Integer id) {
		cumulativeConsumptionDao.deleteById(id);
	}

	// 判斷是否有消費紀錄
	public void addConsumption(CumulativeConsumptionBean cumulativeConsumption, int memberId, int consumption) {
		List<CumulativeConsumptionBean> dbBean = cumulativeConsumptionDao.getByMemberId(memberId);
		if (!CollectionUtils.isEmpty(dbBean)) {
			int reaultCumulative = dbBean.get(0).getCumulativeConsumption() + consumption;

			CumulativeConsumptionBean repeatCumulative = new CumulativeConsumptionBean();
			repeatCumulative.setCumulativeConsumption(reaultCumulative);
			repeatCumulative.setMemberID(memberId);
			repeatCumulative.setConsumptionDate(new Date());
			// 判斷是否有消費紀錄,有的話做累加
			cumulativeConsumptionDao.updateCumulativeConsumptionDate(reaultCumulative, memberId);

		} else {
			// 判斷是否有消費紀錄,沒有的話做新增
			cumulativeConsumptionDao.save(cumulativeConsumption);
		}
	}

	// 用id查詢消費額額度
	public int getCumulativeByMemberId(int id) {
		return cumulativeConsumptionDao.getCumulativeByMemberId(id);
	}
	
	//用id查詢消費總額明細
	public CumulativeConsumptionBean getCumulativeDataByMemberId(int id) {
		return cumulativeConsumptionDao.getCumulativeDataByMemberId(id);
	}
	
	//變更累積消費為0,byId
	public void editConsumption(int id,int cumulativeConsumption) {
		cumulativeConsumptionDao.editCumulativeConsumptionById(cumulativeConsumption, id);
	}

	// 是否超過6個月
	public CumulativeConsumptionBean getSixMonth(int id) {
		return cumulativeConsumptionDao.getSixMonth(id);
	}

}
