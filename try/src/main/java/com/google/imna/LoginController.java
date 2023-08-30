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
import com.google.domain.MemberVO;
import com.google.service.LoginService;
import com.google.service.MemberService;
import com.google.service.MypageService;

import lombok.AllArgsConstructor;


@Controller
@RequestMapping("/log/*")
@AllArgsConstructor
public class LoginController {

	private MemberService service;
	private LoginService LOservice;
	private MypageService MYservice;
	
	@GetMapping("/login")
	public void login() {
		
	}
	@PostMapping("/log/login")
	public String read(MemberVO vo) {
		
		MemberVO Lvo = LOservice.read(vo);
		
		if(Lvo ==null) {
			return "redirect:/log/login";
		}else {
			
			return "redirect:/log/mypage";
		}
	
		
	}
	
	@GetMapping("/signup")//회원가입페이지 열기
	public void singup() {
		
	}
	
	@PostMapping("/log/signup")//회원가입!
	public String create(MemberVO vo) {
		BCryptPasswordEncoder encodePassword =new BCryptPasswordEncoder();
		//String encodePassword = pwencoder.encode(vo.getMb_pw());
		vo.setMb_pw(encodePassword.encode(vo.getMb_pw()));
		service.create(vo);
		
		
		
		return "redirect:/log/login";
		
	}
	
	@RequestMapping(value="/idchkajax",method=RequestMethod.GET)
	public @ResponseBody int readByInt(String mb_id) {
		int result = service.readByint(mb_id);
		System.out.println(result);
		
		return result;
	}
	
	//마이페이지 조회
	  @GetMapping("/mypage") 
	  public void mypage(Principal principal, Model model) {
	  String mb_id = principal.getName(); 
	  model.addAttribute("list", MYservice.getmy(mb_id));

	  }
	  
	  //회원정보 수정
	  @PostMapping("/log/resignup")
	  public String recreate(MemberVO vo) {
		 
		  MYservice.recreate(vo);
		  return "redirect:/log/mypage";
	  }
	 
	
}
