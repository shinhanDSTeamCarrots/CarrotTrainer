package xyz.teamcarrot.myct.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminServiceImpl implements AdminService {
	@Autowired
	AdminMapper mapper;
	@Override
	public AdminVO SelectLogin(AdminVO vo) {
		// TODO Auto-generated method stub
		return mapper.selectLogin(vo);
	}

}
