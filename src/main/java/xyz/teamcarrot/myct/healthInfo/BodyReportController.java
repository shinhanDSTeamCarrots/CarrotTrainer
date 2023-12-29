package xyz.teamcarrot.myct.healthInfo;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import xyz.teamcarrot.myct.member.MemberVO;
@Slf4j
@Controller
public class BodyReportController {
	
	@Autowired
	BodyChangeService service;
	
	
	@GetMapping("/bodyReport")
	public ModelAndView bmi(HttpSession sess) {
		ModelAndView mav = new ModelAndView();
		
		MemberVO login = (MemberVO) sess.getAttribute("loginInfo");
		if(login == null) {

			mav.addObject("cmd", "move");
			mav.addObject("msg", "로그인이 필요합니다.");
			mav.addObject("url", "member/login");
			mav.setViewName("common/alert");
			return mav;
		}
		
		//mav.addObject("foodGraph",service.selectWeekFoodGraph(login.getMember_no()));
		//mav.addObject("healthGraph",service.selectWeekHealthGraph(login.getMember_no()));
		mav.addObject("foodGraphJson", service.JsonWeekFoodGraph(login.getMember_no()));
		mav.addObject("healthGraphJson", service.JsonWeekHealthGraph(login.getMember_no()));
		mav.addObject("bodyGraphJson", service.jsondailyAvgWeight(login.getMember_no()));
		
		mav.setViewName("/healthInfo/bodyReport");
		return mav;
	}
}
