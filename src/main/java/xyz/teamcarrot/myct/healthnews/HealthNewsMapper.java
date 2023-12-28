package xyz.teamcarrot.myct.healthnews;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import xyz.teamcarrot.myct.board.BoardFileVO;

@Mapper
public interface HealthNewsMapper {
	public void saveFile(BoardFileVO vo);
	
	public void saveImg(BoardFileVO vo);
	
	
	

    // 특정 게시글(board_no)에 연결된 이미지 정보 조회
    List<BoardFileVO> findImagesByBoardNo(int board_no);
}
