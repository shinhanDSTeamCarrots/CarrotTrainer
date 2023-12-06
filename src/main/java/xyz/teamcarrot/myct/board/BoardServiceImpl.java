package xyz.teamcarrot.myct.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardMapper mapper;
	
	@Override
	public void enroll(BoardVO board) {
		mapper.enroll(board);

	}
	
	/*게시판 목록*/
	@Override
	public List<BoardVO> getList() {
		
		return mapper.getList();
	}
	
	@Override
	public BoardVO getPage(int board_no) {
		
		return mapper.getPage(board_no);
	}
}
