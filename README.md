# 💬 프로젝트 소개 ([App Store](https://apps.apple.com/kr/app/%EB%A0%88%EC%BD%94%EB%93%9C%EB%A6%BC-recordream/id1645675304))

<img src="https://user-images.githubusercontent.com/77208067/227720184-63539783-b605-4c32-a83f-117f3b046def.png" width="300">

> 기상 직후 기록하는 꿈 아카이빙 서비스, 레코드림
>
> 감성적인 꿈 기록, 레코드림과 함께 해요.
>
> 오직 꿈만을 위한 아카이빙 서비스 레코드림에서 당신의 이야기를 펼쳐보세요.

# 👨‍👨‍👧‍👦 팀원 소개

|[Hee](https://github.com/EunHee-Jeong)|[su_vera](https://github.com/Suyeon9911)|[L-j-h-c](https://github.com/L-j-h-c)|
|---|---|---|
|<img width="200" alt="image" src="https://user-images.githubusercontent.com/77208067/227719536-10dc9af3-aba0-4086-ad8e-3117cd4833c9.png">|<img width="200" alt="image" src="https://user-images.githubusercontent.com/77208067/227719547-985bce7b-9829-4226-8d8b-78a344c8f408.png">|<img width="200" alt="image" src="https://user-images.githubusercontent.com/77208067/227718782-dd1ed3af-a027-4956-b0d6-4def902bbec6.png">|

# 📲 주요 기능

## Clean Architecture

<img width="1300" alt="image" src="https://user-images.githubusercontent.com/77208067/227719246-cbc303d5-91c9-4f0b-8b47-75e336303f37.png">

- 클린 아키텍쳐를 지향하여 각 레이어의 변경사항의 영향을 최소화했습니다.
- Domain 과 Data 레이어 사이 의존성을 역전하여 Domain 로직의 변경 이유를 최소화했습니다.
- Protocol 및 의존성 주입을 이용하여 Testable한 코드를 작성하려 노력했습니다.
- 개선할 점
  - MVVM에서 이전 상태를 기억하지 못하고, input과 output을 조합해야 할 경우가 생겼습니다.
  - 단방향 데이터 플로우를 도입하려 개선하려 합니다.

## Tuist Modular Architecture

<img width="250" alt="image" src="https://user-images.githubusercontent.com/77208067/227719473-e8fccf2d-0087-4244-9f16-92861b564976.png">

- Tuist를 이용하여 Clean Architecture의 형태로 모듈의 의존성 그래프를 구성했습니다.
- Tuist를 이용한 mono repo를 구축하여, Swift Package나 multi repo를 이용할 때보다 모듈을 확장 및 관리하기 쉬워졌습니다.
- 개선할 점
  - Presentation 모듈을 여러 개의 Feature 모듈로 분리하여 더욱 격리된 구조를 만들 수 있습니다.
  - Dynamic library와 Static library를 적절히 조합하여 빌드 시간을 단축시킬 수 있고, application binary size를 줄일 수 있습니다.

# 🛠 사용 기술

## fastlane

- match를 이용하여 인증서와 프로필을 관리했습니다.
- custom lane을 이용하여 배포 과정을 자동화했습니다.

## MVVM

- View와 ViewModel을 이용하여 UI와 비즈니스 로직을 분리했습니다.
- RxSwift의 Observable을 이용하여 View와 ViewModel을 바인딩했습니다.

## RxSwift & RxCocoa

- 비동기 작업을 편리하고 직관적으로 처리하기 위해 RxSwift를 사용했습니다.
- UI Binding을 위해 RxCocoa를 사용했습니다.

## Compositional Layout & Diffable DataSource

- 유지보수성 높고 편리한 Layout을 구현하기 위해 Compositional Layout을 사용했습니다.
- 오류가 적고 성능이 좋은 테이블뷰를 구현하기 위해 Diffable DataSource를 사용했습니다.

## APNs

- 유저가 원하는 시간에 알림을 보내고, retention을 높이기 위해 APNs를 사용했습니다.
- 재귀함수를 통해 현재 뷰에서 작성하기 뷰로 이동하기 위한 로직을 구현했습니다.

## AVFoundation

- 녹음 및 재생 기능을 구현하기 위해 AVFoundation 및 AVAudioPlayer를 사용했습니다.
- Timer를 이용하여 오디오 플레이어의 재생 시간 UI를 구현했습니다.
