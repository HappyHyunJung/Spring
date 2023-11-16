package com.joongang.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class BoardVO {
	private Long rn;  // 우리가 가져오는 데이터에 번호 매김
	private Long bno;  // BoardMapper.xml에 selectKey로 설정해서 자동으로 들어옴
	private String title;
	private String content;
	private String writer;
	private Timestamp regDate;  // 트리거 설정해서 자동으로 들어감
	private Timestamp updateDate;
}
