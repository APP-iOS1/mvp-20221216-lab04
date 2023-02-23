
# OtDo_온도별옷차림

## ADS
이 앱은 날씨에 따라 입을 옷을 고민하는 사용자에게 날씨에 맞는 다양한 스타일링을 사람들과 공유할 수 있도록 할 것이다
## 페르소나
- 계절이 바뀔 때마다 옷을 고르기 어려운 민경
-   온도에 따라 사람들의 착장을 보고싶은 성민
-   두달만에 밖에 나가서 무슨 옷을 입어야할 지 모르는 (범)석이
-   요즘 사람들이 지금날씨에 어떤 스타일로 옷을 입는지 빠르고 쉽게 알고싶은 혜미
-   날뛰는 한반도의 날씨에 무슨 옷을 입어야할지 갈피를 못잡는 도희
-   타지역의 날씨를 알지 못해 무슨 옷을 입어야될지 고민되는 유진

---

## 주요기능
- URLSession을 활용한 날씨 정보 API 불러오기 기능
- 현재 내 위치의 온도에 따른 스타일링을 볼 수 있는 기능
- 파이어 베이스를 활용한 다른 사람들의 스타일링을 볼 수 있는 커뮤니티 기능

---

## Login Tab
| <img width="200" src="https://user-images.githubusercontent.com/57763334/208874503-ea989f21-dd7d-4fa2-a5c1-5e1db4aad821.png"> | <img width="200" src="https://user-images.githubusercontent.com/57763334/208874479-a3ff8f25-a902-4902-a8b4-264edb68e1d7.png"> |
|:-:|:-:|

로그인 화면에서 회원가입화면으로 넘어간다
- 이메일 로그인 가능
- 구글 로그인 가능 
- 회원가입 화면에서 이메일과 비밀번호, 닉네임, 성별, 나이를 입력하고 회원가입을 진행한다 
- 비밀번호는 6글자 이상 입력해야 계정 생성이 가능하다 이메일과 비밀번호를 입력하고 로그인한다 
- 1회 로그인 후에는, 로그아웃하지 않으면 자동로그인 되어 있다 

## Weather Tab
| <img width="200" src="https://user-images.githubusercontent.com/57763334/209303208-64fefe88-d9d0-4967-a23c-b7ed6aa2c6e5.gif">| <img width="200" src="https://user-images.githubusercontent.com/57763334/208871760-59db30d6-b35b-4be4-9ef9-14de60f64c8a.png"> | <img width="200" src="https://user-images.githubusercontent.com/57763334/208872000-f13d9ac4-e618-4492-a7e4-36cf1df7295d.png"> | <img width="200" src="https://user-images.githubusercontent.com/57763334/208876898-afeb43ec-74e9-4a4a-baca-fdd5b6192d5a.png"> |
|:-:|:-:|:-:|:-:|

지역별 현재 날씨를 보여준다
- 처음에는 서울을 기준으로 보여준다
- 눌러서 지역 선택을 하면 변경된 지역의 현재 날씨를 보여준다 
- 현재 날씨 위젯을 누르면 해당 지역 상세날씨/주간날씨를 보여준다 
- 상세날씨에서는 시간대별 날씨와 오늘의 날씨에 대한 상세 정보를 보여준다. 
- 주간날씨에서는 해당 주에 대한 최저/최고 기온을 보여준다. 
- 지역별 현재 기온에 맞는 추천 OOTD를 보여준다

## OOTD Tab
<img width="200" src="https://user-images.githubusercontent.com/57763334/209302684-b295672a-316b-4107-be80-a0c9067de579.gif">

어플 사용자들이 작성한 게시물들을 그리드 형식의 피드로 확인할 수 있다. 
- 게시글에는 온도별 옷차림(OOTD)에 대한 사진과 글이 작성되어 있다. 
- 각각의 그리드에서는 작성자의 프로필, 기온, OOTD사진, 글 내용, 좋아요 수, 댓글 수, 북마크 수를 확인할 수 있다. 최저 기온과 최고 기온을 직접 입력하여 해당 온도 범위에 해당하는 OOTD들만 피드로 확인할 수 있다. 
- 피드를 밑으로 잡아당기면 온도 설정이 초기화 되고 최신순으로 전체 피드 업데이트가 가능하다
- 원하는 사용자를 검색해서 해당 사용자의 게시물들을 확인할 수 있다. 
- 우측 상단의 글쓰기 버튼을 눌러서 게시물을 추가할 수 있다. 
- 게시물을 추가하면 추가된 게시물을 포함해서 전체 피드를 최신순으로 업데이트하여 보여준다


피드의 게시물을 누르면 게시물 상세페이지로 이동하여 게시물을 확인할 수 있다.
- 댓글 추가, 삭제가 가능하다.


슬라이더로 온도 범위를 설정하여 게시물들을 정렬해서 피드로 확인할 수 있다.
- 초기화를 누르면 다시 전체 피드를 최신순으로 업데이트하여 보여준다.


사용자를 검색하여 원하는 사용자의 OOTD 게시물을 확인할 수 있다.


## My Page Tab
| <img width="200" src="https://user-images.githubusercontent.com/57763334/209303385-801fac3e-f72d-494e-a6c4-d36062b26297.png"> | <img width="200" src="https://user-images.githubusercontent.com/57763334/209303391-018be46c-25b7-44c1-9361-e282f92e78b3.png"> |
|:-:|:-:|

로그인 정보(닉네임, 이메일)을 확인할 수 있다 우측 상단에서 로그아웃이 가능하다 내가 쓴 게시물과 북마크 한 게시물을 확인할 수 있다(북마크 미구현) 
- 내가 쓴 게시물을 누르면 게시물 확인할 수 있다 
- 게시물 우측 상단 버튼을 통해서 글 수정/삭제가 가능하다

---

## 참여자
|<img width="120" src="https://avatars.githubusercontent.com/u/114239407?v=4">|<img width="120" src="https://avatars.githubusercontent.com/u/57763334?v=4">|<img width="120" src="https://avatars.githubusercontent.com/u/104570633?v=4">|<img width="120" src="https://avatars.githubusercontent.com/u/98953443?v=4">|<img width="120" src="https://avatars.githubusercontent.com/u/107797217?v=4">|
|:---:|:---:|:---:|:---:|:---:|
|고범석<br>[@FrediOS-dev](https://github.com/FrediOS-dev)|김도희<br>[@ehvkddl](https://github.com/ehvkddl)|박성민<br>[@mrgroomy](https://github.com/mrgroomy)|봉혜미<br>[@hyemib](https://github.com/hyemib)|이민경<br>[@mxnkng](https://github.com/mxnkng)|

---

## 라이선스
Firebase
https://github.com/firebase/firebase-ios-sdk/blob/master/LICENSE

GoogleSignIn-iOS
https://github.com/google/GoogleSignIn-iOS/blob/main/LICENSE
