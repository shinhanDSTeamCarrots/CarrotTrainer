package xyz.teamcarrot.myct.healthInfo;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;
import xyz.teamcarrot.myct.member.MemberVO;
@Slf4j
@Controller
public class FoodDiaryController {
	
	@Autowired
	private DiaryService service;
	@Autowired
	private BodyInfoService bodyInfoservice;
	
	@GetMapping("healthInfo/foodDiary")
	public String FoodDiary(Model model, HttpSession sess) {
		MemberVO mem = (MemberVO)sess.getAttribute("loginInfo");
		
		if (mem != null) {
			model.addAttribute("foodDiary", service.selectFoodDiary(mem.getMember_no()));
			model.addAttribute("foodCal", service.selectFoodCal(mem.getMember_no()));
			//log.info(""+service.selectFoodCal(mem.getMember_no()).toString());
			model.addAttribute("bodyInfo", bodyInfoservice.selectBodyInfo(mem.getMember_no()));
		}
		
		return "/healthInfo/foodDiary";
	}
}
