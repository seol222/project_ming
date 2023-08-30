package com.google.mapper;

import com.google.domain.MemberVO;

public interface MypageMapper {

	public MemberVO getmy(String username);
	
	public void recreate(MemberVO vo);
}
