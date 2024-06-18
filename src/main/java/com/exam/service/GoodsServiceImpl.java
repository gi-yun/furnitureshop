package com.exam.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.exam.dto.GoodsDTO;
import com.exam.mapper.GoodsMapper;

@Service
public class GoodsServiceImpl implements GoodsService{

	GoodsMapper goodsMapper;
	
	public GoodsServiceImpl(GoodsMapper goodsMapper) {
		this.goodsMapper = goodsMapper;
	}

	@Override
	public List<GoodsDTO> goodsList(String gCategory) {
		return goodsMapper.goodsList(gCategory);
	}

	@Override
	public GoodsDTO goodsRetrieve(String gCode) {
		return goodsMapper.goodsRetrieve(gCode);
	}

}
