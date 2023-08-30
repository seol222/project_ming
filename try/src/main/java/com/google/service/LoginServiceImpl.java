package com.google.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.domain.MemberVO;
import com.google.mapper.LoginMapper;

import lombok.Setter;

@Service
public class LoginServiceImpl implements LoginService {

	@Setter(onMethod_=@Autowired)
	private LoginMapper mapper;
	@Override
	public MemberVO read(MemberVO vo) {
		
		return mapper.read(vo);
	}

}
