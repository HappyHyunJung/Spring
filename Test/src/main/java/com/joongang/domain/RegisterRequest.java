package com.joongang.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RegisterRequest {
	private String email;
	private String name;
	private String pwd;
	private String cfpwd;
	
	
	public RegisterRequest(String email, String name, String pwd, String cfpwd) {
		this.email = email;
		this.name = name;
		this.pwd = pwd;
		this.cfpwd = cfpwd;
	}
	
	
	
}
