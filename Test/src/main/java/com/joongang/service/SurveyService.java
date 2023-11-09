package com.joongang.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Service;

import com.joongang.domain.Question;

@Service
public class SurveyService {
	public List<Question> getSurveyQuestions() {
		List<Question> retValue = new ArrayList<Question>();
		Question q =new Question("가장 좋아하는 과일은?", Arrays.asList("포도", "사과", "멜론", "체리"));
		retValue.add(q);
		
		q = new Question("가장 좋아하는 영화 장르는?", Arrays.asList("멜로", "호러", "액션", "코미디"));
		retValue.add(q);
		
		q = new Question("가장 좋아하는 술은?", Arrays.asList("소주", "맥주", "위스키", "럼"));
		retValue.add(q);
		
		q = new Question("응답자위치: ", Arrays.asList("-선택-", "서울", "부산", "대구",
				"인천", "광주", "대전", "울산", "강원", "경기", "경남", "경북", "전남", "전북", "제주", "충남", "충북"), true);
		retValue.add(q);
		
		q = new Question("응답자 나이:", new ArrayList<>());
		retValue.add(q);
		return retValue;
	}
	

}
