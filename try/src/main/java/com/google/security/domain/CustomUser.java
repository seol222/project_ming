package com.google.security.domain;

import java.util.Collection;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.google.domain.MemberVO;

import lombok.Getter;

@Getter
public class CustomUser extends User {

	
	private static final long serialVersionUID = 1L;
	private MemberVO member;
	
	public CustomUser(String mb_name, String mb_pw, Collection<? extends GrantedAuthority> authorities) {
		super(mb_name, mb_pw, authorities);
		
	}

	public CustomUser(MemberVO vo) {
		super(vo.getMb_id(), vo.getMb_pw(), vo.getAuthList().stream().map(auth->new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
		this.member = vo;
	
	}
	
}
