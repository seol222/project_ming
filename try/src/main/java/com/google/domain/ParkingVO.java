package com.google.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ParkingVO {
	
	private int dex;
	private String car_number;
	private Date time_in;
	private Date time_out;
	private int parking_fee;
	
		
}
