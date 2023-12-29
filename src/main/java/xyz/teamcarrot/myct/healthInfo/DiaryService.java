package xyz.teamcarrot.myct.healthInfo;

public interface DiaryService {
	//tb_food_diary 테이블
	int insertFoodDiary(FoodDiaryVO vo);
	FoodDiaryVO selectFoodDiary(int member_no);
	int updateFoodDiary(FoodDiaryVO vo);
	int deleteFoodDiary(FoodDiaryVO vo);
	
	FoodDiaryVO selectFoodCal(int member_no);
	
	//tb_food_diary_info 테이블
	int insertFoodInfo(FoodDiaryInfoVO vo);
	FoodDiaryInfoVO selectFoodInfo(FoodDiaryInfoVO vo);
	int updateFoodInfo(FoodDiaryInfoVO vo);
	int deleteFoodInfo(FoodDiaryInfoVO vo);
}