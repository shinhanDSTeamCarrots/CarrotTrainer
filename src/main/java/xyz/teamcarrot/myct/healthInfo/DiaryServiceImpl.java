package xyz.teamcarrot.myct.healthInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DiaryServiceImpl implements DiaryService {

	@Autowired
	DiaryMapper mapper;
	
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
	
	@Override
	public FoodDiaryVO selectFoodCal(int member_no) {
		FoodDiaryVO vo = mapper.selectFoodCal(member_no);
		//System.out.println("vo: "+vo.toString());
		return vo;
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
