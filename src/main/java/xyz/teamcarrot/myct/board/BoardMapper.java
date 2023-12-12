package xyz.teamcarrot.myct.board;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardMapper {
	/*게시판 등록*/
	public void enroll(BoardVO board);
	
	/* 게시판 삭제 */
    public int delete(int board_no);
	
	/*게시판 목록*/
	public List<BoardVO> getList();

	/* 게시판 목록(페이징 적용) 
	 * List로 선언한 이유는 배열의 경우 크기가 10개로 정해졌다면, 10개를 초과하는 값을 담을 수 없는데
	 * List는 10개의 크기로 설정해도 11번째 값을 저장할 때 동적으로 그 크기가 커진다.*/
    public List<BoardVO> getListPaging(Criteria cri);
	
	/*게시판 조회*/
	public BoardVO getPage(int board_no);
	
	/*게시판 수정*/
	public int modify(BoardVO board);	
	
    /* 게시판 총 갯수 */
    public int getTotal(Criteria cri);
    
    
}
