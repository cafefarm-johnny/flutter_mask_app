# flutter_mask

인프런에서 [Flutter 응용 - 공공 API를 활용한 앱 만들기 (MVVM 패턴) 강의](https://www.inflearn.com/course/flutter-%EA%B3%B5%EA%B3%B5-api-%EC%95%B1-%EC%9D%91%EC%9A%A9/dashboard)를 듣고 학습한 레포

## 학습 목표

- MVVM 패턴에 대한 이해
- Provider 라이브러리를 활용한 상태 관리 이해
- 최종적으로 회사의 프로덕트 수준의 앱의 구조를 **팀원들과 함께**😆 MVVM 패턴으로 리팩토링하여 구조 개선하기

## 학습 후기

- 강의 소개에서는 수강자에게 중급 수준 이상을 요구했지만 초급이 수강하기에도 어렵지 않은 난이도
- Provider 패턴을 통해 View와 ViewModel 간 커뮤니케이션 발생 원리를 이해함
    1. View와 비즈니스 로직의 관심사를 분리함
    2. 상태 관리를 통해 한 곳에서 데이터를 관리하고 필요로 하는 페이지에 공유함
    3. 로직을 통해 데이터를 변경 -> Listener에게 상태 변경을 noti -> Listener들은 noti를 캐치하여 build 사이클 수행
- `setState()`와 Provider 패턴간 차이점을 이해함
    - `setState()` 호출 시 호출된 위젯의 하위 위젯(자식 요소)까지 모두 rebuild 과정이 수행됨 -> 렌더링 처리에 의한 성능 저하가 발생함
    - Provider는 데이터를 변경 후 noti, Listening 하고 있는 위젯 대상만 rebuild 과정이 수행됨 -> 렌더링 처리를 최소화하여 성능 저하를 방지함

## 아쉬운 점

- 강의 소개에서는 수강자에게 중급 수준 이상을 요구했지만 초급이 수강하기에도 어렵지 않은 난이도
- 강좌에 사용된 앱의 크기가 생각했던 것 보다 작아 실제 프로덕트 수준의 앱의 구조를 MVVM 패턴으로 리팩토링하는 과정에 대한 디자인이 예상되지 않음
- MVVM 아키텍처에서 흔히 겪을 수 있는 에로사항과 해결을 위한 노하우 전수가 없어 아쉬웠음
