package xyz.teamcarrot.myct.healthnews;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import xyz.teamcarrot.myct.board.BoardFileVO;

@Service
public class HealthNewsServiceImpl implements HealthNewsService {
	
	@Autowired
	private HealthNewsMapper mapper;
	
	@Override
	public void saveFile(BoardFileVO vo) {
		mapper.saveFile(vo);

	}

}
