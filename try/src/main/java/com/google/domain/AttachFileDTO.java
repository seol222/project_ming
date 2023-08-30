package com.google.domain;

import lombok.Data;

@Data
public class AttachFileDTO {

	private String fileName;
	private String uploadpath;
	private String uuid;
	private boolean image;
	
	private Long bno;
	

}
