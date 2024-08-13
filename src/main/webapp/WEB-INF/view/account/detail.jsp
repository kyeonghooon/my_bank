<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- header.jsp -->
<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<!-- start of context.jsp(xxx.jsp) -->
<div class="col-sm-8">
	<h2>계좌 상세 보기(인증)</h2>
	<h5>Bank App에 오신걸 환영합니다.</h5>

	<div class="bg-light p-md-5">
		<div class="user--box">
			${principal.username}님 계좌<br> 계좌번호 : ${account.number}<br> 잔액 : ${account.formatKoreanWon(account.balance)}
		</div>
		<br>
		<div>
			<a href="?type=all" class="btn btn-outline-primary">전체</a> <a href="?type=deposit" class="btn btn-outline-primary">입금</a> <a href="?type=withdrawal"
				class="btn btn-outline-primary">출금</a>
		</div>
		<br>
		<table class="table table-striped">
			<thead>
				<tr>
					<th>날짜</th>
					<th>보낸이</th>
					<th>받은이</th>
					<th>입출금 금액</th>
					<th>계좌잔액</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${historyList}" var="historyAccount">
					<tr>
						<td>${historyAccount.timestampToString(historyAccount.createdAt)}</td>
						<td>${historyAccount.sender}</td>
						<td>${historyAccount.receiver}</td>
						<td>${historyAccount.formatKoreanWon(historyAccount.amount)}</td>
						<td>${historyAccount.formatKoreanWon(historyAccount.balance)}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<br>
		<div class="d-flex justify-content-center">
			<ul class="pagination">
				<li class="page-item ${currentPage == 1 ? 'disabled' : ''}"><a class="page-link" href="/rest-account/detail/${account.id}?type=${type}&page=1">First</a></li>
				<li class="page-item ${currentPage == 1 ? 'disabled' : ''}"><a class="page-link" href="/rest-account/detail/${account.id}?type=${type}&page=${currentPage - 1}">Previous</a></li>
				<c:forEach begin="${startPage}" end="${endPage}" var="page">
					<li class="page-item ${page == currentPage ? 'active' : ''}"><a class="page-link" href="/rest-account/detail/${account.id}?type=${type}&page=${page}">${page}</a></li>
				</c:forEach>
				<li class="page-item ${currentPage == totalPage ? 'disabled' : ''}"><a class="page-link" href="/rest-account/detail/${account.id}?type=${type}&page=${currentPage + 1}">Next</a></li>
				<li class="page-item ${currentPage == totalPage ? 'disabled' : ''}"><a class="page-link" href="/rest-account/detail/${account.id}?type=${type}&page=${totalPage}">End</a></li>
			</ul>
		</div>
	</div>

</div>
<!-- end of col-sm-8 -->
</div>
</div>
<!-- end of context.jsp(xxx.jsp) -->
<script>
	document.addEventListener('DOMContentLoaded', () => {
		document.querySelectorAll(".page-link").forEach(link => {
			link.addEventListener('click', (event) => {
				event.preventDefault();
				const url = link.getAttribute('href');
				fetch(url, {
					method: "GET",
					headers: {
						"Content-type": "application/json",
					},
				})
				.then((proData) => {
					return proData.text();
				})
				.then((bodyText) => {
					const response = JSON.parse(bodyText);
					console.log(response);
					updateHistoryTable(response.historyList);
					updatePagination(response);
				})
			});
		});
	});
	function updateHistoryTable(historyList) {
        const tbody = document.querySelector('.table-striped tbody');
        tbody.innerHTML = '';  // 기존 데이터 초기화
        historyList.forEach(historyAccount => {
            let row = document.createElement('tr');
				let createdAt = document.createElement('td');
				createdAt.textContent = historyAccount.formattedCreatedAt;
				row.append(createdAt);
				let sender = document.createElement('td');
				sender.textContent = historyAccount.sender;
				row.append(sender);
				let receiver = document.createElement('td');
				receiver.textContent = historyAccount.receiver;
				row.append(receiver);
				let amount = document.createElement('td');
				amount.textContent = historyAccount.formattedAmount;
				row.append(amount);
				let balance = document.createElement('td');
				balance.textContent = historyAccount.formattedBalance;
				row.append(balance);
				console.log(row);
            tbody.append(row);
        });
    }
	 function updatePagination(response){
		const accountId = response.account.id;
		const currentPage = response.currentPage;
		const startPage = response.startPage;
		const endPage = response.endPage;
		const totalPage = response.totalPage;
		const type = response.type;
		const ul = document.querySelector(".pagination")
		ul.innerHTML = '';
		let first = document.createElement('li');
		first.className = `page-item ${currentPage == 1 ? 'disabled' : ''}`;
		let firstA = document.createElement('a');
		firstA.className = "page-link";
		firstA.setAttribute("href", "/rest-account/detail/" + accountId + "?type=" + type + "&page=1");
		firstA.textContent = "First";
		first.append(firstA);
		ul.append(first);
		let previous = document.createElement('li');
		previous.className = `page-item ${currentPage == 1 ? 'disabled' : ''}`;
		let previousA = document.createElement('a');
		previousA.className = "page-link";
		previousA.setAttribute("href", "/rest-account/detail/" + accountId + "?type=" + type + "&page=" + (currentPage - 1));
		previousA.textContent = "Previous";
		previous.append(previousA);
		ul.append(previous);
		let next = document.createElement('li');
		next.className = `page-item ${currentPage == totalPage ? 'disabled' : ''}`;
		let nextA = document.createElement('a');
		nextA.className = "page-link";
		nextA.setAttribute("href", "/rest-account/detail/" + accountId + "?type=" + type + "&page=" + (currentPage + 1));
		nextA.textContent = "Next";
		next.append(nextA);
		ul.append(next);
	 }
</script>
<!-- footer.jsp -->
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
