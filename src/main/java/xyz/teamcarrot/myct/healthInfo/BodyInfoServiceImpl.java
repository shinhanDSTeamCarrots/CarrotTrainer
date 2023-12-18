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
	public int insertBodyChange(BodyChangeVO vo) {
		return mapper.insertBodyChange(vo);
	}
	@Override
	public BodyChangeVO selectBodyChange(int member_no) {
		return mapper.selectBodyChange(member_no);
	}
	@Override
	public int updateBodyChange(BodyChangeVO vo) {
		return mapper.updateBodyChange(vo);
	}
	@Override
	public int deleteBodyChange(BodyChangeVO vo) {
		return mapper.deleteBodyChange(vo.getBody_change_no());
	}
}