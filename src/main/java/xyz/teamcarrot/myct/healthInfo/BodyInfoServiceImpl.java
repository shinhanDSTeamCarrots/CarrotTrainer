package xyz.teamcarrot.myct.healthInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BodyInfoServiceImpl implements BodyInfoService {

	@Autowired
	BodyInfoMapper mapper;
	
	@Override
	public boolean insertBodyInfo(BodyInfoVO vo) {
		return mapper.insertBodyInfo(vo) > 0 ? true : false;
	}
	@Override
	public boolean insertBodyChange(BodyChangeVO vo) {
		return mapper.insertBodyChange(vo) > 0 ? true : false;
	}
	public int updateBodyChange(BodyChangeVO vo) {
		return mapper.updateBodyChange(vo);
	}
}
