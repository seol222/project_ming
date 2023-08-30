package com.google.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.google.domain.BoardVO;
import com.google.domain.Criteria;

public interface BoardMapper {

	//@Select("SELECT * FROM tbl_board ORDER BY bno DESC")
	public List<BoardVO> getList();
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO board);
	
	public BoardVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(BoardVO board);
	
	public void updatehit(long bno);
	
	public int getTotalCount(Criteria cri);
}
