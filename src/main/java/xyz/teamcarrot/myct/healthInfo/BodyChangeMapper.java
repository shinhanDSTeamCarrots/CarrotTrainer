package xyz.teamcarrot.myct.healthInfo;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BodyChangeMapper {
	List dailyAvgWeight(int member_no);
	double WeekAvgWeight(int member_no);
	double MonthAvgWeight(int member_no);
	Map selectWeekFoodGraph(int member_no);
	List selectWeekHealthGraph(int member_no);
}
