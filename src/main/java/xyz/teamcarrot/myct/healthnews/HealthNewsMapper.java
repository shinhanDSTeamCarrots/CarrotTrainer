package xyz.teamcarrot.myct.healthnews;

import org.apache.ibatis.annotations.Mapper;

import xyz.teamcarrot.myct.board.BoardFileVO;

@Mapper
public interface HealthNewsMapper {
	public void saveFile(BoardFileVO vo);
	
}
