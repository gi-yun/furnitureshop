package com.exam.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.exam.dto.CartDTO;
import com.exam.dto.GoodsDTO;
import com.exam.mapper.CartMapper;
import com.exam.mapper.GoodsMapper;

@Service
public class CartServiceImpl implements CartService{
	
	CartMapper cartMapper;
	

	public CartServiceImpl(CartMapper cartMapper) {
		super();
		this.cartMapper = cartMapper;
	}

	@Override
	public int cartAdd(CartDTO cartdto) {

		
		return cartMapper.cartAdd(cartdto);
	}

	@Override
	public List<CartDTO> cartList(String userid) {

		
		return cartMapper.cartList(userid);
	}

	@Override
	public int cartDelete(int num) {
		
		return cartMapper.cartDelete(num);
	}


}
