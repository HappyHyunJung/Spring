<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	let enrollForm = $("form");
	
	$(".cancel_btn").click(function() {
		location.href = "/admin/bookManage";
	});
	
	$(".enroll_btn").on("click", function(e) {
		console.log("eroll click");
		e.preventDefault();
		console.log($(".form_section_content input[name=bookName]"));
	});
</script>
</head>
<%@include file="./header.jsp" %>
<body>
	<h2>상품등록</h2>
	<div class="admin_content_main">
        <form action="/admin/bookEnroll" method="post" id="enrollForm">
        	<!-- 책제목 -->
        	<div class="form_section">
         		<div class="form_section_title">
         			<label>책 제목</label>
         		</div>
       			<div class="form_section_content">
       				<input name="bookName">
       				<span class="ck_warn bookName_warn">책 이름을 입력해주세요.</span>
       			</div>
       		</div>
       		
       		<!-- 작가 -->
       		<!--
           	<div class="form_section">
       			<div class="form_section_title">
         				<label>작가</label>
         			</div>
         		<div class="form_section_content">
         				<input id="authorName_input" readonly="readonly">
         				<input id="authorId_input" name="authorId" type="hidden">
         				<button class="authorId_btn">작가 선택</button>
         				<span class="ck_warn authorId_warn">작가를 선택해주세요</span>
         			</div>
           	</div> -->   
           	
           	<!-- 출판일(publeYear) -->        
           	<div class="form_section">
       			<div class="form_section_title">
       				<label>출판일</label>
       			</div>
       			<div class="form_section_content">
       				<input name="publeYear">
       			</div>
       		</div> 
           	
           	<!-- 출판사(publisher) -->           
           	<div class="form_section">
     			<div class="form_section_title">
     				<label>출판사</label>
     			</div>
     			<div class="form_section_content">
     				<input name="publisher">
     				<span class="ck_warn publisher_warn">출판사를 입력해주세요.</span>
     			</div>
     		</div>       
           	
            <!-- 책 카테고리 -->
           	<div class="form_section">
       			<div class="form_section_title">
       				<label>책 카테고리</label>
       			</div>
     			<div class="form_section_content">
     				<div class="cate_wrap">
     					<span>대분류</span>
     					<select class="cate1">
     						<option selected value="none">선택</option>
     						<option value="100000">국내</option>
     						<option value="200000">국외</option>
     					</select>
     				</div>
     				<div class="cate_wrap">
     					<span>중분류</span>
     					<select class="cate2">
     						<option selected value="none">선택</option>
     						<option value="101000">소설</option>
     						<option value="204000">과학 / 기술</option>
     					</select>
     				</div>
     				<div class="cate_wrap">
     					<span>소분류</span>
     					<select class="cate3" name="cateCode">
     						<option selected value="none">선택</option>
     						<option value="101001">한국소설</option>
     						<option value="101002">영미소설</option>
     						<option value="101003">일본소설</option>
     						<option value="204001">IT</option>
     						<option value="204002">수학</option>
     						<option value="204003">교양과학</option>
     					</select>
     				</div>  
     				<!-- <span class="ck_warn cateCode_warn">카테고리를 선택해주세요.</span>     -->              				                    				
     			</div>
         	</div> 
           	
           	<!-- 도서 가격 -->	         
           	<div class="form_section">
       			<div class="form_section_title">
       				<label>상품 가격</label>
       			</div>
      			<div class="form_section_content">
      				<input name="bookPrice" value="0">
      				<span class="ck_warn bookPrice_warn">상품 가격을 입력해주세요.</span>
      			</div>
      		</div>
      		
      		<!-- 도서 재고 -->               
           	<div class="form_section">
       			<div class="form_section_title">
       				<label>상품 재고</label>
       			</div>
       			<div class="form_section_content">
       				<input name="bookStock" value="0">
       				<span class="ck_warn bookStock_warn">상품 재고를 입력해주세요.</span>
       			</div>
       		</div>
       		
       		<!-- 도서 할인율 -->          
           	<div class="form_section">
       			<div class="form_section_title">
       				<label>상품 할인율</label>
       			</div>
       			<div class="form_section_content">
       				<input name="bookDiscount" value="0">
       				<span class="step_val">할인 가격 : <span class="span_discount"></span></span>
       				<span class="ck_warn bookDiscount_warn">0 ~ 0.99 숫자를 입력해주세요.</span>
       			</div>
       		</div> 
       		         		
           	<!-- 도서 소개 -->
           	<div class="form_section">
       			<div class="form_section_title">
       				<label>책 소개</label>
       			</div>
       			<div class="form_section_content bit">
       				<textarea name="bookIntro" id="bookIntro_textarea"></textarea>
       				<span class="ck_warn bookIntro_warn">책 소개를 입력해주세요.</span>
       			</div>
       		</div>
       		<!-- 도서 목차 (도서내용 - bookContents) -->
           	<div class="form_section">
       			<div class="form_section_title">
       				<label>책 목차</label>
       			</div>
       			<div class="form_section_content bct">
       				<textarea name="bookContents" id="bookContents_textarea"></textarea>
       				<span class="ck_warn bookContents_warn">책 목차를 입력해주세요.</span>
       			</div>
       		</div>
           	<!-- 상품 이미지 -->
           	<!--
           	<div class="form_section">
       			<div class="form_section_title">
       				<label>상품 이미지</label>
       			</div>
       			<div class="form_section_content">
					<input type="file" id ="fileItem" name='uploadFile' style="height: 30px;">
					<div id="uploadResult">
					
						<div id="result_card">
							<div class="imgDeleteBtn">x</div>
							<img src="/display?fileName=test.png">
						</div>
																								
					</div>
      			</div>
       		</div>                     		
           	-->	
			<div class="btn_section">
				<button id="cancelBtn" class="btn cancel_btn">취 소</button>
	 			<button id="enrollBtn" class="btn enroll_btn">등 록</button>
	    	</div>
        </form>
	</div> 
	
</body>
</html>