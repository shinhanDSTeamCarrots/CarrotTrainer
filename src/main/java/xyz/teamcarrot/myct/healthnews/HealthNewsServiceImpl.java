package xyz.teamcarrot.myct.healthnews;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import xyz.teamcarrot.myct.board.BoardFileVO;

@Service
public class HealthNewsServiceImpl implements HealthNewsService {
	
	@Autowired
	private HealthNewsMapper mapper;
	
	@Override
	public void saveFile(BoardFileVO vo) {
		mapper.saveFile(vo);

	}
	
    @Override
    public void saveImg(BoardFileVO vo, MultipartFile[] pics) {
        for (MultipartFile file : pics) {
            if (!file.isEmpty()) {
                try {
                    String originalFilename = file.getOriginalFilename();
                    String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
                    String storedFilename = UUID.randomUUID().toString().substring(0, 8) + extension;
                    String path = "C:\\upload";  // 변경: 실제 저장 경로로 설정

                    File sfile = new File(path, storedFilename);
                    file.transferTo(sfile);

                    // 파일 정보 데이터베이스에 저장하는 로직
                    BoardFileVO fileVO = new BoardFileVO();
                    fileVO.setBoard_no(vo.getBoard_no());
                    fileVO.setFile_name(storedFilename);
                    mapper.saveImg(fileVO);

                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
