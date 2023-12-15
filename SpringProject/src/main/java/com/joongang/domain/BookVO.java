package com.joongang.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class BookVO {
	private int bookId;
	private String bookName;
	private String publeYear;
	private String publisher;
	private String cateCode;
	private int bookPrice;
	private int bookStock;
	private double bookDiscount;
	private String bookIntro;
	private String bookContents;
	private Date regDate;
	private Date updateDate;
}
