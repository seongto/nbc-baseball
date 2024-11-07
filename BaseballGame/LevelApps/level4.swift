//
//  level4.swift
//  BaseballGame
//  -
//



/// 사용자의 게임 기록을 저장하고 관리하는 유저 모델
private class PrivateUser {
    var name: String
    var gameHistory: [Int]
    
    init(){
        self.name = "Player"
        self.gameHistory = []
    }
    
    func addHistory(_ score: Int) {
        gameHistory.append(score)
    }
    
    func printHistory() {
        if gameHistory.count > 0 {
            for (idx, score) in gameHistory.enumerated() {
                print("\(idx+1)회차 스코어 : \(score)\n")
            }
        } else {
            print("게임 기록이 없습니다. 새로운 게임을 시작해주세요.")
        }
    }
}


// 메뉴와 기록 보기 등의 기능이 생기며 각 게임을 별도의 클래스로 구분한 모델
private class PrivateNewGame {
    var answer: [String]
    var isCorrectAnswer: Bool
    
    init() {
        self.isCorrectAnswer = false
        self.answer = []
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
        
        // 1. 숫자를 입력해달라고 요청
        print("3자리의 숫자를 던져주세요.")
        
        let userInput: String? = readLine()
        var strike: Int = 0
        var ball: Int = 0
        
        
        // 2. 입력 없는 경우를 방어. 입력이 없는 경우 이번 플레이를 종료.
        guard let userInput else {
            print("빈칸을 입력하였습니다.")
            return
        }
        
        // 3. 사용자의 입력값을 체크하는 함수 호출하여, 잘못된 입력 시 이번 플레이를 종료.
        guard privateCheckUserPlayInput(input: userInput) else {
            return
        }
        
        // 4. 정상적인 입력을 완료하였음을 알려줌.
        print("\(userInput) 던졌습니다! ... 계산중...")
        
        // 5. 입력값이 정상임이 확인 되었으므로, 해당 값을 원할한 결과검증을 위해 배열로 변환
        let inputArray: [String] = userInput.map { String($0) }
        
        // 6. 사용자가 입력한 값을 하나씩 검증하여 스트라이크와 볼 개수를 구함.
        for (idx, num) in inputArray.enumerated() {
            if answer[idx] == inputArray[idx] {
                strike += 1
            } else if answer.contains(num) {
                ball += 1
            }
        }
        
        // 7. 검증 결과에 따른 메시지 출력.
        if strike == inputArray.count {
            print("\(strike)스트라잌! 정답입니다\n")
            isCorrectAnswer = true
        } else if strike == 0 && ball == 0 {
            print("NOTHING! 똥볼입니다!\n")
        } else {
            print("\(strike)스트라이크 \(ball)볼!\n")
        }
        
    }
    
}

// 야구 게임이라는 앱을 총괄하는 클래스
class BaseballGameLv4: GameAppProtocol {
    var answer: [String]
    var isCorrectAnswer: Bool
    private var user: PrivateUser
    
    init() {
        self.answer = []
        self.isCorrectAnswer = false
        self.user = PrivateUser()
    }
    
    /// 앱을 시작하는 메소드.
    func start() {
        // 앱 실행 여부를 통해, 각 게임 종료 후 앱을 종료하기 이전까지 반복하여 플레이를 가능하도록 함.
        let isRunning: Bool = true
        print("환영합니다!")
        
        while isRunning {
            print("원하시는 번호를 입력해주세요.")
            print("1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기")
            let menuInput: String? = readLine()
            print("") // 입력값을 하이라트 하기 위한 여백
            
            guard let menuInput else {
                print("빈칸을 입력하였습니다.")
                return
            }
            
            // 플레이볼과 마찬가지로 예외처리를 하는 것도 가능하지만, 메뉴는 가능한 가지수가 매우 적고 정해져있으므로 switch를 이용해 코드 간략화.
            switch menuInput {
            case "1":
                startNewGame()
            default:
                print("[Error] : 잘못된 입력을 수행하였습니다.")
                print("""
                      현재 사용 가능한 항목은 다음과 같습니다.
                      - 1: 게임 시작하기
                      
                      """)
            }
        }
    }
    
    /// 게임을 시작하는 메소드. 게임이 진행되는 동안 반복적으로 사용자의 입력과 처리를 수행한다.
    func startNewGame() {
        let currentGame: PrivateNewGame = .init()
        currentGame.answer = currentGame.makeAnswer()
                
        print("\n게임을 시작합니다. \(currentGame.answer)\n")
        while currentGame.isCorrectAnswer == false {
            currentGame.playBall()
        }
        
        print("게임을 종료합니다.")
    }

}


/// 숫자가 아닌 문자를 입력 혹은 3자리가 아닌 숫자를 입력했을 경우 false 반환.
/// - Parameter input: 사용자로부터 입력받은 입력값
/// - Returns: 잘못된 값을 입력받았을 경우 false 반환
private func privateCheckUserPlayInput(input:String) -> Bool {
    
    // 숫자가 아닌 문자 여부 확인
    guard Int(input) != nil else {
        print("숫자만 입력이 가능합니다.\n")
        return false
    }
    
    // 숫자의 길이가 3인지 여부 확인
    guard input.count == 3 else {
        print("3자리의 숫자만 입력 가능합니다.\n")
        return false
    }
    
    // 숫자에 중복이 있는지 체크
    let inputTest: Set<String> = Set(input.map { String($0) })
    guard inputTest.count == input.count else {
        print("동일한 숫자는 반복하여 사용할 수 없습니다.\n")
        return false
    }
    
    return true
}

