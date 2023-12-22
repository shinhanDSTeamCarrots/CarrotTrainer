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
		try {
			vo.setMember_pw(this.encrypt(vo.getMember_pw()));
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return mapper.regist(vo) > 0 ? true : false;
	}

	@Override
	public MemberVO login(MemberVO vo) {
		try {
			vo.setMember_pw(this.encrypt(vo.getMember_pw()));
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return mapper.login(vo);
	}

	public MemberVO detail(MemberVO vo) {
		return mapper.detail(vo.getMember_no());
	}

	@Override
	public int update(MemberVO vo) {
		try {
			vo.setMember_pw(this.encrypt(vo.getMember_pw()));
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return mapper.update(vo);
	}

	public String encrypt(String text) throws NoSuchAlgorithmException {
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(text.getBytes());

		return bytesToHex(md.digest());
	}

	private String bytesToHex(byte[] bytes) {
		StringBuilder builder = new StringBuilder();
		for (byte b : bytes) {
			builder.append(String.format("%02x", b));
		}
		return builder.toString();
	}

	// 20231212 delete 추가
	@Override
	@Transactional
	public boolean deleteMember(@Param("member_id") String member_id, @Param("member_pw") String member_pw) {
		// 비밀번호 일치 여부 확인 및 회원 삭제
		int affectedRows = mapper.deleteMember(member_id, member_pw);

		// 삭제된 행이 1개 이상이면 삭제 성공
		return affectedRows > 0;
	}

	// 20231214 추가
	@Override
	public void updateLoginFailCount(MemberVO member) {
		mapper.updateLoginFailCount(member);
		//Integer loginFailCount = (Integer) sess.getAttribute("loginFail");
		//if (loginFailCount == null) {
			//loginFailCount = 0;
		}
		//sess.setAttribute("loginFail", 1);
	

	public void updateLoginBlocked(MemberVO member) {
		mapper.updateLoginBlocked(member);

	}

}
