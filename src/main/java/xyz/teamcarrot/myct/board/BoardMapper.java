package xyz.teamcarrot.myct.board;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface BoardMapper {
	
	
	
	// 게시글 등록
	public int enroll(BoardVO board);
	
	// 파일 정보를 저장하는 메서드 추가
    public int enrollFile(BoardFileVO boardFile);
	
	// 게시글 삭제
    public int delete(int board_no);
	
	// 게시글 목록(페이징X)
	public List<BoardVO> getList();

	// 게시물 목록(페이징)
    public List<BoardVO> getListPaging(Criteria cri);
	
	// 페이지 가져오기
	public BoardVO getPage(int board_no);
	
	// 게시글 수정
	public int modify(BoardVO board);	
	
    // 게시글 총 갯수
    public int getTotal(Criteria cri);
    
    // 댓글 등록 메서드 (완성)
    public void replyEnroll(ReplyVO reply);

    // 특정 게시글의 답글 목록 조회 메서드 (완성)
    public List<ReplyVO> getReplies(int board_no);
    
    // 댓글 등록 (완성)
    public int insertReply(ReplyVO reply);
    
    // 답변 상태 (미완성)
    public void updateHasReplyStatus(@Param("boardNo") int boardNo, @Param("status") String status);
    
    // 조회수 (완성)
    public void updateViewCount(int board_no);
    
    // // 추천수 (미완성)
    public int updateRecomCount(int board_no);
    
}
