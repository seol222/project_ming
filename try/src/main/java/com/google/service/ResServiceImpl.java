package com.google.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.domain.ResVO;

import com.google.mapper.ResMapper;

import lombok.Setter;
@Service
public class ResServiceImpl implements ResService {
	
	@Setter(onMethod_=@Autowired)
	private ResMapper mapper;

	@Override
	public int register(ResVO vo) {	
		return mapper.addres(vo);
	}

	@Override
	public List<ResVO> read() {
		return mapper.getdata();
	}

}
