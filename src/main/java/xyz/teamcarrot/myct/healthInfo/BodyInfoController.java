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
	
	//@ResponseBody
	/*
	@PostMapping("/bmiResult.do")
	public String bmiResult() {
		return "/healthInfo/bmi";
	}*/
	
	@GetMapping("/bmi")
	public String bmi() {
		return "/healthInfo/bmi";
	}
	
	/*
	@GetMapping("/bmiResult.do")
	public String bmiResult() {
		return "/healthInfo/bmi";
	}
	
	@PostMapping("/bmiResult.do")
	public String bmi2(BodyInfoVO vo, Model model, HttpSession sess) {
		boolean insertBodyInfo= service.insertBodyInfo(vo);
		MemberVO mem = (MemberVO)sess.getAttribute("loginInfo");
		if(mem != null) { //세션에 로그인된 정보가 있으면
			model.addAttribute("cmd", "move");
			model.addAttribute("msg", "정보가 등록되었습니다!");
			model.addAttribute("url", "/healthInfo/bmi");
			return "/common/alert";
		} else { //비회원일 경우
			//sess.setAttribute("bodyInfo", insertBodyInfo);
			return "redirect:/";
		}
	}*/
	@GetMapping("/diary")
	public String diary(Model model, HttpSession sess) {
		MemberVO mem = (MemberVO)sess.getAttribute("loginInfo");
		
		if (mem != null) {
			model.addAttribute("bodyChange", service.selectBodyChange(mem.getMember_no()));
		}
		return "/healthInfo/diary";
	}
	@PostMapping("/insertBodyChange")
	public String insertBodyChange(Model model, BodyChangeVO vo, HttpSession sess) {
		MemberVO mem = (MemberVO)sess.getAttribute("loginInfo");
		
		//log.info("db 데이터 입력 테스트");
		if (mem != null) { // 정상적으로 DB에 insert
			vo.setMember_no(mem.getMember_no());
			model.addAttribute("bodyChange", service.insertBodyChange(vo));
			model.addAttribute("cmd", "move");
			model.addAttribute("msg", "등록되었습니다.");
			model.addAttribute("url", "/myct/diary");
		} else { // 비로그인일 경우 > confirm알라트로 변경!
			model.addAttribute("cmd", "back");
			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/login");
		}
		return "common/alert";
	}
}
