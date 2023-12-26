package xyz.teamcarrot.myct.healthInfo;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DiaryMapper {
	//운동
	//tb_health_diary 테이블
	int insertExInfo(HealthDiaryVO vo);
	HealthDiaryVO selectExInfo(int no);
	int updateExInfo(HealthDiaryVO vo);
	int deleteExInfo(int no);
	
	//식단
	//tb_food_diary 테이블
	int insertFoodDiary(FoodDiaryVO vo);
	FoodDiaryVO selectFoodDiary(int no);
	int updateFoodDiary(FoodDiaryVO vo);
	int deleteFoodDiary(int no);
	//tb_food_diary_info 테이블
	int insertFoodInfo(FoodDiaryInfoVO vo);
	FoodDiaryInfoVO selectFoodInfo(int no);
	int updateFoodInfo(FoodDiaryInfoVO vo);
	int deleteFoodInfo(int no);
}
