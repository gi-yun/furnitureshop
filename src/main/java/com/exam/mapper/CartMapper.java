package com.exam.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.exam.dto.CartDTO;


@Mapper
public interface CartMapper {

	public int cartAdd(CartDTO cartdto);
	public List<CartDTO> cartList(String userid);  
}
