package com.google.imna;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.domain.BoardAttachVO;
import com.google.domain.BoardVO;
import com.google.domain.Criteria;
import com.google.domain.PageDTO;
import com.google.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@Log4j
@AllArgsConstructor
public class BoardController {

	private BoardService service;

	// @GetMapping("/list")
	// public void list(Model model) {
	// log.info("list");
	// model.addAttribute("list",service.getList());
	// }

	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		// log.info("list");
		model.addAttribute("list", service.getList(cri));
		// model.addAttribute("pageMaker",new PageDTO(cri, 123));
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void register() {

	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("register:" + board);
		service.register(board);
		
		if (board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		
		rttr.addFlashAttribute("result", board.getBno());

		return "redirect:/board/list";

	}

	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		// log.info("/get");

		model.addAttribute("board", service.get(bno));
	}
	
	@PreAuthorize("principal.username == #board.writer")
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		service.modify(board);
		rttr.addFlashAttribute("result", board.getBno());
		return "redirect:/board/list";
	}
	@PreAuthorize("principal.username == #writer")
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") long bno, Criteria cri, RedirectAttributes rttr, String writer) {
		
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		
		if(service.remove(bno)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result","success");
		}
		
		return "redirect:/board/list" + cri.getListLink();
	}

	
	  @GetMapping(value="/getAttachList", produces ={MediaType.APPLICATION_JSON_UTF8_VALUE})	  
	  @ResponseBody
	  public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){ 
		  return new ResponseEntity<>(service.getAttachList(bno),HttpStatus.OK);
	  }
	  private void deleteFiles(List<BoardAttachVO> attachList) {
			if(attachList == null || attachList.size() == 0) {
				return;
			}
			
			attachList.forEach(attach -> {			
				try {				
					Path file = 
							Paths.get("D:/upload/" + attach.getUploadPath()+"/"+attach.getUuid()+"_"+attach.getFileName());
						
					Files.deleteIfExists(file);
					
					//이미지일경우 썸네일 삭제
					
					if(Files.probeContentType(file).startsWith("image")) {
						Path thumNail = 
								Paths.get("D:/upload/" + attach.getUploadPath()+"/s_"+attach.getUuid()+"_"+attach.getFileName());
						Files.delete(thumNail);
					}
					
					
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			});
		}
}
