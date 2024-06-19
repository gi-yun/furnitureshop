package com.exam.controller;

import java.util.List;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.exam.dto.CartDTO;
import com.exam.dto.MemberDTO;
import com.exam.service.CartService;
import com.exam.service.MemberService;


@Controller
@SessionAttributes(names = {"login"})
public class MemberController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	MemberService memberService;
	CartService cartService;
	
	



	public MemberController(MemberService memberService, CartService cartService) {
		super();
		this.memberService = memberService;
		this.cartService = cartService;
	}


	@GetMapping("/idCheck")
	public @ResponseBody  String idCheck(@RequestParam String userid) {
		MemberDTO dto = memberService.idCheck(userid);
		String mesg = "사용가능";
		if(dto!=null) {
			mesg = "사용불가";
		}
		return mesg;
	}
	

	@GetMapping("/signup")
	public String signupForm(ModelMap m) {
		
		MemberDTO dto = new MemberDTO();
		m.addAttribute("memberDTO", dto);
		
		return "memberForm";
	}
	@PostMapping("/signup")
	public String signup(@Valid MemberDTO  dto, BindingResult result) {
		
		if(result.hasErrors()) {
			return "memberForm";
		}
		//DB연동
		logger.info("logger:signup:{}", dto);
		
		int n = memberService.memberAdd(dto);
		
		return "redirect:main";
	}
	
	
	@GetMapping("/mypage")
	public String mypage(ModelMap m) {
		
		// 세션에 저장된 MemberDTO 얻기
		MemberDTO dto = (MemberDTO)m.getAttribute("login");
		logger.info("logger:mypage:{}", dto);
		String userid = dto.getUserid();
		
		MemberDTO searchDTO = memberService.mypage(userid);
		m.addAttribute("login", searchDTO);
		
		return "mypage";
	}
	
	@GetMapping("/cartList")
	public String cartlist(ModelMap m) {
		
		// 세션에 저장된 MemberDTO 얻기
		MemberDTO dto = (MemberDTO)m.getAttribute("login");
		logger.info("logger:mypage:{}", dto);
		String userid = dto.getUserid();
		
		 String nextPage=null;
		   if(dto!=null) {
			   
			   List<CartDTO> cartList = cartService.cartList(userid);
			   m.addAttribute("cartList", cartList);
			   nextPage="cartList"; 
			   logger.info("logger:cartlist:{}", cartList);
		   }else {
			   nextPage="login"; 
		   }
		
		return nextPage;
	}
	
	
	
	
}






