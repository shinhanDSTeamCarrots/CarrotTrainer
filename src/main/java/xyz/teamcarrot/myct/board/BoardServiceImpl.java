package xyz.teamcarrot.myct.board;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class BoardServiceImpl implements BoardService {
	
	
	@Autowired
	private BoardMapper mapper;
	
	private static final Logger log = LoggerFactory.getLogger(BoardController.class);
	
	 // 게시글 등록과 파일 정보 저장을 수행하는 enroll 메서드
    @Override
    public int enroll(BoardVO board, MultipartFile file, HttpServletRequest request) {
        
     // 로깅으로 객체 상태 확인
        log.info("Board: " + board);
        log.info("File: " + file);
        log.info("Request: " + request);
        // 게시글 정보 저장
        int result = mapper.enroll(board);

        // 파일이 있는 경우
        if (file != null && !file.isEmpty()) {
            // 파일명 추출 및 저장 경로 설정
            String originalFilename = file.getOriginalFilename();
            String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            String storedFilename = System.currentTimeMillis() + extension;
            String uploadPath = request.getServletContext().getRealPath("/upload/board/") + storedFilename;

            // 파일 저장
            try {
                file.transferTo(new File(uploadPath));
            } catch (Exception e) {
                e.printStackTrace(); // 오류 처리
            }

            // BoardFileVO 객체 생성 및 정보 설정
            BoardFileVO boardFile = new BoardFileVO();
            boardFile.setBoard_no(board.getBoard_no()); // 게시글 번호 설정
            boardFile.setFile_name(storedFilename); // 저장된 파일명 설정

            // 파일 정보 데이터베이스에 저장
            mapper.enrollFile(boardFile);
        }
        
    
        log.info("Result: " + result); // DB 작업 결과 로깅
        return result;
    }
	
    @Override
    public int enrollFile(BoardFileVO boardFile) {
        return mapper.enrollFile(boardFile);
    }
    
	/* �Խ��� ���� */
    @Override
    public int delete(int board_no) {
        
        return mapper.delete(board_no);
    }    
	
	
	
	/*�Խ��� ��ȸ*/
	@Override
	public BoardVO getPage(int board_no) {
			
		return mapper.getPage(board_no);
	}
	
	 /* �Խ��� ���� */
    @Override
    public int modify(BoardVO board) {
        
        return mapper.modify(board);
    }
    
    /* �Խ��� ���(����¡ ����) */
    @Override
    public List<BoardVO> getListPaging(Criteria cri) {
        
        return mapper.getListPaging(cri);
    }    
    
    /*�Խ��� ���*/
	@Override
	public List<BoardVO> getList() {
		
		return mapper.getList();
	}
    
    /* �Խù� �� ���� */
    @Override
    public int getTotal(Criteria cri) {
        
        return mapper.getTotal(cri);
    } 
    
    @Override
    public void replyEnroll(ReplyVO reply) {
        mapper.replyEnroll(reply);
    }
    
    @Override
    public List<ReplyVO> getReplies(int board_no) {
    		   mapper.updateViewCount(board_no);
        return mapper.getReplies(board_no);
    }
    
    @Override
    public int insertReply(ReplyVO reply) {
        return mapper.insertReply(reply);
    }
    
    @Override
    public void updateHasReplyStatus(int board_no, String status) {
        mapper.updateHasReplyStatus(board_no, status);
    }
    
    //조회수
    @Override
    public void updateViewCount(int board_no) {
    	mapper.updateViewCount(board_no);
    }
    
    // 추천수 (미완성)
    @Override
    public int updateRecomCount(int board_no) {
    	return mapper.updateRecomCount(board_no);
    }
}
