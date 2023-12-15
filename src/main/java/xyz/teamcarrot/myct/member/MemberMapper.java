package xyz.teamcarrot.myct.member;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface MemberMapper {
	int dupId(String id);
	
	int regist(MemberVO vo);
	
	MemberVO login(MemberVO vo);
	
	MemberVO detail(int no);
		
	int update(MemberVO vo);
	//20231212 delete 추가
	int deleteMember(@Param("member_id") String member_id, @Param("member_pw") String member_pw);
	//20231214 추가
	MemberVO findByUsername(String member_id);
	 void updateLoginFailCount(@Param("member") MemberVO member);
	 Integer updateLoginBlocked(MemberVO member);
}
