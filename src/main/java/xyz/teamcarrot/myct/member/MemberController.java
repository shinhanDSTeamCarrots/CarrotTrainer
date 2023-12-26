package xyz.teamcarrot.myct.member;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
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
		try {
			vo.setMember_pw(this.encrypt(vo.getMember_pw()));
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
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
		  try {
        vo.setMember_pw(this.encrypt(vo.getMember_pw()));
      } catch (NoSuchAlgorithmException e) {
        e.printStackTrace();
      }
		MemberVO login = memberService.login(vo);
		if (login == null) {
			if (vo.getMember_loginFailCnt() == 5) {

			}

		} else {
			if (vo.getMember_loginBlocked() == 0) {
				sess.setAttribute("loginInfo", login);
				vo.setMember_loginFailCnt(0);
				return "redirect:/";
			} else {
				model.addAttribute("msg", "차단된 사용자입니다.");
				model.addAttribute("cmd", "back");
				return "member/alert";
			}
			return "common/alert";
		} else {
			sess.setAttribute("loginInfo", login);
			return "redirect:/";	
		}
		return "redirect:/";
		/*
		 * int loginFail;
		 * 
		 * if(login==null) { model.addAttribute("msg", "아이디나 비밀번호가 틀립니다.");
		 * model.addAttribute("cmd", "back"); if(sess.getAttribute("loginFail")==null) {
		 * sess.setAttribute("loginFail", 0); } loginFail =
		 * (Integer)sess.getAttribute("loginFail");
		 * 
		 * sess.setAttribute("loginFail", loginFail+1);
		 * 
		 * if ((Integer)sess.getAttribute("loginFail") >= 4) { model.addAttribute("msg",
		 * "로그인 시도 가능 횟수를 초과하였습니다. 비밀번호 찾기를 먼저 해주세요."); model.addAttribute("cmd",
		 * "move"); model.addAttribute("url", "memberFind.do"); } else {
		 * model.addAttribute("msg", "아이디나 비밀번호가 틀립니다." + "(로그인 실패 횟수: " + loginFail +
		 * "/5)"); model.addAttribute("cmd", "back"); } return "member/alert"; } else {
		 * sess.setAttribute("loginInfo", login); return "redirect:/"; }
		 */

	}

	public String encrypt(String text) throws NoSuchAlgorithmException {
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(text.getBytes());

		return bytesToHex(md.digest());
	}

	private String bytesToHex(byte[] bytes) {
		StringBuilder builder = new StringBuilder();
		for (byte b : bytes) {
			builder.append(String.format("%02x", b));
		}
		return builder.toString();
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
	public String joinOath() {
		return "member/joinOath";
	}

	@GetMapping("/member/memberDel")
	public String deleteMember() {
		return "member/memberDel";
	}

	@PostMapping("/member/memberDel")
	public String deleteMember(MemberVO vo, Model model, HttpSession sess) {
		try {
			vo.setMember_pw(this.encrypt(vo.getMember_pw()));
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		boolean isDeleted = memberService.deleteMember(vo);
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

	@ResponseBody
	@PostMapping("/member/update")
	public String update(MemberVO vo, Model model) {

		try {
			vo.setMember_pw(this.encrypt(vo.getMember_pw()));
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
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

	// 20231225
	@GetMapping("/member/joinInterest.do")
	public String memberinterest() {
		return "member/joinInterest";
	}
	
	@GetMapping("/member/userInfo.do")
	public String userInfo(Model model, MemberVO vo) {
		model.addAttribute("all", memberService.all(vo));
		return "member/userInfo";
	}
}
