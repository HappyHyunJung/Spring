package com.joongang.domain;

import java.util.List;

public class SurveyData {
	private String fruits;
	private String movie_genre;
	private String alcohol_type;
	private String area;
	private String age;
	
	// main.jsp 에 결과 출력
	private List<String> titles;
	private List<String> responses;
	
	public SurveyData(String fruits, String movie_genre, String alcohol_type, String area, String age) {
		this.fruits = fruits;
		this.movie_genre = movie_genre;
		this.alcohol_type = alcohol_type;
		this.area = area;
		this.age = age;
	}

	public String getFruits() {
		return fruits;
	}

	public void setFruits(String fruits) {
		this.fruits = fruits;
	}

	public String getMovie_genre() {
		return movie_genre;
	}

	public void setMovie_genre(String movie_genre) {
		this.movie_genre = movie_genre;
	}

	public String getAlcohol_type() {
		return alcohol_type;
	}

	public void setAlcohol_type(String alcohol_type) {
		this.alcohol_type = alcohol_type;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public List<String> getTitles() {
		return titles;
	}

	public void setTitles(List<String> titles) {
		this.titles = titles;
	}

	public List<String> getResponses() {
		return responses;
	}

	public void setResponses(List<String> responses) {
		this.responses = responses;
	}

	@Override
	public String toString() {
		return "SurveyData [titles=" + titles + ", responses=" + responses + "]";
	}

	
	
	
}
