package xyz.teamcarrot.myct.healthInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DiaryServiceImpl implements DiaryService {

	@Autowired
	DiaryMapper mapper;
	
	//운동
	//tb_health_diary 테이블
	public int insertExInfo(HealthDiaryVO vo) {
		return mapper.insertExInfo(vo);
	}
	@Override
	public HealthDiaryVO selectExInfo(int member_no) {
		return mapper.selectExInfo(member_no);
	}
	@Override
	public int updateExInfo(HealthDiaryVO vo) {
		return mapper.updateExInfo(vo);
	}
	@Override
	public int deleteExInfo(HealthDiaryVO vo) {
		return mapper.deleteExInfo(vo.getHealth_diary_no());
	}
	
	//식단
	//tb_food_diary 테이블
	@Override
	public int insertFoodDiary(FoodDiaryVO vo) {
		return mapper.insertFoodDiary(vo);
	}
	@Override
	public FoodDiaryVO selectFoodDiary(int member_no) {
		return mapper.selectFoodDiary(member_no);
	}
	@Override
	public int updateFoodDiary(FoodDiaryVO vo) {
		return mapper.updateFoodDiary(vo);
	}
	@Override
	public int deleteFoodDiary(FoodDiaryVO vo) {
		return mapper.deleteFoodDiary(vo.getFood_diary_no());
	}
	//tb_food_diary_info 테이블
	@Override
	public int insertFoodInfo(FoodDiaryInfoVO vo) {
		return mapper.insertFoodInfo(vo);
	}
	@Override
	public FoodDiaryInfoVO selectFoodInfo(FoodDiaryInfoVO vo) {
		return mapper.selectFoodInfo(vo.getFood_diary_no());
	}
	@Override
	public int updateFoodInfo(FoodDiaryInfoVO vo) {
		return mapper.updateFoodInfo(vo);
	}
	@Override
	public int deleteFoodInfo(FoodDiaryInfoVO vo) {
		return mapper.deleteFoodInfo(vo.getFood_diary_info_no());
	}
}
