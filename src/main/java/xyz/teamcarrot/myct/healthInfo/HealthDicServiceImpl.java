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
	public List<Map<String, Object>> getbookmarkHealthDic(String healthName, int member_no, int minute){
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
}
