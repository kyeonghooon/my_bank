package com.tenco.bank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import com.tenco.bank.dto.SaveDTO;
import com.tenco.bank.handler.exception.DataDeliveryException;
import com.tenco.bank.handler.exception.RedirectException;
import com.tenco.bank.repository.interfaces.AccountRepository;
import com.tenco.bank.repository.model.Account;
import com.tenco.bank.utils.Define;

@Service
public class AccountService {

	@Autowired
	private AccountRepository accountRepository;

	public void createAccount(SaveDTO dto, Integer principalId) {
		int result = 0;
		try {
			accountRepository.insert(dto.toAccount(principalId));
		} catch (DataAccessException e) {
			throw new DataDeliveryException(Define.EXIST_ACCOUNT, HttpStatus.INTERNAL_SERVER_ERROR);
		} catch (Exception e) {
			throw new RedirectException(Define.UNKNOWN, HttpStatus.SERVICE_UNAVAILABLE);
		}
		if (result == 0) {
			throw new DataDeliveryException(Define.FAIL_TO_CREATE_ACCOUNT, HttpStatus.BAD_REQUEST);
		}
	}

	public List<Account> readAccountListByUserId(Integer principalId) {
		List<Account> accountListEntity = null;
		try {
			accountListEntity = accountRepository.findByUserId(principalId);
		} catch (DataAccessException e) {
			throw new DataDeliveryException(Define.FAILED_PROCESSING, HttpStatus.INTERNAL_SERVER_ERROR);
		} catch (Exception e) {
			throw new RedirectException(Define.UNKNOWN, HttpStatus.SERVICE_UNAVAILABLE);
		}
		return accountListEntity;
	}

}
