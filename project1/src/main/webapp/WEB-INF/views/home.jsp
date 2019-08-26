<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
 
    <script type="text/javascript"  src="//dapi.kakao.com/v2/maps/sdk.js?appkey=83ae51b34402cd37475339ee91b78950&libraries=services"></script>
    <script>
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = {
            center : new kakao.maps.LatLng(36.633535, 127.425882), // 지도의 중심좌표
            level : 4
        // 지도의 확대 레벨
        };
 
        // 지도를 생성합니다    
        var map = new kakao.maps.Map(mapContainer, mapOption);
 
        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();
        

     // 인포윈도우를 생성하고 지도에 표시합니다
    
       

        var myAddress = [
                "상당구 원봉로 68-1", 
                "상당구 수영로246번길 32-2", 
                " ... 중략 ...", 
                "흥덕구 가로수로 1337",
                "흥덕구 복대로118번길 3" ];
 
        function myMarker(number, address) {
            // 주소로 좌표를 검색합니다
            geocoder
                    .addressSearch(
                            //'충북 청주시 흥덕구 진재로 30 연정빌딩',
                            address,
                            function(result, status) {
                                // 정상적으로 검색이 완료됐으면 
                                if (status === kakao.maps.services.Status.OK) {
 
                                    var coords = new kakao.maps.LatLng(
                                            result[0].y, result[0].x);
 
                                    // 결과값으로 받은 위치를 마커로 표시합니다
                                    
                                    var marker = new kakao.maps.Marker({
                                        map : map,
                                        position : coords
                                        
                                    });
                                     
 
                                    // 인포윈도우로 장소에 대한 설명을 표시합니다
                                    
                                    var infowindow = new kakao.maps.InfoWindow({
                                                // content : '<div style="width:50px;text-align:center;padding:3px 0;">I</div>'
                                                 content : '<div style="width:50px;text-align:center;padding:3px 0;">자전거 대여소</div>'+
                                                 '<div style="width:50px;text-align:center;padding:3px 0;">확인</div>'
                                               // content : '<div style="color:red;">' +  number + '</div>'
                                                 
                                              
                                            });
                                    infowindow.open(map, marker);
                                     
 
                                    // 커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
                               /*      var content = '<div class="customoverlay">'
                                            + '    <span class="title">'
                                            + '<div style="font-style:normal; color:red; font-weight:bold; font-size:1.0em">'
                                            + number + '</div>' + '</span>'
                                            + '</div>'; */
 
                                    // 커스텀 오버레이가 표시될 위치입니다 
                                    var position = new kakao.maps.LatLng(
                                            result[0].y, result[0].x);
 
                                    // 커스텀 오버레이를 생성합니다
                                    var customOverlay = new kakao.maps.CustomOverlay(
                                            {
                                            	
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
            myMarker(i + 1, myAddress[i]);
        }

        
        
        // 좌표
        var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
            infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다

        // 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
        searchAddrFromCoords(map.getCenter(), displayCenterInfo);

        // 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
        kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
            searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
                    detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
                    
                    var content = '<div class="bAddr">' +
                                    '<span class="title">법정동 주소정보</span>' + 
                                    detailAddr + 
                                '</div>';

                    // 마커를 클릭한 위치에 표시합니다 
                    marker.setPosition(mouseEvent.latLng);
                    marker.setMap(map);

                    // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
                    infowindow.setContent(content);
                    infowindow.open(map, marker);
                }   
            });
        });

        // 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
        kakao.maps.event.addListener(map, 'idle', function() {
            searchAddrFromCoords(map.getCenter(), displayCenterInfo);
        });

        function searchAddrFromCoords(coords, callback) {
            // 좌표로 행정동 주소 정보를 요청합니다
            geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
        }

        function searchDetailAddrFromCoords(coords, callback) {
            // 좌표로 법정동 상세 주소 정보를 요청합니다
            geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
        }

        // 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
        function displayCenterInfo(result, status) {
            if (status === kakao.maps.services.Status.OK) {
                var infoDiv = document.getElementById('centerAddr');

                for(var i = 0; i < result.length; i++) {
                    // 행정동의 region_type 값은 'H' 이므로
                    if (result[i].region_type === 'H') {
                        infoDiv.innerHTML = result[i].address_name;
                        break;
                    }
                }
            }    
        }
    </script>
 
</body>
</html>
