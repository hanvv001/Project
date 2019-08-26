package ko.co.service;

import java.util.List;

import kr.co.vo.BikeVO;

public interface BikeService {

	public List<BikeVO> selectList();
	public void bikeRental(String addr);
	public void bikeReturn(String addr);
}
