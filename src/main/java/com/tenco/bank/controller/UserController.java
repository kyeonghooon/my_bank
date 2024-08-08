package com.tenco.bank.controller;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tenco.bank.dto.SignUpDTO;
import com.tenco.bank.handler.exception.DataDeliveryException;
import com.tenco.bank.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

	private UserService userService;

	// @Autowired
	public UserController(UserService userService) {
		this.userService = userService;
	}

	/**
	 * 회원 가입 페이지 요청 주소 설계 : http://localhost:8080/user/sign-up
	 * 
	 * @return signUp.jsp
	 */
	@GetMapping("/sign-up")
	public String signUpPage() {
		return "user/signUp";
	}

	/**
	 * 회원 가입 로직 처리 요청 주소 설계 : http://localhost:8080/user/sign-up
	 * 
	 * @param dto
	 * @return
	 */
	@PostMapping("/sign-up")
	public String signUpProc(SignUpDTO dto) {
		// 유효성 검사
		if (dto.getUsername() == null || dto.getUsername().trim().isEmpty()) {
			throw new DataDeliveryException("username을 입력하세요", HttpStatus.BAD_REQUEST);
		}
		if (dto.getPassword() == null || dto.getPassword().trim().isEmpty()) {
			throw new DataDeliveryException("password를 입력하세요", HttpStatus.BAD_REQUEST);
		}
		if (dto.getFullname() == null || dto.getFullname().trim().isEmpty()) {
			throw new DataDeliveryException("fullname을 입력하세요", HttpStatus.BAD_REQUEST);
		}
		// 서비스 객체로 전달
		userService.createUser(dto);
		// 페이지 이동
		return "redirect:/user/sign-in";
	}

}
