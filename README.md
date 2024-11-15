Portfolio
================

***
<h3> #7. Project - AI추천 여행 사이트</h3>

- Background
 	<p> 사용자 패턴 분석을 통해 개인 맞춤 AI추천 여행 시스템 개발하고 챗봇 시스템으로 여행지 검색 </p>

- Summary
	<p>(1). 데이터</br>
		AIHub : </br>
  		 - 국내 여행로그 데이터(수도권) </br>
  		 - 관광 특화 말뭉치 데이터 </p>
    
	<p>(2). 데이터 전처리 </br>
		- 국내 여행로그 데이터에서 여행객, 방문지, 여행, 동반자, 소비내역 csv파일을 가지고 코드 해석해서 데이터셋 구성</br>
		- 결측치나 이상치 데이터 제거 </br>
		- 관광 특화 말뭉치 데이터 json 파일에서 말뭉치마다 태깅된 정보 가지고 데이터셋 구성 </p>
    
  	<p>(3). 머신러닝 </br>
		- 사용자들의 방문 및 소비기록을 기반으로 코사인 유사도를 통해 추천 점수를 계산하여 사용자 정보를 통해 추가 가중치를 두어 추천 점수 부여 </br>
  		- PostgreSQL의 TrigramSimilarity 함수를 사용하여 유사도 검사를 통해 챗봇 시스템 구현</p>
    
  	<p>(4). 주요 기능 </br>
    		- 로그인, 회원가입, 회원정보, 정보수정 등의 회원관리 기능</br>
		- 방문한 횟수를 기반으로 인기여행지와 AI추천 점수를 통한 여행지 추천 시스템</br>
  		- 자연어 처리 및 유사도 검사를 통한 챗봇 시스템</br>
    		- 방문지와 연관된 방문지 추천 시스템</br>
      		- 여행 계획 시 예상 소비 금액 분석 시스템</p>

  	<p>(5). 결론 </br>
    		- 사전 추천 점수 계산 방식으로 성능 향상 </br>
		- 체계적인 접근으로 문제점 개선 </br>
		- 향후 머신러닝 기반으로 서비스 품질 향상 계획 </p>
		
