<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>다음 지도 시작하기</title>
</head>
<body>
	<p style="margin-top: -12px">
		<em class="link"> <a href="javascript:void(0);"
			onclick="window.open('http://fiy.daum.net/fiy/map/CsGeneral.daum', '_blank', 'width=981, height=650')">
				혹시 주소 결과가 잘못 나오는 경우에는 여기에 제보해주세요. </a>
		</em>
	</p>
	<div id="map" style="width: 100%; height: 780px;"></div>

	<script>
 		var address = new Array();
 		var gc = new Array();
 	</script>
	<c:forEach var="i" items="${addr }">
		<script>
			address[${i.bnum} ]="${i.baddr}";
			gc[${i.bnum} ]="${i.gc}";
		</script>
	</c:forEach>
	
<%-- 	<form name="getaddr" action='<c:url value="/bike/bikec"/>' method="get"> --%>
<!-- 		<input type="hidden" name="addr" value="" /> -->
<!-- 	</form> -->
	<form name="postaddr" method="post">		
		<input type="hidden" name="bnum" value="" />
		<input type="hidden" name="pay" value="" />
	</form>
	
	<select name="" id="" style="font-size: "></select>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=83ae51b34402cd37475339ee91b78950&libraries=services"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script>
		var check_open = true;
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
        
        function swal_alert(gc){
        	var target = document.getElementById("chooseLicense");
        	if(gc <= 0){
				swal("빌릴수 있는 자전거가 없습니다");
			}else{
				swal({
					title: "정말로 대여하시겠습니까?",
					text: "선택하시면, 자동결제가 진행됩니다",
					icon: "warning",
					buttons: true})
				.then((willPay) => {
					if(willPay){
						swal("결제가 완료되었습니다",{
							icon: "success"})
						.then((selectNext) => {
							document.postaddr.bnum.value="${i.bnum}";
							document.postaddr.pay.value=target.options[target.selectedIndex].value;
	 						document.postaddr.submit();
						});
					}else{
						swal("취소되었습니다");
					}
				});
			}
        }
        
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
                                                  content : '<div style="width:100px;text-align:center;padding:3px 0;">'+address+'</div>'
                                                	+'<select name="chooseLicense" id="chooseLicense" style="width: 100%; float: left;">'
                                      				+'<option value="0">-----------------</option>'
                                  					+'<option value="5000">1시간 결제권 - 5000</option>'
                                  					+'<option value="9500">2시간 결제권 - 9500</option>'
                                  					+'<option value="14000">3시간 결제권 - 14000</option>'
                                  					+'</select><br/>'
                                                	+'<hr/><button type="button" onclick=swal_alert('+count+');>대여</button>'
//                                                   +'<hr/><button id="rental" type="button" onclick=swal("click")>대여</button>'
                                               // content : '<div style="color:red;">' +  number + '</div>'
									});
                                    
                                    // 마커에 마우스 올려뒀을시
// 	                                daum.maps.event.addListener(marker, 'mouseover', function(e){                                	
// 		                                infowindow.open(map, marker);
// 	                                });
	                                
//                                     // 마커에 마우스를 없앴을시
// 	                                daum.maps.event.addListener(marker, 'mouseout', function(e){
// 	                                	infowindow.close(map, marker);
// 	                                });
	                                
	                               	// 마커를 클릭시 이벤트
// 									daum.maps.event.addListener(marker, 'click', function(e){
// 										document.getaddr.addr.value=address;
// 										document.getaddr.submit();
// 	                                });
	                                
									daum.maps.event.addListener(marker, 'click', function(e){
										if(check_open){
											infowindow.open(map, marker);
											check_open=false;
										}else{
											infowindow.close(map, marker);
											check_open=true;
										}
	                                });
									
									
									// 커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
                                 	/*
                                 	var content = '<div class="customoverlay">'
                                            + '    <span class="title">'
                                            + '<div style="font-style:normal; color:red; font-weight:bold; font-size:1.0em">'
                                            + number + '</div>' + '</span>'
                                            + '</div>';
  									*/
  									
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
            myMarker(i + 1, myAddress[i], gc[i]);
        }
        
    </script>
    
</body>
</html>
