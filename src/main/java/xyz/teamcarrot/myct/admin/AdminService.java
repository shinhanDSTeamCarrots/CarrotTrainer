package xyz.teamcarrot.myct.admin;

import org.springframework.stereotype.Service;

@Service
public interface AdminService {
	public AdminVO SelectLogin(AdminVO vo);
}
