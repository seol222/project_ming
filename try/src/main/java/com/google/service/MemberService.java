package com.google.service;

import com.google.domain.AuthVO;
import com.google.domain.MemberVO;

public interface MemberService {

	public void create(MemberVO vo);
	
	public int readByint(String mb_id);
}
