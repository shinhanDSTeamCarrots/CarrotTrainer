package xyz.teamcarrot.myct.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface MemberMapper {
	int dupId(String id);

	int regist(MemberVO vo);

	MemberVO login(MemberVO vo);

	MemberVO detail(int no);

	int update(MemberVO vo);
	
	int deleteMember(MemberVO vo);

	int dupNickname(String nickname);
	
	MemberVO findByUsername(String member_id);

	void updateLoginFailCount(@Param("member") MemberVO member);

	Integer updateLoginBlocked(MemberVO member);
	
	int memberInterest(InterestVO vo);
	
	List<MemberVO> all(MemberVO vo);
	
}
