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
public class FoodController {

	@Autowired
	HealthDicService service;
	
	//리스트 출력
	@GetMapping("healthInfo/food")
	public String searchFoodInfo(Model model, HttpSession sess, String foodName, Integer page) {
		int pageNumber = (page != null) ? page : 1;
		MemberVO mem = (MemberVO)sess.getAttribute("loginInfo");
		//member_no 확인용
		int member_no = -1;
		if(mem != null) {
			member_no = mem.getMember_no();
		}
		//기능별 분리
		if(mem == null) { 	//비로그인
			model.addAttribute("foodDic", service.getFoodDic(foodName, member_no, pageNumber));
			model.addAttribute("foodName", foodName);
		}else {
			if(foodName == null) {
				//로그인 && 검색 안함 -> 즐찾
				Map<String, Object> bookmarks = service.getBookmarkFoodDic(foodName, member_no, pageNumber);
				model.addAttribute("foodDic", bookmarks);
			}else {
				//로그인 && 검색함 -> 일반 검색
				model.addAttribute("foodDic", service.getFoodDic(foodName, member_no, pageNumber));
				model.addAttribute("foodName", foodName);
			}
		}
		//확인
		System.out.println(foodName);

		return "/healthInfo/food";
	}
	@ResponseBody
	@PostMapping("healthInfo/insertFoodBookmark")
	public String addFoodBookmark(FoodBookmarkVO vo, Model model, HttpSession sess) {
		log.debug("북마크함수 컨트롤러 추가");
		
		MemberVO mem = (MemberVO)sess.getAttribute("loginInfo");
		if (mem != null) {
			vo.setMember_no(mem.getMember_no());
			model.addAttribute("foodNo", service.addFoodBookmark(vo));
			
			return "success";
		} else {
			model.addAttribute("cmd", "back");
			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/login");
			
			return "common/alert";
		}
	}
	@ResponseBody
	@PostMapping("healthInfo/deleteFoodBookmark")
	public String delFoodBookmark(@RequestParam("food_bookmark_no") Integer food_bookmark_no, Model model, HttpSession sess) {
		log.debug("북마크함수 컨트롤러 삭제");
		
		MemberVO mem = (MemberVO)sess.getAttribute("loginInfo");
		if (mem != null) {
			service.delFoodBookmark(food_bookmark_no);
			
			return "success";
		} else {
			model.addAttribute("cmd", "back");
			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/login");
			
			return "common/alert";
		}
	}
	@PostMapping("healthInfo/insertFoodDiary")
	public String insertFoodDiary(HealthDiaryVO vo, Model model, HttpSession sess) {
		MemberVO mem = (MemberVO)sess.getAttribute("loginInfo");
		vo.setMember_no(mem.getMember_no());
		boolean foodDiary = service.insertFoodDiary(vo);
		
		if(foodDiary) {
			model.addAttribute("cmd", "move");
			model.addAttribute("msg", "정보가 등록되었습니다!");
			model.addAttribute("url", "diary");
		} else {
			model.addAttribute("cmd", "back");
			model.addAttribute("msg", "정보 등록 실패");
		}
		return "/common/alert";
	}
	@PostMapping("healthInfo/insertFoodInfo")
	public String insertHealthInfo(HealthDiaryVO vo, Model model, HttpSession sess) {
		MemberVO mem = (MemberVO)sess.getAttribute("loginInfo");
		vo.setMember_no(mem.getMember_no());
		boolean foodInfo = service.insertFoodInfo(vo);
		
		if(foodInfo) {
			model.addAttribute("cmd", "move");
			model.addAttribute("msg", "정보가 등록되었습니다!");
			model.addAttribute("url", "diary");
		} else {
			model.addAttribute("cmd", "back");
			model.addAttribute("msg", "정보 등록 실패");
		}
		return "/common/alert";
	}
}
