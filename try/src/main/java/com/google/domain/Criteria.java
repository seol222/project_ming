package com.google.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
/**
 * 페이징
 * 
 * @author BigData05
 *
 */
@Getter
@Setter
@ToString
public class Criteria {

	private int pageNum;
	private int amount;
	
	private String type;
	private String keyword;
	
	public Criteria() {
		this(1,10);
	}
	public Criteria(int pageNum, int amount) {
		super();
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public int getSkip() {
		return  (this.pageNum-1) * this.amount;
	}
	
	public String[] getTypeArr() {
		return type == null? new String[] {}:type.split("");
	}
	
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
										.queryParam("pageNum", this.pageNum)
										.queryParam("amount", this.getAmount())
										.queryParam("type", this.getType())
										.queryParam("keyword", this.getKeyword());
		return builder.toUriString();
	}
}
