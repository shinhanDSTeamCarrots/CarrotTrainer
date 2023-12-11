package xyz.teamcarrot.myct.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;
	// 객체를 자동으로 생성해 주는 역할

	@GetMapping("/member/join.do")
	public String test() {
		return "member/join";
	}

	@ResponseBody
	@GetMapping("/member/idCheck.do")
	public String idCheck(@RequestParam String id) {
		boolean r = memberService.dupId(id);
		return String.valueOf(r);
	}

	
	@GetMapping("home.do")
	public String homeTest() {
		return "home";
	}
	

	@GetMapping("/member/join2.do")
	public String test2() {
		return "member/join2";
	}

	/*
	 * @GetMapping("/member/login.do") public String loginProcess(MemberVO vo,
	 * HttpSession sess, Model model) { MemberVO login = memberService.login(vo); if
	 * (login == null) { // 로그인실패 model.addAttribute("msg",
	 * "아이디나 비밀번호가 올바르지 않습니다."); model.addAttribute("cmd", "back"); return
	 * "member/alert"; } else { // 로그인성공 sess.setAttribute("loginInfo", login);
	 * return "member/memberDel"; } }
	 */
	@GetMapping("/member/login.do")
	public String login() {
		return "member/login";
	}
	//postmapping 부분만 있었을 땐 로그인 홈페이지로 접속 안되고 alert만 뜨는 오류 발생
	//getmapping으로 따로 만들어줘야 하는 이유는..?

	@PostMapping("/member/login.do")
	public String loginProcess(MemberVO vo, HttpSession sess, Model model) {		
		MemberVO login = memberService.login(vo);
		if (login == null) { // 로그인실패
			model.addAttribute("msg", "아이디나 비밀번호가 올바르지 않습니다.");
			model.addAttribute("cmd", "back");
			return "member/alert";
		} else { // 로그인성공			
			sess.setAttribute("loginInfo", login);
			return "home";
		}
	}
	
	@GetMapping("/member/logout.do")
	public String logout(Model model, HttpSession sess) {
//		sess.removeAttribute("loginInfo");
		sess.invalidate();
		return "home"; //home.jsp 파일이랑 연결됨
	}

	@GetMapping("/member/join_naverKakao.do")
	public String test4() {
		return "member/join_naverKakao";
	}

	@GetMapping("/member/memberDel.do")
	public String test5() {
		return "member/memberDel";
	}

	@GetMapping("/member/memberEdit.do")
	public String test6() {
		return "member/memberEdit";
	}

	@GetMapping("/member/memberFind.do")
	public String test7() {
		return "member/memberFind";
	}
}
