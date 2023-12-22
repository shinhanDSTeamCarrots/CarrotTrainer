package xyz.teamcarrot.myct.healthInfo;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import xyz.teamcarrot.myct.member.MemberVO;

@Controller
public class ExerciseController {
	
	@Autowired
	HealthDicService service;
	
	//리스트 출력
	@GetMapping("/exercise")
	public String searchHealthInfo(Model model, HttpSession sess, String healthName,Integer minute) {
		MemberVO mem = (MemberVO)sess.getAttribute("loginInfo");
		//member_no 확인용
		int member_no = -1;
		if(mem != null) {
			member_no = mem.getMember_no();
		}
		
		if(minute == null ) {
			minute=60;
		}
		
		//기능별 분리
		if(mem == null) { 	//비로그인
			model.addAttribute("healthDic", service.getHealthDic(healthName, member_no, minute));
			model.addAttribute("healthName", healthName);
		}else {
			if(healthName == null) {
				//로그인 && 검색 안함 -> 즐찾
				List<Map<String, Object>> bookmarks = service.getbookmarkHealthDic(healthName, member_no, minute);
				model.addAttribute("healthDic", bookmarks);
			}else {
				//로그인 && 검색함 -> 일반 검색
				model.addAttribute("healthDic", service.getHealthDic(healthName, member_no, minute));
				model.addAttribute("healthName", healthName);
			}
		}
		//확인
		System.out.println(healthName);
		System.out.println(minute);

		return "/healthInfo/exercise";
	}
	//즐겨찾기에 있는 운동인지 확인
	@GetMapping("/checkBookmark")
	public Boolean checkBookmark(Integer no) {
		return null;
	}
}
