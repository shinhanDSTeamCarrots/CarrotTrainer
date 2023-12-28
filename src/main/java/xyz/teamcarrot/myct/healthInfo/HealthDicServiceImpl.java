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
	public Map<String, Object> getHealthDic(String healthName, int member_no, int minute, Integer page){
		int pageNumber = (page != null && page > 0) ? page : 1;
	    int startIdx = (pageNumber - 1) * 10;
		
		Map<String, Object> retMap = new HashMap<>();
		
		Map<String, Object> healthDic = new HashMap<>();
		healthDic.put("healthName", healthName);
		healthDic.put("member_no", member_no);
		healthDic.put("minute", minute);
		
		//총 개수
		int count = mapper.healthCount(healthDic);
		//총 페이지 수
		int totalPage = count / 10;
		//System.out.println("0"+totalPage);
		if (count % 10 > 0) totalPage++;
		//목록
		healthDic.put("startIdx", startIdx); // startIdx 추가
		healthDic.put("pageSize", 10); // 페이지 크기 추가
		List<Map<String, Object>> list = mapper.healthDic(healthDic);
		
		retMap.put("count", count);
		retMap.put("list", list);
		
		//하단에 페이징 처리
        int endPage = (int)(Math.ceil(pageNumber/10.0)*10);
        //System.out.println("1"+totalPage);
        int startPage = endPage - 9;
        if (endPage > totalPage) endPage = totalPage;
        //System.out.println("2"+totalPage);
        boolean prev = startPage > 1;
        boolean next = endPage < totalPage;
        retMap.put("endPage", endPage);
        retMap.put("startPage", startPage);
        retMap.put("prev", prev);
        retMap.put("next", next);
        retMap.put("page", pageNumber);
		
		//mapper.healthDic()을 호출할 때 필요한 정보를 담은 맵을 전달
        List<Map<String, Object>> healthDicList = mapper.healthDic(healthDic);
        //칼로리 값
      	//System.out.println(healthDicList.get(0).get("calorie"));
		retMap.put("healthDicList", healthDicList);
		
		return retMap;
	}
	
	//즐겨찾기 운동 리스트
	@Override
	public Map<String, Object> getBookmarkHealthDic(String healthName, int member_no, int minute, Integer page){
		int pageNumber = (page != null && page > 0) ? page : 1;
	    int startIdx = (pageNumber - 1) * 10;
		
		Map<String, Object> retMap = new HashMap<>();
		
		Map<String, Object> healthDic = new HashMap<>();
		healthDic.put("healthName", healthName);
		healthDic.put("member_no", member_no);
		healthDic.put("minute", minute);
		
		//총 개수
		int count = mapper.healthCount(healthDic);
		//총 페이지 수
		int totalPage = count / 10;
		if (count % 10 > 0) totalPage++;
		//목록
		healthDic.put("startIdx", startIdx); // startIdx 추가
		healthDic.put("pageSize", 10); // 페이지 크기 추가
		List<Map<String, Object>> list = mapper.bookmarkHealthDic(healthDic);
		
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
        retMap.put("page", page);
		
		//mapper.healthDic()을 호출할 때 필요한 정보를 담은 맵을 전달
        List<Map<String, Object>> bookmarkHealthDicList = mapper.bookmarkHealthDic(healthDic);
        //칼로리 값
      	//System.out.println(healthDicList.get(0).get("calorie"));
		retMap.put("bookmarkHealthDicList", bookmarkHealthDicList);
		
		return retMap;
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
	public Map<String, Object> getFoodDic(String foodName, int member_no, Integer page){
		int pageNumber = (page != null && page > 0) ? page : 1;
		int startIdx = (page - 1) * 10;
		
		Map<String, Object> retMap = new HashMap<>();
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("foodName", foodName);
		paramMap.put("member_no", member_no);
		
		//총 개수
		int count = mapper.foodCount(paramMap);
		//총 페이지 수
		int totalPage = count / 10;
		if (count % 10 > 0) totalPage++;
		//목록
	    paramMap.put("startIdx", startIdx); // startIdx 추가
	    paramMap.put("pageSize", 10); // 페이지 크기 추가
		List<Map<String, Object>> list = mapper.foodDic(paramMap);
		
		retMap.put("count", count);
		retMap.put("list", list);
		
		//하단에 페이징 처리
        int endPage = (int)(Math.ceil(pageNumber/10.0)*10);
        int startPage = endPage - 9;
        if (endPage > totalPage) endPage = totalPage;
        boolean prev = startPage > 1;
        boolean next = endPage < totalPage;
        retMap.put("endPage", endPage);
        retMap.put("startPage", startPage);
        retMap.put("prev", prev);
        retMap.put("next", next);
        retMap.put("page", pageNumber);
		
		//mapper.foodDic()을 호출할 때 필요한 정보를 담은 맵을 전달
		List<Map<String, Object>> foodDicList = mapper.foodDic(paramMap);
		retMap.put("foodDicList", foodDicList);
		
		return retMap;
	}
	//즐겨찾기 음식 리스트
	@Override
	public Map<String, Object> getBookmarkFoodDic(String foodName, int member_no, Integer page){
	    int pageNumber = (page != null && page > 0) ? page : 1;
	    int startIdx = (page - 1) * 10;
	    
	    Map<String, Object> retMap = new HashMap<>();
		Map<String, Object> foodDic = new HashMap<>();
		
		foodDic.put("foodName", foodName);
		foodDic.put("member_no", member_no);
		
		//총 개수
		int count = mapper.foodCount(foodDic);
		//총 페이지 수
		int totalPage = count / 10;
		if (count % 10 > 0) totalPage++;
		//목록
		foodDic.put("startIdx", startIdx); // startIdx 추가
		foodDic.put("pageSize", 10); // 페이지 크기 추가
		List<Map<String, Object>> list = mapper.foodDic(foodDic);
		
		retMap.put("count", count);
		retMap.put("list", list);
		
		//하단에 페이징 처리
        int endPage = (int)(Math.ceil(pageNumber/10.0)*10);
        int startPage = endPage - 9;
        if (endPage > totalPage) endPage = totalPage;
        boolean prev = startPage > 1;
        boolean next = endPage < totalPage;
        retMap.put("endPage", endPage);
        retMap.put("startPage", startPage);
        retMap.put("prev", prev);
        retMap.put("next", next);
        retMap.put("page", pageNumber);

		//mapper.foodDic()을 호출할 때 필요한 정보를 담은 맵을 전달
		List<Map<String, Object>> bookmarkFoodDicList = mapper.bookmarkFoodDic(foodDic);
		retMap.put("foodDicList", bookmarkFoodDicList);
		
		return retMap;
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
