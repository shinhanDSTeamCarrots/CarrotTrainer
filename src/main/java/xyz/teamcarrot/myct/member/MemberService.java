package xyz.teamcarrot.myct.member;

import java.util.List;

import javax.servlet.http.HttpSession;

public interface MemberService {
	boolean dupId(String id);

	boolean regist(MemberVO vo);

	MemberVO login(MemberVO vo);

	int update(MemberVO vo);

	MemberVO detail(MemberVO vo);

	boolean deleteMember(String member_id, String member_pw);

	void updateLoginFailCount(MemberVO member, HttpSession sess);

	void updateLoginBlocked(MemberVO member, HttpSession sess);

}
