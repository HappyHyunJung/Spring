<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/resources/css/registerFomMain.css">

<%@include file="../includes/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	$(function () {
		let regex = new RegExp("(.*)\.(exe|xip|alz)$");
		let maxSize = 5*1024*1024;
		function checkExtension(filename, fileSize) {
			if(fileSize >= maxSize) {
				alert("파일 사이즈 초과");
				return false;
			}
			if (regex.test (filename)) {
				alert("해당 종류의 파일은 업로드할 없습니다.");
				return false;
			}
			return true;
		}
		
		$("#uploadFile").on("change", function(e) {
			let formData = new FormData();  // ajax에서 form태그처럼 비슷하게 데이터를 보내기 위해 FormData 객체를 생성한다
			let inputFile = $("#uploadFile");
			let files = inputFile[0].files;
			for (let i = 0; i < files.length; i++) {
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
				success: function(result) {
					console.log(result);
					showUploadResult(result);
				}
			});
		});
		
		function showUploadResult(result) {
			if(!result || result.length == 0) { return;}
			let uploadUL = $(".uploadResult ul");
			let str = "";
			$(result).each(function (i, obj) {   // i 순서 , obj의 result의 object
				if (obj.image) {
					let fileCallPath = encodeURIComponent(obj.uploadpath+ "\\s_"+obj.uuid + "_" + obj.filename);
					str += "<li data-path='"+obj.uploadpath+"'";
					str += "  data-uuid='"+obj.uuid+"' data-filename='"+obj.filename+"' data-type='"+obj.image+"'>";
					str += "  <div>";
					str += "    <span> "+obj.filename+"</span>";
					str += "    <button type='button' data-file=\'"+fileCallPath+"\' ";
					str += "      data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'>";
					str += "        <img id='remove' src='/resources/img/removeBtn.png' style='width: 20px; height:20px;'></i></button><br>";
					str += "    <img src='/display?filename="+fileCallPath+"' style='width:150px; height:130px; '/>";
					str += "  </div>";
					str += "</li>";
				} else {
					let fileCallPath = encodeURIComponent(obj.uploadpath+"\\"+obj.uuid+"_"+obj.filename); 
					str += "<li data-path='"+obj.uploadpath+"'";
					str += "  data-uuid='"+obj.uuid+"' data-filename='"+obj.filename+"' data-type='"+obj.image+"'>";
					str += "  <div>";
					str += "    <span> "+ obj.filename+"</span>";
					str += "    <button type='button' data-file=\'"+fileCallPath+"\'";
					str += "      data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'>";
					str += "        <img id='remove' src='/resources/img/removeBtn.png' style='width: 20px; height:20px;'></i></button><br>";
					str += "    <img src='/resources/img/attach.png' style='width:130px; height:150px;'/>";
					str += "  </div>";
					str += "</li>";
				}
				
			});
			uploadUL.append(str);
		}
		// remove 동작
		$('.uploadResult').on("click", "li button", function (e) {
			console.log("delete file");
			let targetFile = $(this).data("file");
			let type = $(this).data("type");
			console.log('remove'+ " " + targetFile + " " + type);
			let targetLi = $(this).parent().closest('li');
			let attach = {filename: targetFile, type: type};
			$.ajax({
				type : 'delete',
				url: '/deleteFile',
				data : JSON.stringify(attach),
				contentType: "application/json; charset=utf-8",
				success: function(result) {
					alert(result);
					targetLi.remove();
				}
			});
		});
		
		$(".register_submit_button").on("click", function (e) {
			console.log("글 등록")
			e.preventDefault();
			let formObj = $(".register_form");
			let str = "";
			
			$(".uploadResult ul li").each(function(i, listItem) {
				let liObj = $(listItem);
				console.log("----------------------------------");
				console.log(liObj.data("filename"));
				str += "<input type='hidden' name='attachList["+i+"].filename' value='" + liObj.data("filename") + "'>";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='" + liObj.data("uuid") + "'>";
				str += "<input type='hidden' name='attachList["+i+"].uploadpath' value='" + liObj.data("path") + "'>";
				str += "<input type='hidden' name='attachList["+i+"].filetype' value='" + liObj.data("type") + "'>";
			});
			console.log(str);
			formObj.append(str).submit();
		});
	});
</script>


</head>
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
					<input class="title_area" maxlength="50" readonly="readonly" name="writer" value="${auth.userid }"/>
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
		
		<!-- 첨부파일 -->
		<div class="article-bottom">
			<div class="field1 get-th field-style">
				<label><b>첨부파일</b></label>
			</div>
			<div class="field2 get-td">
				<input type="file" name="uploadFile" id="uploadFile" class="file-input" multiple />
			</div>
			<div class="uploadResult">
				<ul></ul>
			</div>
		</div>
	</div> <!-- wrapper_register -->
	
	<%@include file="../includes/footer.jsp" %>
</body>
</html>