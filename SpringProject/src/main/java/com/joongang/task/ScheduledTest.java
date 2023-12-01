package com.joongang.task;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import org.apache.tomcat.jni.Local;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class ScheduledTest {

	//@Scheduled(fixedRate = 5000) // 5초마다 동작
	public void test() {
		Date today = new Date();
		Locale currentLocale = new Locale("Korean" , "korea!!!");
		String pattern = "HHmmss";
		SimpleDateFormat formatter = new SimpleDateFormat(pattern, currentLocale);
		
		System.out.println("스케줄러 실행 (HHmmss) >> " + formatter.format(today));
	}
}