*보러가기: [AI추천 여행 사이트](https://github.com/Jeong-Seongwon/tour_recommendation)*



***
<h3> #6. Team Project - 스마트 CCTV</h3>

- coworker
  	<p> 박성준 </p>

- Background
  	<p> CCTV 영상을 실시간으로 웹상으로 모니터링하고, 이상행동을 감지하여 응급상황 신속히 대응 </p>

- Summary
	<p>(1). 데이터</br>
    		- AIHub의 이상행동 CCTV 영상</p>
    
	<p>(2). 데이터 전처리 </br>
    		- CCTV 영상에서 이상행동 데이터 추출</br>
      		- YOLOv8 학습에 맞게 데이터셋 작성</p>
    
  	<p>(3). 딥러닝 </br>
		- YOLOv8 모델 커스텀 학습</p>
    
  	<p>(4). 프로그램 </br>
    		- YOLOv8 학습을 위한 데이터셋 준비를 위한 프로그램 작성</br>
      		- Flask 프레임워크를 활용해서 웹상으로 CCTV 영상 재생 및 이상행동 검출 로그 실시간으로 작성</br>
		- 이상행동 검출 시 데이터를 DB에 저장하고, 경고 알람 전송</p>

  	<p>(5). 결론 </br>
    		- 진행중...</p>

*보러가기: [스마트 CCTV](https://github.com/Jeong-Seongwon/project)*



***
<h3> #5. Project - 얼굴 인식을 활용한 보안 시스템 개발</h3>

- Background
 	<p> 영상에서 얼굴을 감지해 얼굴 인식으로 사람 인식 </p>

- Summary
	<p>(1). 데이터</br>
		- image : CelebA data set, Yale faces data set, video에서 찍은 사진 </br>
		- video : 픽사베이 무료 동영상</p>
    
	<p>(2). 데이터 전처리 </br>
		- Yale faces data set의 이미지 jpg 형식으로 변환</br>
		- CelebA data set에서 50개의 이미지로 Unknown faces 데이터 형성</br>
		- 이미지 정규화 및 128*128 사이즈, GRAY 형식으로 변경</p>
    
  	<p>(3). 딥러닝 </br>
		- CNN 모델 설계 및 학습 정확도 평가</p>
    
  	<p>(4). 프로그램 </br>
    		- 매니저 프로그램 : 사진 촬영, 새로운 데이터 추가해서 딥러닝 모델 업데이트</br>
		- 얼굴인식 프로그램 : 영상 내 얼굴 감지, 학습된 모델을 통한 얼굴 인식</p>

  	<p>(5). 결론 </br>
    		- 학습된 모델의 정확도가 아쉬운 성능을 보임 </br>
		- 학습한 데이터와 다른 각도의 얼굴을 다른 사람으로 인식하는 경우 발생 </br>
		- 데이터 셋의 확장 및 모델 개선을 통해 정확도 제고 필요 </br>
		- DB와 연결해 출결시스템이나 IOT와 연계해 보안 프로그램으로 발전 가능 </p>
		
*보러가기: [얼굴 인식 프로그램](https://github.com/Jeong-Seongwon/portfolio/tree/main/face_recognition)*


***
<h3> #4. Project - 이미지 및 동영상 사람 얼굴 인식</h3>

- Background
 	<p> 이미지 및 동영상에서 사람 얼굴을 찾고 해당 사람의 정보를 딥러닝한 모델로 예측 </p>

- Summary
	<p>(1). 데이터</br>
    		- 딥러닝 : CelebA 데이터 셋</br>
		- 테스트 : 이미지 - 구글 이미지 크롤링, 동영상 - 픽사베이 무료 동영상</p>
    
	<p>(2). 데이터 전처리 </br>
    		- CelebA 데이터 약 20만개 이미지 중 2000개 샘플 데이터 활용</br>
		- 이미지 정규화 및 256*256 사이즈, RGB 형식으로 변경</br>
		- 이미지를 최대 20도까지 무작위로 회전시켜 이미지 데이터 증강</p>
    
  	<p>(3). 딥러닝 </br>
		- CNN 모델 설계 및 학습 정확도 평가</br>
    		- 3x3필터로 합성곱, 2x2 맥스풀링, 드롭아웃으로 과적합 방지 </p>
    
  	<p>(4). 프로그램 </br>
    		- 이미지 및 동영상 재생 프로그램</br>
		- 사람 얼굴 인식해서 사각형으로 얼굴 표시</br>
		- 딥러닝한 모델을 사용해서 얼굴 정보를 예측</p>

  	<p>(5). 결론 </br>
    		- 학습된 모델의 정확도가 아쉬운 성능을 보임 </br>
		- 딥러닝 시 소요되는 시간이 너무 커서 샘플데이터만 이용함으로 데이터 양 부족으로 보임 </br>
    		- 앞으로 모델을 최적화하거나 GPU나 TPU 병렬 처리하여 최적화 필요 </p>
		
*보러가기: [이미지 및 동영상 사람 얼굴 인식](https://github.com/Jeong-Seongwon/portfolio/tree/main/celeba)*


***
<h3> #3. Project - 숫자 손글씨 인식 딥러닝</h3>

- Background
 	<p> 손으로 숫자를 입력받아 인식하는 프로그램 작성 </p>

- Summary
	<p>(1). 데이터</br>
    		- tensorflow mnist 데이터 셋</p>
    
	<p>(2). 데이터 전처리 </br>
    		- 이미지 데이터를 255로 나누어 정규화 </p>
    
  	<p>(3). 딥러닝 </br>
		- 모델 설계 및 학습 정확도 평가</br>
    		- CNN 모델의 정확도가 높음</br>
    		- 3x3필터로 합성곱, 2x2 맥스풀링, 드롭아웃으로 과적합 방지 </p>
    
  	<p>(4). 프로그램 </br>
    		- 가장 높은 확률의 값으로 예측 </br>
		- 예측 결과와 확률을 그래프로 보여주는 프로그램 구축 </br>
		- 숫자 손글씨 인식하여 텍스트로 입력해주는 프로그램 구축 </p>

  	<p>(5). 결론 </br>
    		- 학습된 모델이 약 99%의 정확도를 달성 </br>
		- 그러나, 새로운 글씨체의 숫자 인식에서 다소 아쉬운 성능 </br>
    		- 앞으로 더 큰 데이터셋과 더 복잡한 모델을 사용하여 성능을 향상시킬 수 있을 것으로 예상</p>
		
*보러가기: [숫자 손글씨 딥러닝](https://github.com/Jeong-Seongwon/portfolio/tree/main/mnist)*


***
<h3> #2. Project - 타이타닉 생존율 회귀분석 머신러닝 </h3>

- Background
 	<p> 데이터 분석을 통해 생존율 예측 프로그램 작성 </p>

- Summary
	<p>(1). 데이터</br>
    		- seaborn titanic 데이터 셋</p>

	<p>(2). 데이터 전처리 </br>
    		- 중복 특성 및 결측치 과다 특성 제거 </br>
		- 연속형 특성인 나이를 사분위수 구간 변환 </br>
		- 비슷한 특성인 sibsp와 parch 특성 결합 </br>
		- 상관관계 : 히트맵, 각 특성별 생존율 그래프를 통해 시각화 </p>

  	<p>(3). 머신러닝 </br>
		- 성별, 나이, 객실등급, 동승자로 생존여부 학습</br>
		- 결정트리, 랜덤포레스트, 로지스틱회귀 모델 정확도 비교</br>
		- 최종 랜덤포레스트와 그래디언트부스팅 앙상블 모델 선택 학습</p>

  	<p>(4). 프로그램 </br>
    		- 학습한 모델로 새로운 데이터의 생존율 예측 프로그램 구축</p>

	<p>(5). 결론 </br>
    		- 앙상블 모델이 효과적임을 알 수 있음</br>
		- 더 많은 특성을 고려하거나 모델 파라미터를 조정함으로써 모델의 성능을 조금 더 향상시킬 수 있을 것으로 예상</p>

*보러가기: [타이타닉 머신러닝](https://github.com/Jeong-Seongwon/portfolio/tree/main/titanic)*


***
<h3> #1. Mini Project - 도서관 프로그램 </h3>

- Background
 	<p>Oracle 데이터베이스를 사용하여 도서 및 회원, 대여정보를 저장하고 Python을 활용하여 도서관리 프로그램 구축</p>

- Summary
	<p>(1). 참고 자료 </br>
		- 공공데이터포털 (경상북도교육청 구미도서관 도서정보)</p>
  
	<p>(2). 데이터 베이스 </br>
		- account table (유저정보 + 관리권한정보) </br>
		- book table(도서정보 + 대여, 잔여 여부) </br>
		- rental table(대여정보 + 대여 기간 + 연체 여부)</p>
  
	<p>(3). 기 능 </br>
		- 로그인, 회원가입 </br>
		- 회원 : 대여정보, 정보수정, 도서검색, 대여, 반납</br>
		- 관리자 : 도서관리, 회원관리, 대여관리</p>
  
	<p>(4). 결과 </br>
		- 도서관리 프로그램으로 회원들의 정보와 도서 대여정보를 데이터베이스에 저장</br>
		- 대여 정보를 통해 인기있는 도서종류 등을 분석해 차후 도서 추가 시에 정보 활용 가능성</p>

*보러가기: [도서관리 프로그램](https://github.com/Jeong-Seongwon/portfolio/tree/main/library_manage)*

***
