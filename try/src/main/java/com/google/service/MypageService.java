package com.google.service;

import java.util.List;

import com.google.domain.MemberVO;

public interface MypageService {
	
	public MemberVO getmy(String username);
	
	public void recreate(MemberVO vo);

}
