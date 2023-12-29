package xyz.teamcarrot.myct.board;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public interface BoardService {
	
	
	

	// 게시글 등록
	public int enroll(BoardVO board, MultipartFile file, HttpServletRequest request);
	
	// 파일 정보를 저장
    public int enrollFile(BoardFileVO boardFile);
	
	// 게시글 삭제
    public int delete(int board_no);
    
    // 게시글 목록(페이징X)
	public List<BoardVO> getList();
	
	// 게시글 목록(페이징O)
    public List<BoardVO> getListPaging(Criteria cri, int category_no);
	// 게시글 목록(페이징O)
    public List<BoardVO> getListPaging();
	
    // 페이지 가져오기
	public BoardVO getPage(int board_no);
	
	// 게시글 수정
    public int modify(BoardVO board);
    
    
    
    
    public int getTotal(Criteria cri);
    
    // 댓글 등록 서비스
    public void replyEnroll(ReplyVO reply);

    // 특정 게시글의 답글 목록 조회 서비스
    public List<ReplyVO> getReplies(int board_no);
    
 
    public int insertReply(ReplyVO reply);

   
  
    // 조회수
    public void updateViewCount(int board_no);
    
    // 추천수 (미완성)
    public int updateRecomCount(int board_no);
    
    public void deleteSelectedBoards(List<Integer> boardNos);
    
    // 댓글 삭제 (완성)
    public int deleteReply(int reply_no);
    
    // 답변 (완성)
    public void updateHasReplyStatus(int board_no, boolean status);
    
    // 비공개 (완성)
    public void updatePrivateStatus(int board_no, int board_private);

}
