<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- header.jsp -->
<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<!-- start of context.jsp(xxx.jsp) -->
<div class="col-sm-8">
	<h2>회원 가입</h2>
	<h5>Bank App에 오신걸 환영합니다.</h5>

	<form action="/user/sign-up" method="post">
		<div class="form-group">
			<label for="username">username:</label> <input type="username" class="form-control" placeholder="Enter username" id="username" name="username" value="야스오1">
		</div>
		<div class="form-group">
			<label for="pwd">password:</label> <input type="password" class="form-control" placeholder="Enter password" id="pwd" name="password" value="asd123">
		</div>
		<div class="form-group">
			<label for="fullname">fullname:</label> <input type="fullname" class="form-control" placeholder="Enter fullname" id="fullname" name="fullname" value="바람검객">
		</div>
		<button type="submit" class="btn btn-primary" id="btn" >회원가입</button>
	</form>

</div>
<!-- end of col-sm-8 -->
</div>
</div>
<!-- end of context.jsp(xxx.jsp) -->
<script>
	document.getElementById("btn").addEventListener('click', function(){
		let username = document.getElementById("username").value;
		let password = document.getElementById("pwd").value;
		let fullname = document.getElementById("fullname").value;
		if (username == null || username.trim() == ""){
			alert("username을 입력해주세요");
			history.back();
			return;
		}
		if (password == null || password.trim() == ""){
			alert("password를 입력해주세요");
			history.back();
			return;
		}
		if (fullname == null || fullname.trim() == ""){
			alert("fullname을 입력해주세요");
			history.back();
			return;
		}
		
	});
</script>
<!-- footer.jsp -->
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
