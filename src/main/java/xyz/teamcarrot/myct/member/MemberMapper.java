package xyz.teamcarrot.myct.member;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {
	int dupId(String id);
	
	int regist(MemberVO vo);
	
	MemberVO login(MemberVO vo);
	
	int update(MemberVO vo);
}
