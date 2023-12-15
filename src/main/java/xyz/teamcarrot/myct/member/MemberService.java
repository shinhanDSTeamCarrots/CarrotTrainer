package xyz.teamcarrot.myct.member;

import javax.servlet.http.HttpSession;

public interface MemberService {
	boolean dupId(String id);
	boolean regist(MemberVO vo);
	MemberVO login(MemberVO vo);
	int update(MemberVO vo);
	MemberVO detail(MemberVO vo);
	//20231212 delete 추가
	 boolean deleteMember(String member_id, String member_pw);
	 //20231214 추가
	 void updateLoginFailCount(MemberVO member, HttpSession sess);
	 void updateLoginBlocked(MemberVO member, HttpSession sess);
	 
}
