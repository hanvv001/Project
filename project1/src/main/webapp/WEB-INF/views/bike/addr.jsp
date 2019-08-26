<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>다음 지도</title>
<style type="text/css">
.fs{
	font-size: 12px;
}
.bt{
	float: left;
	width: 30%;
	height: 30%;
}
</style>
</head>
<body>
	
	<div id="map" style="width: 100%; height: 780px;"></div>


	<script>
 		var address = new Array();
 		var rentalOffice = new Array();
 		var bikeCount = new Array();
 	</script>



	<c:forEach var="i" items="${addr }">
		<script>address[${i.office_num}]="${i.address}";
					rentalOffice[${i.office_num}]="${i.name}";
					bikeCount[${i.office_num}]="${i.count}";			

     	</script>
	</c:forEach>
	
	
	
	
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=83ae51b34402cd37475339ee91b78950&libraries=services"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script type="text/javascript">
	
        var marker_open = true;
	  
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = {
            center : new daum.maps.LatLng(37.569836, 126.982658), // 지도의 중심좌표
            level : 4
        // 지도의 확대 레벨
        };
		
        // 지도를 생성합니다    
        var map = new daum.maps.Map(mapContainer, mapOption);
 
        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new daum.maps.services.Geocoder();
 		
        var myAddress = new Array();
        myAddress = address;
	
       
		function swal_alert_rental(bikeCount){
			if(bikeCount <= 0){
				swal("대여할 자전거가 없습니다");
			}else{
			swal({
				title: "정말로 대여하시겠습니까?",
				text: "선택하시면, 자동결제가 진행됩니다",
				icon: "warning",
				buttons: true	})
			.then((willPay) => {
				if(willPay){
					swal("결제가 완료되었습니다",{
						icon: "success"})
					.then((selectNext) =>{
					//	document.postaddr.bnum.value="${i.bnum}";
					//	document.postaddr.pay.value=target.options[target.selectedIndex].value;
// 						document.getAddr1.pay.value=target.options[target.selectedIndex].value;
						document.getAddr1.submit();
					});
				}else{
					swal("취소되었습니다");
				}// inner if ~ else e
			});// swal e
			
		}// outer if ~ else e
	}// function swal_alert() e
	
	function swal_alert_return(bikeCount){
		
			swal({
				title: "정말로 반납하시겠습니까?",
				text: "확인 누를 시 반납이 완료됩니다",
				icon: "warning",
				buttons: true})
			.then((returnBike)=>{
				if(returnBike){
					swal("반납이 완료되었습니다",{
						icon : "success"})
					.then((next)=>{
// 						console.log(document.getAddr2.ad2.value);
						document.getAddr2.submit();
					});
					
				}else{
					swal("취소되었습니다");
				}
			
			});// swal() e
		
	}// function swal_alert_return() e
	
	
	
		

        
		function myMarker(number, address, count) {
			// 주소로 좌표를 검색합니다
            geocoder.addressSearch(
                            address,
                            function(result, status) {
                                // 정상적으로 검색이 완료됐으면
                                if (status == daum.maps.services.Status.OK) {
 
                                    var coords = new daum.maps.LatLng(
                                    		result[0].y, result[0].x);
 
                                    // 결과값으로 받은 위치를 마커로 표시합니다
                                    var marker = new daum.maps.Marker({
                                        map : map,
                                        position : coords
                                    });
                                    
                                    // 인포윈도우로 장소에 대한 설명을 표시합니다
                          
                                    	
                     
                                    var infowindow = new daum.maps.InfoWindow({
                                    			content :	'<div style="width:200px;text-align:center;padding:3px 0;"><div class="fs">'+address+'</div>'+
                                    							'<br/>'+
                                                  				'<div class="fs">대여소 : '+rentalOffice[number-1]+'</div>'+
                                                  				'<br/>'+
                                                  				'<div class="fs">자전거 대수 : '+bikeCount[number-1]+'</div>'+
                                                  				'<br/>'+
                                    				            '<form name="getAddr1" action="/bike/bikeR" method="get">'+
                                    				            '<input type="hidden" name="ad1" value="'+address+'"/>'+
                                    				            '<input type="hidden" name="pay" value=""/>'+
                                    				            '<input type="hidden" name="bnum" value=""/>'+
                                                  				'<button  type="button" onclick=swal_alert_rental('+count+'); class="bt">대여</button></form>'+
                                                  				'<form name="getAddr2" action="/bike/bikeRt" method="get">'+
                                                  				'<input type="hidden" name="ad2" value="'+address+'"/>'+
                                                  				'<button type="button" onclick=swal_alert_return('+count+') class="bt">반납</button></form></div>'+
                                                  				'<select name="chooseLicense" id=chooseLicense" style="width: 100%;height:30%;float:left;">'+
                                                  				'<option value="0">------------------------</option>'+
                                                  				'<option value="5000">1시간 결제권 - 5000원</option>'+
                                                  				'<option value="5000">2시간 결제권 - 9500원</option>'+
                                                  				'<option value="5000">3시간 결제권 - 14000원</option>'+
																'</select>'
                                                  	
                                               // content : '<div style="color:red;">' +  number + '</div>'
									});
                              
                                    // 마커에 마우스 올려뒀을시
	                              /*     daum.maps.event.addListener(marker, 'mouseover', function(e){                                	
		                                infowindow.open(map, marker);
	                                });
	                                
                                    // 마커에 마우스를 없앴을시
	                                daum.maps.event.addListener(marker, 'mouseout', function(e){
	                                	infowindow.close(map, marker);
	                                }); 
	                                  */
	                             
	                                  // 마커를 클릭시 이벤트
	                               daum.maps.event.addListener(marker, 'click', function(e){
                                   			
	                                	 if(marker_open){
	                                	 
	                                		 infowindow.open(map, marker);
	                                	 	 marker_open = false;
	                                	 }else{
	                                	 
	                                		 infowindow.close(map, marker);
	                                	 	 marker_open = true;
	                                		 
	                                	 }
	                                 }); 
	                                                  
	                                  
	                               // 커스텀 오버레이가 표시될 위치입니다 
                                    var position = new daum.maps.LatLng(
                                            result[0].y, result[0].x);

                                    // 커스텀 오버레이를 생성합니다
                                    var customOverlay = new daum.maps.CustomOverlay({
                                                map : map,
                                                position : position,
                                                content : content,
                                                yAnchor : 1
                                            });
 
                                    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                                    map.setCenter(coords);
                                }
                            });
        }
 
        for (i = 0; i < myAddress.length; i++) {
            myMarker(i + 1, myAddress[i], bikeCount[i]);
       
            
        }
	
		
	
        
    </script>


	

</body>
</html>
