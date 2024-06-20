package com.exam.security;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import com.exam.dto.MemberDTO;
import com.exam.service.MemberService;

@Component
public class AuthProvider implements AuthenticationProvider {

	@Autowired
	MemberService memberService;
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {

		String userid = (String)authentication.getPrincipal(); // name="userid" 값
		String passwd = (String)authentication.getCredentials(); // name="passwd" 값
		
		
		MemberDTO memberDTO = memberService.findId(userid);
//		String encrptPw = mem.getPasswd();  // NullPointerExcepion 발생되기 때문에 사용안됨.
		
		//Authentication 하위클래스
		//로그인 성공시
		UsernamePasswordAuthenticationToken token=null;
		if(memberDTO!=null && new BCryptPasswordEncoder().matches(passwd, memberDTO.getPasswd())) {
			
			List<GrantedAuthority> list = new ArrayList<>();
			//ROLE 설정시 사용됨
			list.add(new SimpleGrantedAuthority("USER")); // ADMIN
			
			//암호화된 비번대신에 raw 비번으로 설정
			memberDTO.setPasswd(passwd);
			token = new UsernamePasswordAuthenticationToken(memberDTO, null, list);
//			token = new UsernamePasswordAuthenticationToken(mem, null);
//			new UsernamePasswordAuthenticationToken(Principal, Credentials);
//			new UsernamePasswordAuthenticationToken(Principal, Credentials, List<GrantedAuthority>);
			
			return token;
		}
		//로그인 실패시
		throw new BadCredentialsException("비밀번호가 일치하지 않습니다. 다시 확인하세요.");
		
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return true;
	}

}




