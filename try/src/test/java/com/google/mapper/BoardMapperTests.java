package com.google.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.google.domain.BoardVO;
import com.google.domain.Criteria;


import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {

	@Setter(onMethod_= {@Autowired})
	private BoardMapper mapper;
	
	
	//전체 리스트 불러오기
	//@Test
	public void testGetList() {
		mapper.getList().forEach(board->log.info(board));
	}
	//새로운 데이터 등록하기
	//@Test
	public void testInsert() {
		BoardVO vo = new BoardVO();
		vo.setTitle("새로운제목");
		vo.setContent("새로운내용");
		vo.setWriter("user00");
		mapper.insert(vo);
	}
	//SelectKey 사용한 데이터 등록
	//@Test
	public void testInsertSelectKey() {
		BoardVO vo = new BoardVO();
		vo.setTitle("새로운제목");
		vo.setContent("새로운내용");
		vo.setWriter("user00");
		mapper.insertSelectKey(vo);
		log.info(vo);
	}
	//조건에 맞는 데이터 불러오기
	//@Test
	public void testRead() {
		 mapper.read(37L);		
	}
	
	//데이터 삭제
	//@Test
	public void testDelete() {
		mapper.delete(38L);
	}
	
	//데이터 수정
	//@Test
	public void testUpdate() {
		BoardVO vo = new BoardVO();
		vo.setBno(37L);		
		vo.setTitle("2222수정된제목");
		vo.setContent("22222수정된내용");
		mapper.update(vo);
	}
	
	@Test
	public void testPaging() {
		Criteria cri = new Criteria();
		List<BoardVO> list = mapper.getListWithPaging(cri);
		list.forEach(board->log.info(board));
			
		
	}
	
}