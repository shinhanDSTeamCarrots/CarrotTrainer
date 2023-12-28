package xyz.teamcarrot.myct.board;

import java.io.File;
import java.util.HashMap;
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
	
	
    @Override
    public int enroll(BoardVO board, MultipartFile file, HttpServletRequest request) {
        
   
        log.info("Board: " + board);
        log.info("File: " + file);
        log.info("Request: " + request);
        
        int result = mapper.enroll(board);

     
        if (file != null && !file.isEmpty()) {
          
            String originalFilename = file.getOriginalFilename();
            String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            String storedFilename = System.currentTimeMillis() + extension;
            String uploadPath = request.getServletContext().getRealPath("/upload/board/") + storedFilename;

           
            try {
                file.transferTo(new File(uploadPath));
            } catch (Exception e) {
                e.printStackTrace(); 
            }

           
            BoardFileVO boardFile = new BoardFileVO();
            boardFile.setBoard_no(board.getBoard_no()); 
            boardFile.setFile_name(storedFilename); 
            
          
            mapper.enrollFile(boardFile);
        }
        
    
        log.info("Result: " + result); 
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
    public List<BoardVO> getListPaging(Criteria cri, int category_no) {
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("searchType", cri.getSearchType());
        map.put("keyword", cri.getKeyword());
        map.put("category_no", category_no);
        map.put("skip", cri.getSkip());
        map.put("amount", cri.getAmount());
        return mapper.getListPaging(map);
    }
    @Override
    public List<BoardVO> getListPaging() {
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("searchType", "");
        map.put("orderType", "T");
        map.put("category_no", 2);
        map.put("skip", 0);
        map.put("amount", 10);
        return mapper.getListPaging(map);
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
    
    @Override
    public void deleteSelectedBoards(List<Integer> boardNos) {	
    	
        mapper.deleteSelected(boardNos);
    }
    
    @Override
	public int deleteReply(int reply_no) {
		return mapper.deleteReply(reply_no);
	}
    
    
    // 답변 상태
    @Override
    public void updateHasReplyStatus(int board_no, boolean status) {
        mapper.updateHasReplyStatus(board_no, status);
    }
    
    @Override
    public void updatePrivateStatus(int board_no, int board_private) {
        mapper.updatePrivateStatus(board_no, board_private);
    }
}
