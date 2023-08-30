package com.google.imna;





import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.domain.BoardAttachVO;
import com.google.domain.ResVO;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.service.ResService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/plan/*")
@AllArgsConstructor
public class PlanController {

	private ResService service;

	
	  @GetMapping("/reservation") 
	  public void reservation() {
	  
	 }
	 
		/*
		 * @GetMapping(value="/getdata", produces = {MediaType.APPLICATION_XML_VALUE,
		 * MediaType.APPLICATION_JSON_UTF8_VALUE}) public ResponseEntity<ResVO> get() {
		 * return new ResponseEntity<>(service.read(), HttpStatus.OK); }
		 */
	
	  @GetMapping(value="/getdata" , produces ={MediaType.APPLICATION_JSON_UTF8_VALUE})
	  @ResponseBody
		public ResponseEntity<List<ResVO>> get(){ 
		  return new ResponseEntity<>(service.read(),HttpStatus.OK);

		}
	
	
	@PostMapping(value = "/savedata", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> saveres(@RequestBody ResVO vo, Principal prin){
		
		vo.setWriter(prin.getName());
		int insertCount = service.register(vo);
		
		return insertCount == 1 
				?new ResponseEntity<>("success",HttpStatus.OK) 
					:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	

	  @PreAuthorize("isAuthenticated()")	  
	  @GetMapping("/callender") 
	  public void calread(){
	  
	  }
	  
	 
	 

}
