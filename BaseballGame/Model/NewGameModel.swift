//
//  NewGameModel.swift
//  BaseballGame
//
//  Created by MaxBook on 11/6/24.
//


/// 메뉴와 기록 보기 등의 기능이 생기며 각 게임을 별도의 클래스로 구분한 모델
class NewGame {
    var recordName: String // 게임 종료 후 기록을 남길 때 이니셜 남기기
    var answer: [String]
    var isCorrectAnswer: Bool
    var playHistories: [ PlayHistory ] // 각 게임의 모든 플레이(숫자입력 및 처리 결과)를 저장
    
    init() {
        self.isCorrectAnswer = false
        self.answer = []
        self.playHistories = []
        self.recordName = ""
    }
    
    /// 랜덤 정답을 만드는 메소드
    /// - Returns: 만들어진 랜덤 정답( String의 배열 )을 반환
    func makeAnswer() -> [String] {
        // 정답의 각 숫자는 고유성을 가져야하므로, 고유한 숫자의 배열로부터 하나씩 추출하는 방식으로 진행. 코드가 매우 간결해짐. lv3에서 0 추가.
        var numberArray: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"].shuffled()
        
        // 첫 숫자는 0이어선 안되므로 이를 검증.
        while numberArray[0] == "0" {
            numberArray = numberArray.shuffled()
        }
    
        // 앞의 세자리만 뽑아내서 게임의 정답으로 사용한다.
        numberArray.removeSubrange(3...)
        
        return numberArray
    }
    
    
    /// 사용자의 입력을 받아, 정답과 비교를 통해 결과를 도출한다.
    func playBall() {
        // 0. 현재 게임의 기록이 있으면 해당 기록을 입력 전에 보여준다.
        if !playHistories.isEmpty {
            printHistories()
        }
        
        // 1. 숫자를 입력해달라고 요청
        print("\n>> [\(playHistories.count + 1)회차 시도] 3자리의 숫자를 던져주세요.")
        
        let userInput: String? = readLine()
        var strike: Int = 0
        var ball: Int = 0
        
        
        // 2. 입력 없는 경우를 방어. 입력이 없는 경우 이번 플레이를 종료.
        guard let userInput else {
            print("[Error] : 빈칸을 입력하였습니다.")
            return
        }
        
        // 3. 사용자의 입력값을 체크하는 함수 호출하여, 잘못된 입력 시 이번 플레이를 종료.
        guard checkUserPlayInput(input: userInput) else {
            return
        }
                
        // 4. 입력값이 정상임이 확인 되었으므로, 해당 값을 원할한 결과검증을 위해 배열로 변환
        let inputArray: [String] = userInput.map { String($0) }
        
        // 5. 사용자가 입력한 값을 하나씩 검증하여 스트라이크와 볼 개수를 구함.
        for (idx, num) in inputArray.enumerated() {
            if answer[idx] == inputArray[idx] {
                strike += 1
            } else if answer.contains(num) {
                ball += 1
            }
        }
        
        // 6. 사용자가 정상적으로 입력한 값의 처리 결과를 기록으로 남기기.
        playHistories.append( PlayHistory( userInput, strike, ball ) )
        
        // 7. 검증 결과에 따른 처리 및 메시지 출력.
        if strike == inputArray.count {
            print("\n*=*=*=*=*=*=*=*=*=*=*=*=*=*=*")
            print("[플레이 결과] \(strike)스트라이크! 정답입니다!")
            print("*=*=*=*=*=*=*=*=*=*=*=*=*=*=*\n")
            isCorrectAnswer = true
        } else if strike == 0 && ball == 0 {
            print("[플레이 결과] NOTHING! 똥볼입니다!\n")
        } else {
            print("[플레이 결과] \(strike)스트라이크 \(ball)볼!\n")
        }
    }
    
    // 이번 게임의 플레이볼 기록을 출력.
    func printHistories() {
        print("*** Game History ***")
        for ( idx, history ) in playHistories.enumerated() {
            print("\(idx + 1) : \(history.playedNumber) -> \(history.strike) S, \(history.ball) B")
        }
    }
}
