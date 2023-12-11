package xyz.teamcarrot.myct.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardServiceImpl implements BoardService {
	
	/* Autowired는 지정된 클래스(BoardMapper)의 빈(Bean)을 자동으로 연결해줌
	 * 스프링컨테이너의 빈 컨테이너에 주입해준다는 뜻
	 * 즉, 스프링이 알아서 의존성을 주입을 해준다. DI가 여기서 나옴
	 * Autowired를 사용함으로써 코드의 결합도를 낮추고 응집도를 높일 수 있음
	 * */
	
	/* 빈(Bean)은 쉽게 말해서 클래스의 객체이다
	 * 스프링에 의해 인스턴스화, 관리 된다.
	 * impl은 인터페이스 구현 객체이다.
	 * */
	@Autowired
	private BoardMapper mapper;
	
	/* 게시판 등록 */
	@Override
	public void enroll(BoardVO board) {
		mapper.enroll(board);

	}
	
	/* 게시판 삭제 */
    @Override
    public int delete(int board_no) {
        
        return mapper.delete(board_no);
    }    
	
	/*게시판 목록*/
	@Override
	public List<BoardVO> getList() {
		
		return mapper.getList();
	}
	
	/*게시판 조회*/
	@Override
	public BoardVO getPage(int board_no) {
			
		return mapper.getPage(board_no);
	}
	
	 /* 게시판 수정 */
    @Override
    public int modify(BoardVO board) {
        
        return mapper.modify(board);
    }
    
    /* 게시판 목록(페이징 적용) */
    @Override
    public List<BoardVO> getListPaging(Criteria cri) {
        
        return mapper.getListPaging(cri);
    }    
    
    /* 게시물 총 갯수 */
    @Override
    public int getTotal(Criteria cri) {
        
        return mapper.getTotal(cri);
    }    
}
