package com.google.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class ResVO {
	private int id;
	private String groupId;
	private String title;
	private String writer;
	private String content;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date start1;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date end1;
    private boolean allDay;	
    private String textColor;
	private String backgroundColor;
	
}
