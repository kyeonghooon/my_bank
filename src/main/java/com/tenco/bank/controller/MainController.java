package com.tenco.bank.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller // IoC 대상(싱글톤 패턴 관리가 된다.) --> 제어의 역전
public class MainController {

	// REST API 기반으로 주소 설계 가능

	// 주소 설계
	// http://localhost:8080/main-page
	@GetMapping({ "/main-page", "/index" })
	// @ResponseBody
	public String mainPage() {
		// [JSP 파일 찾기 (yml 설정) ] - 뷰 리졸버
		// prefix: /WEB-INF/view
		// /main
		// suffix: .jsp
		return "main";
	}
}
