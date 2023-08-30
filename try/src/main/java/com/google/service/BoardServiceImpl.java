package com.google.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.domain.BoardAttachVO;
import com.google.domain.BoardVO;
import com.google.domain.Criteria;
import com.google.mapper.BoardAttachMapper;
import com.google.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	@Setter(onMethod_=@Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private BoardAttachMapper attachmapper;

	@Transactional
	@Override
	public void register(BoardVO board) {
		mapper.insertSelectKey(board);
		
		if(board.getAttachList() == null || board.getAttachList().size() <=0 ) {
			return;
		}
		//log.info(board.getBno());
		board.getAttachList().forEach(attach -> {attach.setBno(board.getBno()); 
													attachmapper.insert(attach);
		});
	}
	
	@Override
	public List<BoardVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}

	@Override
	public BoardVO get(Long bno) {	
		mapper.updatehit(bno);
		return mapper.read(bno);
	}

	@Transactional
	@Override
	public boolean modify(BoardVO board) {
		
		attachmapper.deleteAll(board.getBno());
		
		boolean modifyResult = mapper.update(board) ==1;
		
		if(modifyResult && board.getAttachList() != null && board.getAttachList().size()>0) {
			board.getAttachList().forEach(attach->{attach.setBno(board.getBno()); attachmapper.insert(attach);});
		}
		
		return modifyResult;
	}
	@Transactional
	@Override
	public boolean remove(Long bno) {
		attachmapper.deleteAll(bno);
		return mapper.delete(bno) == 1;
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		return attachmapper.findByBno(bno);
	}

	
	
	
	
	

}
