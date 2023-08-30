package com.google.mapper;

import java.util.List;

import com.google.domain.ResVO;

public interface ResMapper {
	
	public int addres(ResVO vo);
	
	public List<ResVO> getdata();

}
