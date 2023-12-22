package xyz.teamcarrot.myct.member;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;
	// 객체를 자동으로 생성해 주는 역할

	@GetMapping("/member/join")
	public String test() {
		return "member/join";
	}

	@ResponseBody
	@GetMapping("/member/idCheck")
	public String idCheck(@RequestParam String id) {
		boolean r = memberService.dupId(id);
		return String.valueOf(r);
	}

	@PostMapping("/member/regist")
	public String regist(MemberVO vo) {
		memberService.regist(vo);
		return "member/joinInterest";
	}
	
	@GetMapping("/member/login")
	public String login() {
		return "member/login";
	}
	
	
	@PostMapping("/member/login")
	public String loginProcess(MemberVO vo, HttpSession sess, Model model,
			@RequestParam("member_id") String member_id, 
			@RequestParam("member_pw") String member_pw) {
		
		MemberVO login = memberService.login(vo);
		int loginFail;
		
		if(login==null) {			
			model.addAttribute("msg", "아이디나 비밀번호가 틀립니다.");
			model.addAttribute("cmd", "back");
			if(sess.getAttribute("loginFail")==null) {
				sess.setAttribute("loginFail", 0);
			}
			loginFail = (Integer)sess.getAttribute("loginFail");
		
			sess.setAttribute("loginFail", loginFail+1);
			
			if ((Integer)sess.getAttribute("loginFail") >= 4) {
				model.addAttribute("msg", "로그인 시도 가능 횟수를 초과하였습니다. 비밀번호 찾기를 먼저 해주세요.");
				model.addAttribute("cmd", "move");
				model.addAttribute("url", "memberFind");
			} else {
				model.addAttribute("msg", "아이디나 비밀번호가 틀립니다." + "(로그인 실패 횟수: " + loginFail + "/5)");
				model.addAttribute("cmd", "back");			
			}
			return "common/alert";
		} else {
			sess.setAttribute("loginInfo", login);
			return "redirect:/";			
		}
		
	}

	@GetMapping("/member/logout")
	public String logout(Model model, HttpSession sess) {
		sess.removeAttribute("loginInfo");
		return "redirect:/"; // home.jsp 파일이랑 연결됨
	}
	
	@GetMapping("/member/joinAgree")
	public String joinAgree() {
		return "member/joinAgree";
	}

	@GetMapping("/member/joinOath")
	public String test4() {
		return "member/joinOath";
	}

	@GetMapping("/member/memberDel")
	public String deleteMember() {
		return "member/memberDel";
	}

	@RequestMapping(value = "/member/memberDel", method = { RequestMethod.POST })
	public String deleteMember(@RequestParam("member_id") String member_id, @RequestParam("member_pw") String member_pw,
			Model model, HttpSession sess) {
		// 비밀번호 일치 여부 확인 및 회원 삭제
		boolean isDeleted = memberService.deleteMember(member_id, member_pw);

		if (isDeleted) {
			// 회원 삭제 성
			sess.invalidate();
			return "redirect:/"; // 로그아웃 페이지로 이동하거나, 다른 적절한 처리를 수행
		} else {
			// 회원 삭제 실패

			model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
			return "member/memberDel"; // 실패 시 탈퇴 페이지로 이동 또는 적절한 처리
		}
	}
	
	@ResponseBody
	@GetMapping("/member/nicknameCheck")
	public String nicknameCheck(@RequestParam String nickname) {
		boolean r = memberService.dupNickname(nickname);
		return String.valueOf(r);
	}

	@GetMapping("/member/memberEdit")
	public String memberEdit() {
		return "member/memberEdit";
	}

	@PostMapping("/member/memberEdit")
	public String memberEdit2(HttpSession sess, Model model) {
		MemberVO uv = (MemberVO) sess.getAttribute("loginInfo");
		model.addAttribute("vo", memberService.detail(uv));
		return "redirect:/";
	}

	@PostMapping("/member/update")
	public String update(@RequestParam("member_no") int member_no, MemberVO vo, Model model) {
		int r = memberService.update(vo);
		String msg = "";
		String url = "edit";
		if (r > 0) {
			msg = "정상적으로 수정되었습니다.";
		} else {
			msg = "수정 오류";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		model.addAttribute("cmd", "move");
		return "redirect:/";
	}

	@GetMapping("/member/memberFind")
	public String test7() {
		return "member/memberFind";
	}
}
