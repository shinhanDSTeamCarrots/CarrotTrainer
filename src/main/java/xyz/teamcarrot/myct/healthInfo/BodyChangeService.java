package xyz.teamcarrot.myct.healthInfo;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public interface BodyChangeService {
	List dailyAvgWeight(int member_no);
	String jsondailyAvgWeight(int member_no);
	Map selectWeekFoodGraph(int member_no);
	List selectWeekHealthGraph(int member_no);
	String JsonWeekFoodGraph(int member_no);
	String JsonWeekHealthGraph(int member_no);
}
