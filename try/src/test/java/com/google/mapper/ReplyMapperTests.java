package com.google.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import com.google.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	
	@Setter(onMethod_=@Autowired)
	private ReplyMapper mapper;
	
	//@Test
	public void testMapper() {
		log.info(mapper);
	}
	
	//@Test
	public void testInsert() {
		ReplyVO vo = new ReplyVO();
		vo.setBno(2097L);
		vo.setReply("댓글내용");
		vo.setReplyer("댓글작성자");
		mapper.insert(vo);
	}
	
	@Test
	public void testRead() {			
		ReplyVO vo =  mapper.read(48L);
		log.info(vo);
	}

}
