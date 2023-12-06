package xyz.teamcarrot.myct.board;

import java.util.List;

import org.springframework.stereotype.Service;

@Service
public interface BoardService {
	/*게시판 등록*/
	public void enroll(BoardVO board);
		
	/*게시판 목록 */
	public List<BoardVO> getList();
	
	/*게시판 조회*/
	public BoardVO getPage(int board_no);
}
