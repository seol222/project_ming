package com.google.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.google.domain.ParkingVO;

public interface ParkingMapper {
	@Select("select * from tbl_park where dex>0")
	public List<ParkingVO> getList();
	public void insert(ParkingVO park);

}
