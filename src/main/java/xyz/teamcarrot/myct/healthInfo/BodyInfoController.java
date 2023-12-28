package xyz.teamcarrot.myct.healthInfo;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import xyz.teamcarrot.myct.member.MemberVO;

@Controller
public class BodyInfoController {
	//테스트 작성 코드
	private static final Logger log = LoggerFactory.getLogger(BodyInfoController.class);
	
	@Autowired
	private BodyInfoService service;
	@Autowired
	private HealthDicService healthService;
	@Autowired
	private DiaryService diaryService;
	
	/*--------------
 		bmi.jsp
	--------------*/
	@GetMapping("healthInfo/bmi")
	public String bmi(Model model, HttpSession sess) {
		MemberVO mem = (MemberVO)sess.getAttribute("loginInfo");
		
		if (mem != null) {
			model.addAttribute("bodyInfo", service.selectBodyInfo(mem.getMember_no()));
		}
		return "/healthInfo/bmi";
	}
	@PostMapping("healthInfo/insertBodyInfo")
	public String insertBodyInfo(BodyInfoVO vo, Model model, HttpSession sess) {
		log.debug("체크");
		MemberVO mem = (MemberVO)sess.getAttribute("loginInfo");
		vo.setMember_no(mem.getMember_no());
		boolean bodyInfo = service.insertBodyInfo(vo);
		
		if(bodyInfo) {
			model.addAttribute("cmd", "move");
			model.addAttribute("msg", "정보가 등록되었습니다!");
			model.addAttribute("url", "/healthInfo/bmi");
		} else {
			model.addAttribute("cmd", "back");
			model.addAttribute("msg", "정보 등록 실패");
		}
		return "/common/alert";
	}
	@PostMapping("healthInfo/updateBodyInfo")
	public String updateBodyInfo(Model model, BodyInfoVO vo) {
		int no = service.updateBodyInfo(vo);
		
		String msg = "";
		String url = "/healthInfo/bmi";

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
	
	/*--------------
	 	diary.jsp
	--------------*/
	@GetMapping("healthInfo/diary")
	public String diary(Model model, HttpSession sess) {
		MemberVO mem = (MemberVO)sess.getAttribute("loginInfo");
		
		if (mem != null) {
			model.addAttribute("healthDiary", healthService.selectHealthInfo(mem.getMember_no()));
			model.addAttribute("foodDiary", diaryService.selectFoodDiary(mem.getMember_no()));
			model.addAttribute("bodyInfo", service.selectBodyInfo(mem.getMember_no()));
			model.addAttribute("bodyChange", service.selectBodyChange(mem.getMember_no()));
		}
		return "/healthInfo/diary";
	}
	@PostMapping("healthInfo/insertBodyChange")
	public String insertBodyChange(Model model, BodyChangeVO vo, HttpSession sess) {
		MemberVO mem = (MemberVO)sess.getAttribute("loginInfo");
		
		//log.info("db 데이터 입력 테스트");
		if (mem != null) { // 정상적으로 DB에 insert
			vo.setMember_no(mem.getMember_no());
			model.addAttribute("bodyChange", service.insertBodyChange(vo));
			model.addAttribute("cmd", "move");
			model.addAttribute("msg", "등록되었습니다.");
			model.addAttribute("url", "/healthInfo/diary");
		} else { // 비로그인일 경우 > confirm알라트로 변경!
			model.addAttribute("cmd", "back");
			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/login");
		}
		return "common/alert";
	}
	@PostMapping("healthInfo/updateBodyChange")
	public String updateBodyChange(Model model, BodyChangeVO vo) {
		int no = service.updateBodyChange(vo);
		
		String msg = "";
		String url = "/healthInfo/diary";

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
	@PostMapping("healthInfo/deleteBodyChange")
	public String deleteBodyChange(Model model, BodyChangeVO vo) {
		int no = service.deleteBodyChange(vo);
		
		String msg = "";
		String url = "/healthInfo/diary";

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
