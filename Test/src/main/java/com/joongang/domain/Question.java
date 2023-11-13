package com.joongang.domain;

import java.util.List;

public class Question {
	private String title;
	private List<String> options;
	private boolean select;
	
	public Question(String title, List<String> options) {
		this.title = title;
		this.options = options;
	}

	public Question(String title, List<String> options, boolean select) {
		this.title = title;
		this.options = options;
		this.select = select;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public List<String> getOptions() {
		return options;
	}

	public void setOptions(List<String> options) {
		this.options = options;
	}

	// SurveyService 에서 응답자 위치를 받을 때, 옵션이 있는지 없는지로 나누기 위해 사용 
	public boolean isChoice() {
		return options != null && !options.isEmpty();
	}

	public boolean isSelect() {
		return select;
	}

	@Override
	public String toString() {
		return "Question [title=" + title + ", options=" + options + ", select=" + select + "]";
	}

	

}
