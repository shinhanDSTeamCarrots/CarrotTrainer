package xyz.teamcarrot.myct.board;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardMapper {
	/*�Խ��� ���*/
	public void enroll(BoardVO board);
	
	/*�Խ��� ���*/
	public List<BoardVO> getList();
	
	/*�Խ��� ��ȸ*/
	public BoardVO getPage(int board_no);
}
