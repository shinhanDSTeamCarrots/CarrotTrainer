package xyz.teamcarrot.myct.member;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberMapper mapper;
	
	@Override
	public boolean dupId(String id) {
		return mapper.dupId(id)>0 ? true : false;
	}
	
	@Override
	public boolean regist(MemberVO vo) {
		try {
			vo.setMember_pw(this.encrypt(vo.getMember_pw()));
		}catch(NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return mapper.regist(vo) > 0 ? true : false;
	}
	
	@Override
	public MemberVO login(MemberVO vo) {
		try {
			vo.setMember_pw(this.encrypt(vo.getMember_pw()));
		}catch(NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return mapper.login(vo);
	}
	
	@Override
	public int update(MemberVO vo) {
		try {
			vo.setMember_pw(this.encrypt(vo.getMember_pw()));
		}catch(NoSuchAlgorithmException e) {
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
}
