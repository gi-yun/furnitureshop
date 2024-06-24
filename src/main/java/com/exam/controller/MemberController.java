package com.exam.controller;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.exam.dto.CartDTO;
import com.exam.dto.MemberDTO;
import com.exam.service.CartService;
import com.exam.service.MemberService;

@Controller
//@SessionAttributes(names = {"login"})
public class MemberController {

	Logger logger = LoggerFactory.getLogger(getClass());

	MemberService memberService;
	CartService cartService;

	public MemberController(MemberService memberService, CartService cartService) {
		super();
		this.memberService = memberService;
		this.cartService = cartService;
	}

	// 아이디 중복 체크
	@GetMapping("/idCheck")
	public @ResponseBody String idCheck(@RequestParam String userid) {
		MemberDTO dto = memberService.idCheck(userid);
		String mesg = "사용가능";
		if (dto != null) {
			mesg = "사용불가";
		}
		return mesg;
	}

	// 회원가입 get
	@GetMapping(value = { "/signup" })
	public String signupForm(ModelMap m) {

		MemberDTO dto = new MemberDTO();
		m.addAttribute("memberDTO", dto);

		return "memberForm";
	}// @GetMapping("/idCheck")

	// 회원가입 post 정보 가져오기
	@PostMapping("/signup")
	public String signup(@Valid MemberDTO dto, BindingResult result) {

		if (result.hasErrors()) {
			return "memberForm";
		}
		String encptPw = new BCryptPasswordEncoder().encode(dto.getPasswd());
		dto.setPasswd(encptPw);
		// DB연동
		logger.info("logger:signup:{}", dto);

		int n = memberService.memberAdd(dto);

		return "redirect:main";
	}// @PostMapping("/signup")

	@GetMapping("/mypage")
	public String mypage(ModelMap m) {

		// 세션에 저장된 MemberDTO 얻기
//		MemberDTO dto = (MemberDTO)m.getAttribute("login");
//		logger.info("logger:mypage:{}", dto);
//		String userid = dto.getUserid();

//		MemberDTO searchDTO = memberService.mypage(userid);
//		m.addAttribute("login", searchDTO);

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		logger.info("logger:Authentication:{}", auth);
		MemberDTO searchDTO = (MemberDTO) auth.getPrincipal();
		logger.info("logger:Member:{}", searchDTO);
		m.addAttribute("login", searchDTO);

		return "mypage";
	}// @GetMapping("/mypage")

	// 장바구니 목록 가져오기
	@GetMapping("/cartList")
	public String cartlist(ModelMap m) {

//		// 세션에 저장된 MemberDTO 얻기
//		MemberDTO dto = (MemberDTO)m.getAttribute("login");
//		logger.info("logger:mypage:{}", dto);
//		String userid = dto.getUserid();
//		
//		 String nextPage=null;
//		   if(dto!=null) {
//			   
//			   List<CartDTO> cartList = cartService.cartList(userid);
//			   m.addAttribute("cartList", cartList);
//			   nextPage="cartList"; 
//			   logger.info("logger:cartlist:{}", cartList);
//		   }else {
//			   nextPage="login"; 
//		}

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		logger.info("logger:Authentication:{}", auth);
		MemberDTO dto = (MemberDTO) auth.getPrincipal();
		logger.info("logger:Member:{}", dto);
		String userid = dto.getUserid();
		List<CartDTO> cartList = cartService.cartList(userid);
		m.addAttribute("cartList", cartList);
		logger.info("logger:cartList:{}", cartList);

		return "cartList";
	}// @GetMapping("/cartList")

//	@PostMapping("/cartAdd")
//	public String cartAdd(@ModelAttribute CartDTO cartDTO, ModelMap m, BindingResult result) {
//		MemberDTO dto = (MemberDTO)m.getAttribute("login");
//		logger.info("logger:mypage:{}", dto);
//		String nextPage=null;
//		
//		if(result.hasErrors()) {
//			return "redirect:main";
//		}
//		int n = cartService.cartAdd(cartDTO);
//		logger.info("logger:mypage:{}", cartDTO);
//
//		
//		return "redirect:main";
//	}

	@PostMapping("/cartAdd")
	public String cartAdd(@ModelAttribute CartDTO cartDTO, ModelMap m, BindingResult result) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		logger.info("logger:Authentication:{}", auth);
		MemberDTO dto = (MemberDTO) auth.getPrincipal();
		logger.info("logger:Member:{}", dto);
		String userid = dto.getUserid();

		cartDTO.setUserid(dto.getUserid());
		cartDTO.setgCartDate(LocalDate.now()); // 현재 날짜 설정
		logger.info("logger:userid:{}", dto);

		if (result.hasErrors()) {
			return "redirect:main";
		}

