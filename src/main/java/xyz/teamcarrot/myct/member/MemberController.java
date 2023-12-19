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

	@PostMapping("/member/regist.do")
	public String regist(MemberVO vo) {
		memberService.regist(vo);
		return "member/joinInterest";
	}
	/*
	 * @PostMapping("/member/interestregist.do") public String
	 * interestRegist(@RequestParam String mem_no, MemberVO vo) { //interest VO 를
	 * 만들어서 //insert 한다 memberService.insertInterest(vo); return "/"; }
	 */
	/*
	 * @GetMapping("/member/joinInterest.do") public String test2() { return
	 * "member/joinInterest"; }
	 */

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
	// postmapping 부분만 있었을 땐 로그인 홈페이지로 접속 안되고 alert만 뜨는 오류 발생
	// getmapping으로 따로 만들어줘야 하는 이유는..?

	@PostMapping("/member/login.do")
	public String loginProcess(MemberVO vo, HttpSession sess, Model model,
			@RequestParam("member_pw") String member_pw) {
		MemberVO login = memberService.login(vo);
		// sess.setAttribute("loginFail", 0);
		if (login.getMember_loginFailCnt() >= 4) {
			model.addAttribute("msg", "로그인 시도 가능 횟수를 초과하였습니다. 비밀번호 찾기를 먼저 해주세요.");
			model.addAttribute("cmd", "move");
			model.addAttribute("url", "memberFind.do");
			return "member/alert";
		} else if (login == null) { // 로그인 실패
			model.addAttribute("msg", "아이디가 올바르지 않습니다.");
			model.addAttribute("cmd", "back");
			return "member/alert";
		} else if (!member_pw.equals(login.getMember_pw())) {
			int loginFail = login.getMember_loginFailCnt(); // 수정된 부분
			login.setMember_loginFailCnt(loginFail + 1);
			memberService.updateLoginFailCount(login, sess);
			sess.setAttribute("loginFail", (int) sess.getAttribute("loginFail") + 1);
			model.addAttribute("msg", "잘못된 비밀번호입니다." + "(로그인 실패 횟수: " + login.getMember_loginFailCnt() + "/5)");
			model.addAttribute("cmd", "back");

			// 추가 부분
			if (loginFail == 4) {
				int loginBlocked = login.getMember_blocked();
				login.setMember_loginBlocked(loginBlocked + 1);
				sess.setAttribute("loginBlocked", 1);
				memberService.updateLoginBlocked(login, sess);
				model.addAttribute("msg", "로그인 시도 가능 횟수를 초과하였습니다. 아이디/비밀번호 찾기 창으로 이동합니다.");
				model.addAttribute("cmd", "move");
				model.addAttribute("url", "memberFind.do");
				return "member/alert";
			}
			return "member/alert";
		} else {
			return "redirect:/";
		}
	}

	@GetMapping("/member/logout.do")
	public String logout(Model model, HttpSession sess) {
		sess.removeAttribute("loginInfo");
		return "redirect:/"; // home.jsp 파일이랑 연결됨
	}

	@GetMapping("/member/joinOath.do")
	public String test4() {
		return "member/joinOath";
	}

	@GetMapping("/member/memberDel.do")
	public String deleteMember() {
		return "member/memberDel";
	}

	@RequestMapping(value = "/member/memberDel.do", method = { RequestMethod.POST })
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

	@GetMapping("/member/memberEdit.do")
	public String memberEdit() {
		return "member/memberEdit";
	}

	@PostMapping("/member/memberEdit.do")
	public String memberEdit2(HttpSession sess, Model model) {
		MemberVO uv = (MemberVO) sess.getAttribute("loginInfo");
		model.addAttribute("vo", memberService.detail(uv));
		return "redirect:/";
	}

	@PostMapping("/member/update.do")
	public String update(@RequestParam("member_no") int member_no, MemberVO vo, Model model) {
		int r = memberService.update(vo);
		String msg = "";
		String url = "edit.do";
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

	@GetMapping("/member/memberFind.do")
	public String test7() {
		return "member/memberFind";
	}
}
