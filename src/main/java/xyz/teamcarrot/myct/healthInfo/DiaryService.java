package xyz.teamcarrot.myct.healthInfo;

public interface DiaryService {
	//운동
	//tb_health_diary 테이블
	int insertExInfo(HealthDiaryVO vo);
	HealthDiaryVO selectExInfo(int member_no);
	int updateExInfo(HealthDiaryVO vo);
	int deleteExInfo(HealthDiaryVO vo);
	
	//식단
	//tb_food_diary 테이블
	int insertFoodDiary(FoodDiaryVO vo);
	FoodDiaryVO selectFoodDiary(int member_no);
	int updateFoodDiary(FoodDiaryVO vo);
	int deleteFoodDiary(FoodDiaryVO vo);
	//tb_food_diary_info 테이블
	int insertFoodInfo(FoodDiaryInfoVO vo);
	FoodDiaryInfoVO selectFoodInfo(FoodDiaryInfoVO vo);;
	int updateFoodInfo(FoodDiaryInfoVO vo);
	int deleteFoodInfo(FoodDiaryInfoVO vo);
}