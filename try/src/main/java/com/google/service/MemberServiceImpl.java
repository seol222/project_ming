package com.google.service;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.domain.AuthVO;
import com.google.domain.MemberVO;
import com.google.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service

public class MemberServiceImpl implements MemberService{
	
	@Setter(onMethod_= {@Autowired})
	private MemberMapper mmapper;
	

	
	@Override
	@Transactional
	public void create(MemberVO vo) {
		
		
		AuthVO avo = new AuthVO();
		
		mmapper.create(vo);
		
		avo.setMb_id(vo.getMb_id());
		avo.setAuth("ROLE_MEMBER");
		mmapper.auth(avo);
		
		
	}


	@Override
	public int readByint(String mb_id) {
		return mmapper.readByInt(mb_id);
		
	}

	
	
	

}
