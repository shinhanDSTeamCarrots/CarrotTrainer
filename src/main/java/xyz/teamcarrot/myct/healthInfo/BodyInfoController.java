package xyz.teamcarrot.myct.healthInfo;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class BodyInfoController {
	
	@Autowired
	private BodyInfoService service;
	
	@PostMapping("/bmi.do")
	public String bmi(BodyInfoVO vo, Model model, HttpSession sess) {
		boolean insertBodyInfo= service.insertBodyInfo(vo);
		if() { //세션에 로그인된 정보가 있으면
			model.addAttribute("cmd", "move");
			model.addAttribute("msg", "");
			model.addAttribute("url", "/healthInfo/bmi");
			return "/common/alert";
		} else { //비회원일 경우
			sess.setAttribute("bodyInfo", insertBodyInfo);
			return "/healthInfo/bmi";
		}
	}
}
