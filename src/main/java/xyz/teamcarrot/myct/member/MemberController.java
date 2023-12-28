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
		if(login==null) {
			model.addAttribute("msg", "아이디나 비밀번호가 틀립니다.");
			model.addAttribute("cmd", "back");
			return "common/alert";
		} else {
			sess.setAttribute("loginInfo", login);
			return "redirect:/";
		}

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
			sess.invalidate();
			return "redirect:/";
		} else {
			// 회원 삭제 실패

			model.addAttribute("msg", "아이디나 비밀번호가 틀립니다.");
			return "common/alert"; 
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

	/*@PostMapping("/member/memberEdit")
	public String memberEdit2(HttpSession sess, Model model) {
		MemberVO uv = (MemberVO) sess.getAttribute("loginInfo");
		model.addAttribute("vo", memberService.detail(uv));
		return "redirect:/";
	}*/
	//20231227 회원정보 업데이트하고 나면 원래 비밀번호 입력해도 로그인이 안됨
	@PostMapping("/member/memberEdit")
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
			return "redirect:/";
		} else {
			msg = "수정 오류";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			model.addAttribute("cmd", "move");
			return "common/alert";
		}
		
	}

	@GetMapping("/member/memberFind")
	public String test7() {
		return "member/memberFind";
	}

	// 20231225
	@GetMapping("/member/joinInterest")
	public String joinInterest() {
		return "member/joinInterest";
	}
	
	@PostMapping("/member/joinInterest")
	public String joinInterest(InterestVO vo, Model model) {
		vo.setMember_interest_no(0);
		return "a";
		//20231227 정보 전송 안됨..
	}

	@GetMapping("/member/userInfo")
	public String userInfo(Model model, MemberVO vo) {
		model.addAttribute("all", memberService.all(vo));
		return "member/userInfo";
	}
}
