package kr.co.vo;

public class BikeVO {

	private Integer office_num;
	private String name;
	private String address;
	private Integer count;
	private double latitude;
	private double longitude;
	
	
	public BikeVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	
	public BikeVO(Integer office_num, String name, String address, Integer count, double latitude, double longitude) {
		super();
		this.office_num = office_num;
		this.name = name;
		this.address = address;
		this.count = count;
		this.latitude = latitude;
		this.longitude = longitude;
	}

	

	public Integer getOffice_num() {
		return office_num;
	}



	public void setOffice_num(Integer office_num) {
		this.office_num = office_num;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public String getAddress() {
		return address;
	}



	public void setAddress(String address) {
		this.address = address;
	}



	public Integer getCount() {
		return count;
	}



	public void setCount(Integer count) {
		this.count = count;
	}



	public double getLatitude() {
		return latitude;
	}



	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}



	public double getLongitude() {
		return longitude;
	}



	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}



	@Override
	public String toString() {
		return "BikeVO [office_num = " + office_num + " ,name = " + name + " , address = " + address + " , count = " + count + " , latitude = " + latitude + " , longitude = " + longitude +"]"; 
	}
	
	
}