		int n = cartService.cartAdd(cartDTO);
		logger.info("logger:cartAdd:{}", cartDTO);
		return "redirect:main";
	}// @PostMapping("/cartAdd")
	
	@PostMapping("/cartBuy")
	public String cartbuy(@ModelAttribute CartDTO cartDTO, ModelMap m, BindingResult result) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		logger.info("logger:Authentication:{}", auth);
		MemberDTO dto = (MemberDTO) auth.getPrincipal();
		logger.info("logger:Member:{}", dto);
		String userid = dto.getUserid();

		cartDTO.setUserid(dto.getUserid());
		logger.info("logger:userid:{}", dto);

		if (result.hasErrors()) {
			return "redirect:mypage";
		}

		int n = cartService.cartAdd(cartDTO);
		logger.info("logger:cartAdd:{}", cartDTO);
		return "redirect:cartList";
	}// @PostMapping("/cartBuy")

	@PostMapping("/cartDelete")
	public ResponseEntity<String> cartDelete(@RequestParam("num") int num) {
		
		logger.info("콘솔 확인 : num ", num);
		try {
			int result = cartService.cartDelete(num);
			if (result > 0) {
				return ResponseEntity.ok("Success");
			} else {
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed");
			}
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Exception");
		}

	}// @DeleteMapping("/cartDelete")
	
	 @PostMapping("/cartDeleteAll")
	    public ResponseEntity<String> cartDeleteAll(@RequestParam("nums") List<Integer> nums) {
	        logger.info("콘솔 확인 : nums ", nums);
	        try {
	            int result = cartService.cartDeleteAll(nums);
	            if (result > 0) {
	                return ResponseEntity.ok("Success");
	            } else {
	                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed");
	            }
	        } catch (Exception e) {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Exception");
	        }
	    }// @PostMapping("/cartDeleteAll")
	 
	 
//	 
//	 @PostMapping("/updateMember")
//		public String updateMember(@ModelAttribute MemberDTO memberDTO, ModelMap m, BindingResult result) {
//			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//			logger.info("logger:Authentication:{}", auth);
//			MemberDTO dto = (MemberDTO) auth.getPrincipal();
//			logger.info("logger:Member:{}", dto);
//
//			memberDTO.setUserid(dto.getUserid());
//			logger.info("logger:userid:{}", dto);
//
//			if (result.hasErrors()) {
//				return "redirect:mypage";
//			}
//
//			int n = memberService.updateMember(memberDTO);
//			logger.info("logger:cartAdd:{}", memberDTO);
//			return "redirect:main";
//		}// ver.1 로그아웃후 다시 로그인하면 적용됨.
	 
	 
		
//		@PostMapping("/updateMember")
//		public String update( MemberDTO dto, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
//		    if (bindingResult.hasErrors()) {
//		        redirectAttributes.addFlashAttribute("errors", bindingResult.getAllErrors());
//		        return "redirect:mypage";  // Redirect back to the form with error messages
//		    }
//
//		    try {
//		    	logger.info("logger:update:{}", dto);
//		        memberService.updateMember(dto);
//		        redirectAttributes.addFlashAttribute("successMessage", "업데이트 성공!!");
//		    } catch (Exception e) {
//		        redirectAttributes.addFlashAttribute("errorMessage", "업데이트 실패했습니다..: " + e.getMessage());
//		    }
//
//		    return "redirect:mypage";
//		}  //ver.2 //실시간 적용이 안됨 로그아웃 후에 다시 로그인하면 정보가 적용
		
	
	 
	 
	 
	 
	 
	 
	 @PostMapping("/updateMember")
	    public String updateMember(@ModelAttribute MemberDTO memberDTO, BindingResult result, RedirectAttributes redirectAttributes) {
	        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	        MemberDTO dto = (MemberDTO) auth.getPrincipal();
	        
	        memberDTO.setUserid(dto.getUserid());

	        if (result.hasErrors()) {
	            redirectAttributes.addFlashAttribute("errors", result.getAllErrors());
	            return "redirect:mypage";
	        }

	        try {
	            int n = memberService.updateMember(memberDTO);

	            if (n > 0) {
	                // 세션 업데이트
	                UsernamePasswordAuthenticationToken newAuth = new UsernamePasswordAuthenticationToken(
	                        memberDTO, auth.getCredentials(), auth.getAuthorities());
	                SecurityContextHolder.getContext().setAuthentication(newAuth);

	                redirectAttributes.addFlashAttribute("successMessage", "업데이트 성공!!");
	            } else {
	                redirectAttributes.addFlashAttribute("errorMessage", "업데이트 실패했습니다.");
	            }
	        } catch (Exception e) {
	            redirectAttributes.addFlashAttribute("errorMessage", "업데이트 중 오류가 발생했습니다: " + e.getMessage());
	        }

	        return "redirect:main";
	    } // ver.3 사용시 즉각즉각 업데이트가 됨. mypage에서 logout 시 모든 메모리가 삭제됨.



} // public class
