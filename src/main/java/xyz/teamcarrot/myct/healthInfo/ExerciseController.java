package xyz.teamcarrot.myct.healthInfo;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import xyz.teamcarrot.myct.member.MemberVO;

@Slf4j
@Controller
public class ExerciseController {
	
	@Autowired
	HealthDicService service;
	
	//리스트 출력
	@GetMapping("/exercise")
	public String searchHealthInfo(Model model, HttpSession sess, String healthName, Integer minute, Integer page) {
		int pageNumber = (page != null) ? page : 1;
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
			model.addAttribute("healthDic", service.getHealthDic(healthName, member_no, minute, pageNumber));
			model.addAttribute("healthName", healthName);
		}else {
			if(healthName == null || healthName.equals("")) {
				//로그인 && 검색 안함 -> 즐찾
				Map<String, Object> bookmarks = service.getBookmarkHealthDic(healthName, member_no, minute, pageNumber);
				model.addAttribute("healthDic", bookmarks);
			}else {
				//로그인 && 검색함 -> 일반 검색
				model.addAttribute("healthDic", service.getHealthDic(healthName, member_no, minute, pageNumber));
				model.addAttribute("healthName", healthName);
			}
		}
		//확인
		System.out.println(healthName);
		System.out.println(minute);

		return "/healthInfo/exercise";
	}

	@ResponseBody
	@PostMapping("healthInfo/insertBookmark")
	public String addBookmark(HealthBookmarkVO vo, Model model, HttpSession sess) {
		log.debug("북마크함수 컨트롤러 추가");
		
		MemberVO mem = (MemberVO)sess.getAttribute("loginInfo");
		if (mem != null) {
			vo.setMember_no(mem.getMember_no());
			model.addAttribute("healthNo", service.addBookmark(vo));
			
			return "success";
		} else {
			model.addAttribute("cmd", "back");
			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/login");
			
			return "common/alert";
		}
	}
	@ResponseBody
	@PostMapping("healthInfo/deleteBookmark")
	public String delBookmark(@RequestParam("health_bookmark_no") Integer health_bookmark_no, Model model, HttpSession sess) {
		log.debug("북마크함수 컨트롤러 삭제");
		
		MemberVO mem = (MemberVO)sess.getAttribute("loginInfo");
		if (mem != null) {
			service.delBookmark(health_bookmark_no);
			
			return "success";
		} else {
			model.addAttribute("cmd", "back");
			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/login");
			
			return "common/alert";
		}
	}
	@PostMapping("healthInfo/insertHealthInfo")
	public String insertHealthInfo(HealthDiaryVO vo, Model model, HttpSession sess) {
		MemberVO mem = (MemberVO)sess.getAttribute("loginInfo");
		vo.setMember_no(mem.getMember_no());
		boolean healthInfo = service.insertHealthInfo(vo);
		
		if(healthInfo) {
			model.addAttribute("cmd", "move");
			model.addAttribute("msg", "정보가 등록되었습니다!");
			model.addAttribute("url", "/myct/exercise");
		} else {
			model.addAttribute("cmd", "back");
			model.addAttribute("msg", "정보 등록 실패");
		}
		return "/common/alert";
	}
	@PostMapping("healthInfo/updateHealthInfo")
	public String updateHealthInfo(Model model, HealthDiaryVO vo) {
		int no = service.updateHealthInfo(vo);
		
		String msg = "";
		String url = "/myct/exercise";

		if(no > 0) {
			msg = "수정되었습니다.";
		} else {
			msg = "수정 오류";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		model.addAttribute("cmd", "move");

		return "common/alert";
	}
	@PostMapping("healthInfo/deleteHealthInfo")
	public String deleteHealthInfo(Model model, HealthDiaryVO vo) {
		int no = service.deleteHealthInfo(vo);
		
		String msg = "";
		String url = "/myct/exercise";

		if(no > 0) {
			msg = "삭제되었습니다.";
		} else {
			msg = "삭제 오류";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		model.addAttribute("cmd", "move");

		return "common/alert";
	}
}
