package com.exam.service;

import java.util.List;

import com.exam.dto.CartDTO;

public interface CartService {

	public int cartAdd(CartDTO cartdto);
	public List<CartDTO> cartList(String userid);  
}
