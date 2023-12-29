package xyz.teamcarrot.myct.healthInfo;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import xyz.teamcarrot.myct.member.MemberVO;

@Controller
public class BodyReportController {
	@GetMapping("healthInfo/bodyReport")
	public String bodyReport(Model model, HttpSession sess) {
		MemberVO mem = (MemberVO)sess.getAttribute("loginInfo");
		
		if (mem != null) {
			return "/healthInfo/bodyReport";
		} else {
			model.addAttribute("cmd", "back");
			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/login");
			
			return "common/alert";
		}
	}
}
