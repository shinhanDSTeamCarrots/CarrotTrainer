package xyz.teamcarrot.myct.member;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper mapper;

	@Override
	public boolean dupId(String id) {
		return mapper.dupId(id) > 0 ? true : false;
	}
	
	@Override
	public boolean dupNickname(String nickname) {
		return mapper.dupNickname(nickname) > 0 ? true : false;
	}

	@Override
	public boolean regist(MemberVO vo) {
		return mapper.regist(vo) > 0 ? true : false;
	}

	@Override
	public MemberVO login(MemberVO vo) {
		return mapper.login(vo);
	}

	public MemberVO detail(MemberVO vo) {
		return mapper.detail(vo.getMember_no());
	}

	@Override
	public int update(MemberVO vo) {
		return mapper.update(vo);
	}



	// 20231212 delete 추가
	/*@Override
	@Transactional
	public boolean deleteMember(@Param("member_id") String member_id, @Param("member_pw") String member_pw) {
		// 비밀번호 일치 여부 확인 및 회원 삭제
		int affectedRows = mapper.deleteMember(member_id, member_pw);

		// 삭제된 행이 1개 이상이면 삭제 성공
		return affectedRows > 0;
	}
	*/
	@Override
	public boolean deleteMember(MemberVO vo) {
		return mapper.deleteMember(vo) > 0 ? true : false;
	}
	// 20231214 추가
	
	

	public void updateLoginBlocked(MemberVO member) {
		mapper.updateLoginBlocked(member);

	}
	//20231225
	
	public void memberInterest(InterestVO vo) {
		mapper.memberInterest(vo);
	}

@Override
	public List<MemberVO> all(MemberVO vo) {
		return mapper.all(vo);
	}

}
