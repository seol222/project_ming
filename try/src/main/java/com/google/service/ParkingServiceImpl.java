package com.google.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.domain.BoardAttachVO;
import com.google.domain.BoardVO;
import com.google.domain.Criteria;
import com.google.domain.ParkingVO;
import com.google.mapper.BoardAttachMapper;
import com.google.mapper.BoardMapper;
import com.google.mapper.ParkingMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ParkingServiceImpl implements ParkingService {
	
	@Setter(onMethod_=@Autowired)
	private ParkingMapper mapper;
	
	@Transactional
	@Override
	public void register(ParkingVO parking) {
		// TODO Auto-generated method stub
		
	}
	
	
	
	
	
	

}
