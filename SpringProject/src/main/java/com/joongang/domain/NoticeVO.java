package com.joongang.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class NoticeVO {
	private Long rno;
	private String notice;
	private String title;
	private Timestamp regdate;
	private Timestamp updatedate;
}
