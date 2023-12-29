package xyz.teamcarrot.myct.healthInfo;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import xyz.teamcarrot.myct.JsonUtils;
@Service
public class BodyChangeServiceImpl implements BodyChangeService {
	@Autowired
	BodyChangeMapper mapper;

	@Override
	public Map selectWeekFoodGraph(int member_no) {
		return mapper.selectWeekFoodGraph(member_no);
	}

	@Override
	public List selectWeekHealthGraph(int member_no) {
		return mapper.selectWeekHealthGraph(member_no);
	}

	@Override
	public String JsonWeekFoodGraph(int member_no) {
		try {
			return JsonUtils.getJsonStringFromMap(mapper.selectWeekFoodGraph(member_no));
		} catch(NullPointerException n) {
			return null;
		}
		
	}

	@Override
	public String JsonWeekHealthGraph(int member_no) {
		try {

			return JsonUtils.getJsonStringFromList(mapper.selectWeekHealthGraph(member_no));
		}
		catch(NullPointerException n) {
			return null;
		}
	}

	@Override
	public List dailyAvgWeight(int member_no) {
		return mapper.dailyAvgWeight(member_no);
	}

	@Override
	public String jsondailyAvgWeight(int member_no) {
		try {
			return JsonUtils.getJsonStringFromList(mapper.dailyAvgWeight(member_no));
		}
		catch(NullPointerException n) {
			return null;
		}
	}

}
