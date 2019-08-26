package kr.co.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ko.co.service.BikeService;

@Controller
@RequestMapping("/bike")
public class BikeController {
	// log 기록
	
	private static final Logger logger = LoggerFactory.getLogger(BikeController.class);
	
	@Inject
	private BikeService bsvc;
	
	@RequestMapping(value = "/addr", method = RequestMethod.GET)
	public void list(Model model) throws Exception{
		logger.info("bike list start..............");
		
		model.addAttribute("addr", bsvc.selectList());
	}

	// 대여 클릭시 DB에서 -1 되게(mapper에서 연산하자)
	@RequestMapping(value = "/bikeR", method = RequestMethod.GET)
	public String rental(@RequestParam("ad1") String address, Model model)throws Exception{
		logger.info("rental start.......");
		
		bsvc.bikeRental(address);
		
		return "redirect:/bike/addr";
		
		
		
	}
	
	//반납
	@RequestMapping(value = "/bikeRt", method = RequestMethod.GET)
	public String returning(@RequestParam("ad2") String address, Model model) throws Exception{
		logger.info("bikeReturn start...........");
		
		bsvc.bikeReturn(address);
		
		return "redirect:/bike/addr";
		
	}
	
	
	/*
	 * @RequestMapping(value ="/bikec") public void click(Model model) throws
	 * Exception{ logger.info("click start....");
	 * 
	 * model.addAttribute("click", bsvc.bikeclick()); }
	 */
}
