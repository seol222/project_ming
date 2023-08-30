package com.google.imna;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;
import com.google.domain.Criteria;
import com.google.domain.MemberVO;
import com.google.domain.PageDTO;
import com.google.domain.ParkingVO;
import com.google.service.BoardService;
import com.google.service.LoginService;
import com.google.service.MemberService;
import com.google.service.MypageService;
import com.google.service.ParkingService;

import lombok.AllArgsConstructor;


@Controller
@RequestMapping("/park/*")
@AllArgsConstructor
public class ParkingController {


	private ParkingService service;
	@GetMapping("/park")
	public void list() {
		
	
	}
	
	@PostMapping("/park/in")//회원가입!
	public String create(ParkingVO vo) {
		
		
		
		return "redirect:/park/park";
		
	}
	
	 
	
}
