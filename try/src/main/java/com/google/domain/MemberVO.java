package com.google.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {

	private String mb_id;
	private String mb_pw;
	private String mb_name;
	private String mb_email;
	private String mb_phone;
	private String mb_code;
	private String mb_addr;
	private String mb_extra;
	private String mb_yynn;
	private Date mb_joindate;
	private boolean enabled;
	
	private List<AuthVO> authList;
}
