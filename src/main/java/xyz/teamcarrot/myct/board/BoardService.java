package xyz.teamcarrot.myct.board;

import java.util.List;

import org.springframework.stereotype.Service;

@Service
public interface BoardService {
	/*�Խ��� ���*/
	public void enroll(BoardVO board);
		
	/*�Խ��� ��� */
	public List<BoardVO> getList();
	
	/*�Խ��� ��ȸ*/
	public BoardVO getPage(int board_no);
}
