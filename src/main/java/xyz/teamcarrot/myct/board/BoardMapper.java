package xyz.teamcarrot.myct.board;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface BoardMapper {
	
	
	
	// 게시글 등록 (완성)
	public int enroll(BoardVO board);
	
	// 파일 정보를 저장하는 메서드 추가 (완성)
    public int enrollFile(BoardFileVO boardFile);
	
	// 게시글 삭제 (완성)
    public int delete(int board_no);
	
	// 게시글 목록(페이징X) (완성)
	public List<BoardVO> getList();

	// 게시물 목록(페이징) (완성)
    public List<BoardVO> getListPaging(Criteria cri);
	
	// 페이지 가져오기 (완성)
	public BoardVO getPage(int board_no);
	
	// 게시글 수정 (완성)
	public int modify(BoardVO board);	
	
    // 게시글 총 갯수 (완성)
    public int getTotal(Criteria cri);
    
    // 댓글 등록 메서드 (완성)
    public void replyEnroll(ReplyVO reply);

    // 특정 게시글의 답글 목록 조회 메서드 (완성)
    public List<ReplyVO> getReplies(int board_no);
    
    // 댓글 등록 (완성)
    public int insertReply(ReplyVO reply);
    
    // 조회수 (완성)
    public void updateViewCount(int board_no);
    
    // 추천수 (미완성)
    public int updateRecomCount(int board_no);
    
    // 다중 선택 (미완성)
    public void deleteSelected(List<Integer> boardNos);
    
    // 댓글 삭제 (완성)
    public int deleteReply(int replyId);
    
    // 답변 상태 (완성)
    public void updateHasReplyStatus(int board_no, boolean status);
    
    // 관리자 페이지에서 비공개 처리(완성), Param을 안쓰면 기능 동작을 안함...
    public void updatePrivateStatus(@Param("board_no") int board_no, @Param("board_private") int board_private);
    
    // 마이페이지 댓글 목록 출력(미완성)
    public List<ReplyVO> replyList();
}
