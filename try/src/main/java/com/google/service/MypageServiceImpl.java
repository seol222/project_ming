package com.google.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.domain.MemberVO;
import com.google.mapper.MypageMapper;

import lombok.Setter;
@Service
public class MypageServiceImpl implements MypageService {
	
	@Setter(onMethod_=@Autowired)
	private MypageMapper mapper;
	

	@Override
	public MemberVO getmy(String username) {
		// TODO Auto-generated method stub
		return mapper.getmy(username);
	}


	@Override
	public void recreate(MemberVO vo) {
		mapper.recreate(vo);
		
	}




}
