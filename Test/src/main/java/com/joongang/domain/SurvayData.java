package com.joongang.domain;

public class SurvayData {
	String fruits;
	String movie_genre;
	String alcohol_type;
	String area;
	String age;
	
	public SurvayData(String fruits, String movie_genre, String alcohol_type, String area, String age) {
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

	@Override
	public String toString() {
		return "SurvayData [fruits=" + fruits + ", movie_genre=" + movie_genre + ", alcohol_type=" + alcohol_type
				+ ", area=" + area + ", age=" + age + "]";
	}
	
	
}
