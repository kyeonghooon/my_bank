package com.tenco.bank.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.tenco.bank.handler.exception.DataDeliveryException;
import com.tenco.bank.repository.model.Account;
import com.tenco.bank.repository.model.HistoryAccount;
import com.tenco.bank.service.AccountService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/rest-account")
@RequiredArgsConstructor
public class AccountRestController {

	private final AccountService accountService;
	
	@GetMapping("/detail/{accountId}")
	@ResponseBody
	public ResponseEntity<?> detail(@PathVariable(name = "accountId") Integer accountId, //
			@RequestParam(required = false, name = "type") String type, @RequestParam(defaultValue = "1", name = "page") int page) {
		// 유효성 검사
		List<String> validTypes = Arrays.asList("all", "deposit", "withdrawal");
		if (!validTypes.contains(type)) {
			throw new DataDeliveryException("유효하지 않은 접근 입니다.", HttpStatus.BAD_REQUEST);
		}
		Account account = accountService.readAccountById(accountId);
		int pageSize = 2; // 한페이지에 2개
		int offset = (page - 1) * pageSize;
		int totalHistories = accountService.countHistoryByAccountIdAndType(type, accountId);
		int totalPage = (int) Math.ceil((double) totalHistories / pageSize);
		int pageBlock = 5;
		int tenCount = (int) Math.ceil(((double) page / pageBlock) - 1) * pageBlock;
		int startPage = tenCount + 1;
		int endPage = (tenCount + 5) > totalPage ? totalPage : (tenCount + pageBlock);
		List<HistoryAccount> historyList = accountService.readHistoryByAccountId(type, accountId, offset, pageSize);
		for (int i = 0; i < historyList.size(); i++) {
			HistoryAccount historyAccount = historyList.get(i);
			historyAccount.setFormattedCreatedAt(historyAccount.timestampToString(historyAccount.getCreatedAt()));
			historyAccount.setFormattedAmount(historyAccount.formatKoreanWon(historyAccount.getAmount()));
			historyAccount.setFormattedBalance(historyAccount.formatKoreanWon(historyAccount.getBalance()));
		}
		Map<String, Object> response = new HashMap<>();
		response.put("type", type);
		response.put("currentPage", page);
		response.put("startPage", startPage);
		response.put("endPage", endPage);
		response.put("totalPage", totalPage);
		response.put("account", account);
		response.put("historyList", historyList);
		return ResponseEntity.status(HttpStatus.OK).body(response);
	}
}
