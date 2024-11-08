# iOS_week3_Baseball_Game

![베이스볼 게임](https://sabrbaseballgaming.com/wp-content/uploads/2024/02/pure-stat_baseball2a.jpg)


## Project Information
  - 프로젝트명 : 야구 게임 만들기
  - 프로젝트 소개 :
    - mac command line 을 통해 작동하는 야구게임 만들기.
    - 3자리 숫자를 입력받아 스트라이크, 볼 등의 문답을 통해 정답을 이끌어내는 게임을 만들자.
    - 사용자의 게임 기록을 저장하여 이를 살펴볼 수 있도록 한다.
  - 프로젝트 일정
    - **시작일**: 2024 / 11 / 04
    - **종료일**: 2024 / 11 / 08
<br><br><br>

## 프로젝트 수행 과제
### 1. 수행 목표 
  - Playground를 사용하여 함수의 파라미터로 직접 사용자의 입력값을 받아 계산을 실행하며, 예외 상황에 대한 처리를 통해 견고한 코드를 작성하는 것을 목표로 합니다.   
```swift
// readLine() 함수를 이용하여 유저의 입력값 처리하기
// readLine() 함수에 대해 학습해보고 활용하기
let input = readLine()
```
  - 레벨 별로 따로 파일을 만들어서 기록하는 형태로 프로젝트 진행.
  - 커맨드 라인 툴을 이용해서 진행되는 게임이라는 특성을 파악하여, 해당 환경에서 사용자 경험이 좋은 앱으로 만들어보기
    + 텍스트로만 진행되므로 각 입력 처리와 결과 출력 가독성을 높이기
    + 야구 게임의 플레이 편의성을 높이기

<br><br>

### 2. 필수 구현 기능
  - LV 1
    + [x] 1에서 9까지의 서로 다른 임의의 수 3개를 정하고 맞추는 게임입니다
    + [x] 정답은 랜덤으로 만듭니다.(1에서 9까지의 서로 다른 임의의 수 3자리)
  - LV 2
    + [x] 정답을 맞추기 위해 3자리수를 입력하고 힌트를 받습니다
      - 힌트는 야구용어인 볼과 스트라이크입니다.
      - 같은 자리에 같은 숫자가 있는 경우 스트라이크, 다른 자리에 숫자가 있는 경우 볼입니다.
    + [x] 올바르지 않은 입력값에 대해서는 오류 문구를 보여주세요
    + [x] 3자리 숫자가 정답과 같은 경우 게임이 종료됩니다
  
<br><br>

![hard mode](https://staticdelivery.nexusmods.com/mods/5113/images/headers/229_1676449560.jpg)

### 3. 선택 구현 기능
  - LV 3
    + [x] 정답이 되는 숫자를 0에서 9까지의 서로 다른 3자리의 숫자로 바꿔주세요
      - 맨 앞자리에 0이 오는 것은 불가능합니다.
      - 서로 다른 3자리의 숫자로 만들어주세요.
  - LV 4
    + [x] 프로그램을 시작할 때 안내문구를 보여주세요
      ```
      // 예시
      환영합니다! 원하시는 번호를 입력해주세요
      1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기
      ```
    + [x] 1번 게임 시작하기의 경우 “필수 구현 기능” 의 예시처럼 게임이 진행됩니다
      - 정답을 맞혀 게임이 종료된 경우 위 안내문구를 다시 보여주세요.
  - LV 5
    + [x] 2번 게임 기록 보기의 경우 완료한 게임들에 대해 시도 횟수를 보여줍니다
  - LV 6
    + [x] 3번 종료하기의 경우 프로그램이 종료됩니다
      - 이전의 게임 기록들도 초기화됩니다
    + [x] 1, 2, 3 이외의 입력값에 대해서는 오류 메시지를 보여주세요

<br><br>

### 4. 과제 외 추가 기능
  - [x] 각 게임에서 숫자입력과 그 결과(ex 1 stirke 0 ball)를 모두 저장하여 해당 게임 인스턴스에 저장
  - [x] 유저 인스턴스에서 플레이한 각 게임 데이터를 모두 저장하여 상세 숫자 입력 기록도 볼 수 있게하기
  - [x] 클래스와 구조체, 함수 등을 각각 별개의 파일로 나누고, 이를 폴더로 구분하여 정리.
  - [x] 각 게임 승리 후 사용자의 이름(3글자)을 남기는 기능 추가. 오락실에서 게임 오버 후 이니셜과 점수 기록하는 기능에서 모티브.
  - [x] 텍스트로만 진행되므로 각 입력 처리와 결과 출력 가독성을 높이기 :
    + 공란을 통해 각 메시지 간 가독성을 높임.
    + 사용자의 입력을 받는 시점의 직전 출력되는 메세지에 >> 표시를 이용해 입력 대기의 의도를 잘 전달함.
  - [x] 야구 게임의 플레이 편의성을 높이기 :
    + 매 숫자입력마다 사용자의 입력과 처리 결과 출력 등으로 많은 텍스트가 생성되어 이전 입력 히스토리를 보기 어려워 스크롤을 올리는 불편함이 발생
    + 이를 극복하기 위해 매 입력을 요구할 때마다 이번 게임의 이전 입력과 그 결과를 한번에 출력하여 제공.

<br><br>

### 5. Trouble Shooting
[트러블 슈팅 노션 페이지 바로가기](https://seongto.notion.site/241104_-134a2764a657804cb5a3d538b794a30f?pvs=4)




      
