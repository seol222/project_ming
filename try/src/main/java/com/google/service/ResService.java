package com.google.service;

import java.util.List;

import com.google.domain.ResVO;

public interface ResService {
	
	public int register(ResVO vo);
	
	public List<ResVO> read();

}
