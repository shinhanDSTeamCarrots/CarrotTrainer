package xyz.teamcarrot.myct.member;

public interface MemberService {
	boolean dupId(String id);
	boolean regist(MemberVO vo);
	MemberVO login(MemberVO vo);
	int update(MemberVO vo);
}
