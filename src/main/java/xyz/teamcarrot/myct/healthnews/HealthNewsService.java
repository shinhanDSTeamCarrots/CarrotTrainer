package xyz.teamcarrot.myct.healthnews;

import org.springframework.stereotype.Service;

import xyz.teamcarrot.myct.board.BoardFileVO;

@Service
public interface HealthNewsService {
	
	public void saveFile(BoardFileVO vo);
	
}
