package xyz.teamcarrot.myct.healthInfo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HealthDicServiceImpl implements HealthDicService {

	@Autowired
	HealthDicMapper mapper;
	
	//전체 운동 리스트
	@Override
	public List<Map<String, Object>> getHealthDic(String healthName, int member_no, int minute){
		Map<String, Object> healthDic = new HashMap<>();
		
		//총 개수
		//int totalCount = healthDicList.size();
		
		healthDic.put("healthName", healthName);
		healthDic.put("member_no", member_no);
		healthDic.put("minute", minute);
		
		//mapper.healthDic()을 호출할 때 필요한 정보를 담은 맵을 전달
		List<Map<String, Object>> healthDicList = mapper.healthDic(healthDic);
		//칼로리 값
		//System.out.println(healthDicList.get(0).get("calorie"));
		
		return healthDicList;
	}
	
	//즐겨찾기 운동 리스트
	@Override
	public List<Map<String, Object>> getBookmarkHealthDic(String healthName, int member_no, int minute){
		Map<String, Object> healthDic = new HashMap<>();
		
		//총 개수
		//int totalCount = healthDicList.size();
		
		healthDic.put("healthName", healthName);
		healthDic.put("member_no", member_no);
		healthDic.put("minute", minute);
		
		//mapper.healthDic()을 호출할 때 필요한 정보를 담은 맵을 전달
		List<Map<String, Object>> bookmarkHealthDicList = mapper.bookmarkHealthDic(healthDic);
	    
		return bookmarkHealthDicList;
	}
	//북마크 추가
	@Override
    public int addBookmark(HealthBookmarkVO vo) {
		return mapper.addBookmark(vo);
    }
    //북마크 삭제
	@Override
    public int delBookmark(int health_bookmark_no) {
		return mapper.delBookmark(health_bookmark_no);
    }
	
	//운동 정보 입력
	@Override
	public boolean insertHealthInfo(HealthDiaryVO vo) {
		return mapper.insertHealthInfo(vo) > 0 ? true : false;
	}
	@Override
	public HealthDiaryVO selectHealthInfo(int member_no) {
		return mapper.selectHealthInfo(member_no);
	}
	@Override
	public int updateHealthInfo(HealthDiaryVO vo) {
		return mapper.updateHealthInfo(vo);
	}
	@Override
	public int deleteHealthInfo(HealthDiaryVO vo) {
		return mapper.deleteHealthInfo(vo.getHealth_diary_no());
	}
	
	//전체 음식 리스트
	@Override
	public Map<String, Object> getFoodDic(String foodName, int member_no){
		int page = 1;
		int startIdx = (page - 1) * 10;
		
		Map<String, Object> retMap = new HashMap<>();
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("foodName", foodName);
		paramMap.put("member_no", member_no);
		
		//총 개수
		int count = mapper.foodCount(paramMap);
		//총 페이지 수
		int totalPage = count/10;
		if (count % 10 > 0) totalPage++;
		//목록
		List<Map<String, Object>> list = mapper.list(paramMap);
		
		retMap.put("count", count);
		retMap.put("list", list);
		
		//하단에 페이징 처리
        int endPage = (int)(Math.ceil(page/10.0)*10);
        int startPage = endPage - 9;
        if (endPage > totalPage) endPage = totalPage;
        boolean prev = startPage > 1;
        boolean next = endPage < totalPage;
        retMap.put("endPage", endPage);
        retMap.put("startPage", startPage);
        retMap.put("prev", prev);
        retMap.put("next", next);
		
		//mapper.foodDic()을 호출할 때 필요한 정보를 담은 맵을 전달
		List<Map<String, Object>> foodDicList = mapper.foodDic(paramMap);
		retMap.put("foodDicList", foodDicList);
		
		return retMap;
	}
	//즐겨찾기 음식 리스트
	@Override
	public List<Map<String, Object>> getBookmarkFoodDic(String foodName, int member_no){
		Map<String, Object> foodDic = new HashMap<>();
		
		//총 개수
		//int totalCount = healthDicList.size();
		
		foodDic.put("foodName", foodName);
		foodDic.put("member_no", member_no);
		
		//mapper.foodDic()을 호출할 때 필요한 정보를 담은 맵을 전달
		List<Map<String, Object>> bookmarkFoodDicList = mapper.bookmarkFoodDic(foodDic);
	    
		return bookmarkFoodDicList;
	}
	//북마크 추가
	@Override
    public int addFoodBookmark(FoodBookmarkVO vo) {
		return mapper.addFoodBookmark(vo);
    }
    //북마크 삭제
	@Override
    public int delFoodBookmark(int food_bookmark_no) {
		return mapper.delFoodBookmark(food_bookmark_no);
    }
}
