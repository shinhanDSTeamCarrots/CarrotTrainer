/* Created:		23.12.15
 * Author:		전성욱
 * Description:	어드민 컨트롤러
 * Edited:		
 * (c) Copyright by TeamCarrot
 */
package xyz.teamcarrot.myct.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
public class AdminPageController {
	
	@GetMapping("admin")
	public ModelAndView topPage(HttpServletRequest request, HttpSession sess) {
		ModelAndView mav = new ModelAndView();
		
		
		//관리자 페이지 로그인 정보 확인
		
		
		
		
		
		
		
		
		
		
		
		return mav;
		
	}
	
	
	@GetMapping("admin/login")
	public ModelAndView adminLogin(HttpServletRequest request, HttpSession sess) {
		ModelAndView mav = new ModelAndView();
		
		
		//관리자 페이지 로그인 페이지 연동
		
		
		
		
		
		
		
		
		
		
		
		
		return mav;
		
	}
	@ResponseBody
	@PostMapping("admin/login")
	public String postAdminLogin(HttpServletRequest request, HttpSession sess) {
		
		
		
		//관리자 페이지 로그인 동작
		
		
		
		
		
		return "T";
		
	}
	
	@GetMapping("admin/logout")
	public ModelAndView adminLogout(HttpServletRequest request, HttpSession sess) {
		ModelAndView mav = new ModelAndView();
		
		//홈페이지 메인으로
		
		sess.invalidate();
		
		
		mav.setViewName("redirect:/");
		
		
		
		
		
		
		
		return mav;
		
	}
	
	
	
}
