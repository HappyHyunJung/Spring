package com.joongang.service;

public class MemberService {

	public boolean isExisted(String id, String pwd) {
		if(id.equals("test") & pwd.equals("1234")) {  // ※ id == "test" 절대 안 됨
			return true;
		} 
		return false;
	}

}
