package xyz.teamcarrot.myct.healthInfo;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HealthInfoServiceImpl implements HealthInfoService {

	@Autowired
	HealthInfoMapper mapper;
	
	@Override
	public List<Map<String, Object>> gethealthDic(){
		List<Map<String, Object>> healthDicList = mapper.healthDic();
		//총 개수
		int totalCount = healthDicList.size();
		
		int kg = 70;
		int minute = 60;
		
		for (Map<String, Object> healthDic : healthDicList) {
			Object meValue = healthDic.get("met");
			int calorie = (int)Math.round(((double)meValue * (3.5 * kg * minute))/1000 * 5);
			healthDic.put("calorie", calorie);
		}
		return healthDicList;
	}
}
