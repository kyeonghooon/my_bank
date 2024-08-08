<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- header.jsp -->
<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<!-- start of context.jsp(xxx.jsp) -->
<div class="col-sm-8">
	<h2>로그인</h2>
	<h5>Bank App에 오신걸 환영합니다.</h5>

	<form action="/account/save" method="post">
		<div class="form-group">
			<label for="number">number:</label> <input type="text" class="form-control" placeholder="Enter number" id="number" name="number" value="1002-1234">
		</div>
		<div class="form-group">
			<label for="pwd">password:</label> <input type="password" class="form-control" placeholder="Enter password" id="pwd" name="password" value="1234">
		</div>
		<div class="form-group">
			<label for="balance">balance:</label> <input type="number" class="form-control" placeholder="Enter balance" id="balance" name="balance" value="10000">
		</div>
		<div class="text-right">
			<button type="submit" class="btn btn-primary">계좌 생성</button>
		</div>
	</form>

</div>
<!-- end of col-sm-8 -->
</div>
</div>
<!-- end of context.jsp(xxx.jsp) -->

<!-- footer.jsp -->
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
