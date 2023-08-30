package com.google.mapper;

import com.google.domain.AuthVO;
import com.google.domain.MemberVO;

public interface MemberMapper {

	public void create(MemberVO vo);
	
	public void auth(AuthVO avo);
	
	public int readByInt(String mb_id);
	
	public MemberVO read(String mb_id);
	
}
