package kr.co.test;


import javax.inject.Inject;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.dao.BikeDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class BikeDAOTest {

	private static Logger logger = LoggerFactory.getLogger(BikeDAO.class);
	
	@Inject 
	private BikeDAO bdao;
	
	/*
	@Test
	public void readBaddrTest() {
		logger.info(bdao.selectAll().toString());
	}
	*/

	@Test
	public void bikeRentalUpdate() {
		
	}
	
}
