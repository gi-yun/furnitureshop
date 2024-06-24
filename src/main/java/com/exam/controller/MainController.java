package com.exam.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.exam.dto.GoodsDTO;
import com.exam.service.GoodsService;

@Controller
public class MainController {
    
    Logger logger = LoggerFactory.getLogger(getClass());
    
    GoodsService goodsService;
    
    public MainController(GoodsService goodsService) {
        this.goodsService = goodsService;
    }

    @GetMapping("/main")
    public String main(@RequestParam(required = false) String gCategory, ModelMap m) {
        List<GoodsDTO> goodsList;
        boolean showMainBanner = false;

        if (gCategory == null || gCategory.isEmpty()) {
            gCategory = "bed"; // Default category
            showMainBanner = true;
        }

        goodsList = goodsService.goodsList(gCategory);
        m.addAttribute("goodsList", goodsList);
        m.addAttribute("showMainBanner", showMainBanner);
        
        return "main";
    }
    
    @GetMapping("/lowPrice")
    public String lowPrice(ModelMap m) {
        List<GoodsDTO> goodsList;
        

        goodsList = goodsService.lowerPrice();
        logger.info("lowPrice: ", goodsList);
        m.addAttribute("lowPrice", goodsList);
        
        return "lowPrice";
    }
    
    
    
    @GetMapping("/goodsRetrieve")
    public String goodsRetrieve(@RequestParam("gCode") String gCode,
                       ModelMap m) {
        
        GoodsDTO goodsRetrieve = goodsService.goodsRetrieve(gCode);
        m.addAttribute("goodsRetrieve", goodsRetrieve);
        return "goodsRetrieve";
    }
}
