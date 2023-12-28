package xyz.teamcarrot.myct.healthInfo;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DiaryMapper {
	//tb_food_diary 테이블
	int insertFoodDiary(FoodDiaryVO vo);
	FoodDiaryVO selectFoodDiary(int no);
	int updateFoodDiary(FoodDiaryVO vo);
	int deleteFoodDiary(int no);
	
	FoodDiaryVO selectFoodCal(int no);
	
	//tb_food_diary_info 테이블
	int insertFoodInfo(FoodDiaryInfoVO vo);
	FoodDiaryInfoVO selectFoodInfo(int no);
	int updateFoodInfo(FoodDiaryInfoVO vo);
	int deleteFoodInfo(int no);
}
