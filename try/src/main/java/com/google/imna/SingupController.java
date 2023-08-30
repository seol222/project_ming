package com.google.imna;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.google.service.LoginService;
import com.google.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Controller
@RequestMapping("/sign/*")
@AllArgsConstructor
@Log4j
public class SingupController {
	
	private MemberService service;

	/**
	 * 
	 * @param mb_id
	 * @return
	 */
	
	//@GetMapping(value="/idchkajax/{mb_id}") //아이디중복체크
/*	public ResponseEntity<String> count(@PathVariable("mb_id") String mb_id){
		int Count = service.readByint(mb_id);
		System.out.println(Count);
		return Count == 0?
				new ResponseEntity<String>("success",HttpStatus.OK)
				:new ResponseEntity<String>("fail",HttpStatus.OK);
		
	}*/
	
	//@RequestMapping(value="/idchkajax",method=RequestMethod.GET)
	public int readByInt(String mb_id) {
		int count = service.readByint(mb_id);
		System.out.println(count);
		return count;
	}
	
}
