package xyz.teamcarrot.myct.healthnews;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import xyz.teamcarrot.myct.board.BoardFileVO;

@Service
public interface HealthNewsService {
	
	public void saveFile(BoardFileVO vo);
	
	public void saveImg(BoardFileVO vo, MultipartFile[] pics);
}
