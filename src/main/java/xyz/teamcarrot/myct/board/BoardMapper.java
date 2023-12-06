package xyz.teamcarrot.myct.board;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardMapper {
	/*게시판 등록*/
	public void enroll(BoardVO board);
	
	/*게시판 목록*/
	public List<BoardVO> getList();
	
	/*게시판 조회*/
	public BoardVO getPage(int board_no);
}
