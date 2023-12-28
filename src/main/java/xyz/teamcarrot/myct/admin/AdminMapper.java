package xyz.teamcarrot.myct.admin;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminMapper {
	AdminVO selectLogin(AdminVO vo);
}
