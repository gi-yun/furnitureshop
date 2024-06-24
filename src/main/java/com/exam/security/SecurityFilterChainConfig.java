package com.exam.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityFilterChainConfig {

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
		
		//커스터마이징 처리
		
		//1. 불필요한 인증제거
		http.authorizeRequests()
		    .antMatchers("/lowPrice","/idCheck","/goodsRetrieve/**","/main","/login","/home","/signup","/webjars/**","/images/**").permitAll()
		    .anyRequest()
		    .authenticated();
			
		
		//2. csrf 비활성화
		http.csrf().disable();
		
		//3. 로그인 관련 작업
		http.formLogin()     // 사용자가 만든 로그인화면으로 인증처리 하겠음.
		    .loginPage("/login") // 로그인 페이지로 갈수 있는 요청맵핑값 <a href="login">로그인
		    .loginProcessingUrl("/auth") // <form  action="auth"  method="post"
		    .usernameParameter("userid")    // <input name="userid">
		    .passwordParameter("passwd")       // <input name="passwd">
		    .failureForwardUrl("/login_fail")        // 로그인 실패시 리다이렉트되는 요청맵핑값
//		    .successForwardUrl("/login_success");    // post 지원안됨.    
		    .defaultSuccessUrl("/login_success", true); // 로그인 성공시 리다이렉트되는 요청맵핑값
	   

		
		
		 //4. 로그아웃 관련 작업
		 http.logout()
		     .logoutUrl("/logout")   // security가 자동으로 로그아웃 처리해주는 요청맵핑값
		     .logoutSuccessUrl("/main");  // logout 성공시 리다이렉트 되는 요청맵핑값
		 
		 
		return http.build();
	}
	
}
