package xyz.teamcarrot.myct.board;

import java.util.List;

import org.springframework.stereotype.Service;

/* 
 * Service는 추상적인 정의를 제공하는 클래스이다. 인터페이스 구현체
 * 클라이언트 요청을 처리하고 필요할 경우 Mapper를 호출함 
 * Service -> Mapper -> ServiceImpl   (SMS 라고 순서를 외우면 편해진다.)
 * 
 * */

@Service
public interface BoardService {
	
	/*게시판 등록*/
	public void enroll(BoardVO board);
	
	/* 게시판 삭제 */
    public int delete(int board_no);
    
	/*게시판 목록 */
	public List<BoardVO> getList();
	
	/*게시판 조회*/
	public BoardVO getPage(int board_no);
	
	 /* 게시판 수정 */
    public int modify(BoardVO board);
    
    /* 게시판 목록(페이징 적용) */
    public List<BoardVO> getListPaging(Criteria cri);
    
    /* 게시판 총 갯수 */
    public int getTotal(Criteria cri);
}
