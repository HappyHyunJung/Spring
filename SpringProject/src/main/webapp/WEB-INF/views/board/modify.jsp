<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="/resources/css/modifyMain.css">

<%@include file="../includes/header.jsp"%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(function () {
	let formObj = $("form");
	
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
	
	$('button').on("click", function(e) {
		e.preventDefault();
		let operation = $(this).data("oper");
		console.log(operation);
		
		if(operation === 'remove') {
			formObj.attr("action", "/board/remove");
		} else if (operation === 'list') {
			let pageNumTag = $("input[name='pageNum']").clone();
			let amountTag = $("input[name='amount']").clone();
			formObj.empty();
			formObj.attr("action", "/board/list").attr("method", "get");
			formObj.append(pageNumTag);
			formObj.append(amountTag);
		} else if (operation === 'modify') {
			let str = "";
			$(".uploadResult ul li").each(function(i, listItem) {
				let liObj = $(listItem);
				str += "<input type='hidden' name='attachList["+i+"].filename' value='" + liObj.data("filename")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='" + liObj.data("uuid")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uploadpath' value='" + liObj.data("path")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].filetype' value='" + liObj.data("type")+"'>";
			});
			formObj.append(str).submit();
		}
		formObj.submit();
	});
	// 첨부파일 업로드
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
	
	let bno = '<c:out value="${board.bno}"/>';
	$.getJSON("/board/getAttachList/" + bno, function(attachList) {
		console.log("attachList:" + attachList);
		let str = "";
		//callback -> array반복시 요청됨
		$(attachList).each(function(i, attach) {
			console.log(i, attach.uuid, attach.filename, attach.filetype);
			//이미지일 경우, 썸네일 화면에 노출
			if(attach.filetype ) {
				//썸네일 이미지 경로
				let fileCallPath = encodeURIComponent(attach.uploadpath + "\\s_" + attach.uuid + "_" + attach.filename);
				str +="<li data-path='" + attach.uploadpath + "'";
				str +=" data-uuid='" + attach.uuid + "' data-filename='" + attach.filename + "' data-type='" + attach.filetype + "'>";
				str += " <div>";
				str += "  <span>" + attach.filename + "</span>";
				str += "  <button type='button' data-file=\'"+fileCallPath+"\' data-type='image' ";
				str += "    class='btn btn-warning btn-circle'><i class='fa fa-times'></i>X</button><br>";
				str += "   <img src='/display?filename=" + fileCallPath + "'/>";
				str += " </div>";
				str += "</li>";
			} else {
				//이미지가 아닌 경우
				let fileCallPath = encodeURIComponent(attach.uploadpath + "\\" + attach.uuid + "_" + attach.filename);
				str +="<li data-path='" + attach.uploadpath + "'";
				str +=" data-uuid='" + attach.uuid + "' data-filename='" + attach.filename + "' data-type='" + attach.filetype + "'>";
				str += " <div>";
				str += "  <span>" + attach.filename + "</span>";
				str += "  <button type='button' data-file=\'"+fileCallPath+"\' data-type='file' ";
				str += "    class='btn btn-warning btn-circle'><i class='fa fa-times'></i>X</button><br>";
				str += "  <img src='/resources/img/attach.png'/>";
				str += " </div>";
				str += "</li>";
			}
		});
		$(".uploadResult ul").html(str);
		
		$(".uploadResult").on("click", "button", function(e) {
			console.log("delete file");
			if(confirm("Remove this file? ")) {
				let targetLi = $(this).closest("li");
				targetLi.remove();
			}
		});
	});
	
	function showUploadResult(result) {
		if(!result || result.length == 0) { return; }
		let uploadUL = $(".uploadResult ul");
		let str = "";
		//제이쿼리형으로 데이터를 변환하고 each로 인해 값을 하나하나 가져오게 됨
		$(result).each( function (i, obj) {
			console.log(result);
			if (obj.image) {
				let fileCallPath = encodeURIComponent(obj.uploadpath + "\\s_" + obj.uuid + "_" + obj.filename);
				str +="<li data-path='" + obj.uploadpath + "'";
				str +=" data-uuid='" + obj.uuid + "' data-filename='" + obj.filename + "' data-type='" + obj.image + "'>";
				str +="  <div>";
				str +="   <span> " + obj.filename + "</span>";
				str +="   <button type='button' data-file=\'" + fileCallPath + "\'"
				str +="     data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i>X</button><br>";
				//이미지일 경우 rest방식(동적) 파일 썸네일을 보여줌
				str +="   <img src='/display?filename=" + fileCallPath + "'/>";
				str +="  </div>";
				str +="</li>";
			} else {
				let fileCallPath = encodeURIComponent(obj.uploadpath + "\\" + obj.uuid + "_" + obj.filename);
				str +="<li data-path='" + obj.uploadpath + "'";
				str +=" data-uuid='" + obj.uuid + "' data-filename='" + obj.filename + "' data-type='" + obj.image + "'>";
				str +="  <div>";
				str +="   <span> " + obj.filename + "</span>";
				str +="   <button type='button' data-file=\'" + fileCallPath + "\'"
				str +="     data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i>X</button><br>";
				str +="   <img src='/resources/img/attach.png'/>";
				str +="  </div>";
				str +="</li>";
			}
		});
		uploadUL.append(str);
	}

});
</script>

<div class="wrapper_read">
	<div class="read_head">
		<h3>게시글 수정화면 입니다</h3>
	</div>
	<div class="read_line"></div>
	<form action="/board/modify" method="post">  <!--  -->
		<input type="hidden" name='pageNum' value='<c:out value="${criteria.pageNum }"/>'>
		<input type="hidden" name='amount' value='<c:out value="${criteria.amount }"/>'>
		<table class="read_table">
			<thead>
				<tr class="read_table_title">
					<th>번호</th>
					<td><input class="form-control" name="bno"
						value='<c:out value="${board.bno }"/>' readonly="readonly"></td>
				</tr>
				
				<tr class="read_table_title">
					<th>제목</th>
					<td><input class="form-control" name="title"
						value='<c:out value="${board.title }"/>'></td>
				</tr>
				<tr class="read_table_title">
					<th>작성자</th>
					<td><input class="form-control" name="writer"
						value='<c:out value="${board.writer }"/>' readonly="readonly"> </td>
				</tr>
				<tr class="read_table_title">
					<th>작성일</th>
					<td><input class="form-control" name="regdate  <!-- 왜 regDate로 하면 오류가 날까? -> BoardMapper.xml  -->
						value='<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate }"/>' readonly="readonly"> </td>
				</tr>
			</thead>
		</table>
		<div class="read_table_content">
			<textarea class="read_content" name="content"><c:out value="${board.content }"/></textarea>
		</div>
		<div class="field1 get-th field-style">
				<label><b>첨부파일</b></label>
			</div>
			<div class="field2 get-td field-style uploadDiv">
				<input type="file" name="uploadFile" id="uploadFile" class="file-input" multiple="multiple"	/>		
			</div>
			<div class="uploadResult">
				<ul></ul>
			</div>
		<c:if test="${auth.userid eq board.writer }">
			<button type="submit" data-oper='modify' class="read_button" id="modify_btn">수정</button>
			<button type="submit" data-oper='remove' class="read_button" id="remove_btn">삭제</button>
		</c:if>
		<button type="submit" data-oper="list" class="read_button" id="list_btn">List</button>
	</form>
</div>

<%@include file="../includes/footer.jsp" %>	