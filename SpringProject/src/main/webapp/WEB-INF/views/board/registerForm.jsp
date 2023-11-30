<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../includes/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 작성</title>
</head>
<link rel="stylesheet" href="/resources/css/registerFomMain.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(function() {
		//해당 파일은 업로드x
		let regex = new RegExp("(.*)\.(exe|zip|alz)$");
		let maxSize = 5*1024*1024;
		function checkExtension(filename, fileSize) {
			if (fileSize >= maxSize) {
				alert("파일 사이즈 초과");
				return false;
			}
			if (regex.test(filename)) {
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			return true;
		}
		$("#uploadFile").on("change", function(e) {
			let formData = new FormData();
			let inputFile = $("#uploadFile");
			let files = inputFile[0].files;
			for (let i=0; i<files.length; i++) {
				if (!checkExtension(files[i].name, files[i].size)) {
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			$.ajax({
				type : 'post',
				url : '/uploadFileAjax',
				processData : false,
				contentType : false,
				data : formData,
				success : function(result) {
					console.log("result: " + result);
					showUploadResult(result);
				}
			});
		});
		// 글 작성 단계 - 첨부파일 이미지와 이미지파일 썸네일 보이게 하는 기능
		function showUploadResult(result) {
			if(!result || result.length == 0) { return; }
			let uploadUL = $(".uploadResult ul");
			uploadUL.css("width", "300px").css("height", "150px");
			uploadUL.css("display", "flex").css("flex-wrap", "wrap");
			let str = "";
			//제이쿼리형으로 데이터를 변환하고 each로 인해 값을 하나하나 가져오게 됨
			$(result).each( function (i, obj) {
				console.log(result);
				if (obj.image) {
					let fileCallPath = encodeURIComponent(obj.uploadpath + "\\s_" + obj.uuid + "_" + obj.filename);
					str +="<li style='width:150px; height:150px; position:relative;' data-path='" + obj.uploadpath + "'";
					str +=" data-uuid='" + obj.uuid + "' data-filename='" + obj.filename + "' data-type='" + obj.image + "'>";
					str +="  <div>";
					str +="   <span> " + obj.filename + "</span>";
					str +="   <button type='button' data-file=\'" + fileCallPath + "\'";
					str +="     data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i>";
					str +="			<img id='remove' src='/resources/img/removeBtn.png' style='width: 20px; height:20px; position:absolute; top:0px; right:0px;'></button><br>";
					//이미지일 경우 rest방식(동적) 파일 썸네일을 보여줌
					str +="   <img src='/display?filename=" + fileCallPath + "' style='width: 80px; height:70px;'/>";
					str +="  </div>";
					str +="</li>";
				} else {
					let fileCallPath = encodeURIComponent(obj.uploadpath + "\\" + obj.uuid + "_" + obj.filename);
					str +="<li style='width:150px; height:150px; position:relative;' data-path='" + obj.uploadpath + "'";
					str +=" data-uuid='" + obj.uuid + "' data-filename='" + obj.filename + "' data-type='" + obj.image + "'>";
					str +="  <div>";
					str +="   <span> " + obj.filename + "</span>";
					str +="   <button type='button' data-file=\'" + fileCallPath + "\'";
					str +="     data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i>";
					str +="			<img id='remove' src='/resources/img/removeBtn.png' style='width: 20px; height:20px; position:absolute; top:0px; right:0px;'></button><br>";
					str +="   <img src='/resources/img/attach.png' style='width: 80px; height:70px;'/>";
					str +="  </div>";
					str +="</li>";
				}
			});
			uploadUL.append(str);
		}
		//첨부파일 삭제
		$(".uploadResult").on("click", "li button", function(e) {
			console.log('deleteBtn click');
			let targetFile = $(this).data("file");
			let filetype = $(this).data("type");
			let targetLi = $(this).parent().closest("li");
			let attach = {
					fileName : targetFile,
					type : filetype
			};
			
			$.ajax({
				type : 'delete',
				url : '/deleteFile',
				data : JSON.stringify(attach),
				contentType : "application/json; charset=utf-8",
				success : function(result) {
					alert(result);
					targetLi.remove();
				}
			});
		});
		//글 등록 버튼 클릭
		$(".register_submit_button").on("click", function(e) {
			e.preventDefault();
			console.log('registerBtn click');
			let formObj = $(".register_form");
			let str = "";
			$(".uploadResult ul li").each(function(i, listItem) {
				let liObj = $(listItem);
				console.log("----------------------------------------");
				console.log(liObj.data("filename"));
				str += "<input type='hidden' name='attachList["+i+"].filename' value='" + liObj.data("filename")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='" + liObj.data("uuid")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uploadpath' value='" + liObj.data("path")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].filetype' value='" + liObj.data("type")+"'>";
			});
			console.log(str);
			formObj.append(str).submit();
		});
		
		
		
	});
</script>
<body>
	<div class="wrapper_register">
		<div class="register_head">
			<h3>게시판 작성 화면 입니다</h3>
		</div>
		<div class="register_line"></div>
		<div class="register_body">
			<form class="register_form" method="post" action="/board/register">
				<div class="register_title">
					<input class="title_area" maxlength="50" placeholder="제목" name="title" required="required"/>
					<input class="title_area" maxlength="50" readonly="readonly" name="writer" value="${auth.userid}"/>
				</div>
				<div class="register_written">
					<textarea type="text" class="written_area" placeholder="내용" name="content" required="required"></textarea>
				</div>
				<div class="register_submit">
					<button class="register_submit_button submit" type="submit">작성</button>
					<button class="register_submit_button reset" type="reset">취소</button>
				</div>
			</form>
		</div>
	</div>
	<div class="article-bottom">
		<div class="field1 get-th field-style">
			<label><b>첨부파일</b></label>
		</div>
		<div class="field2 get-td">
			<input type="file" name="uploadFile" id="uploadFile" class="file-input" multiple/>
		</div>
		<div class="uploadResult">
			<ul></ul>
		</div>
	</div>
	
</body>
</html>
<%@include file="../includes/footer.jsp" %>