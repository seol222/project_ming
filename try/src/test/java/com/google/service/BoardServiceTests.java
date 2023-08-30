package com.google.service;


import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.google.domain.BoardVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {

	@Setter(onMethod_=@Autowired)
	private BoardService service;
	
	//@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	
	//데이터 등록
	//@Test
	public void testResister() {
		BoardVO vo = new BoardVO();
		vo.setTitle("222새로운제목22");
		vo.setContent("222새로운내용22");
		vo.setWriter("222user00");
		service.register(vo);
	}
	
	//등록 된 전체데이터 가져오기
	//@Test
	public void testGetList() {
		//service.getList().forEach(board->log.info(board));
	}
	
	//조건에 맞는 데이터 가져오기
	//@Test
	public void testGet() {
		service.get(37L);
	}
	
	//데이터삭제
	//@Test
	public void testRemove() {
		service.remove(37L);
	}
	
	//데이터수정
	@Test
	public void testModify() {
		BoardVO vo = new BoardVO();
		vo.setBno(41L);
		vo.setTitle("333새로운제목33");
		vo.setContent("3333새로운내용33");
		//vo.setWriter("user00");
		service.modify(vo);
			
		}
	
}
