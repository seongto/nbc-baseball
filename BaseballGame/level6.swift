//
//  level6.swift
//  BaseballGame
//  -
//

/// 사용자의 게임 기록을 저장하고 관리하는 유저 모델
private class PrivateUser {
    var name: String
    var gameHistories: [ PrivateNewGame ]
    
    init(){
        self.name = "Player"
        self.gameHistories = []
    }
    
    /// User의 NewGame History를 저장하는 메소드
    func addHistory( _ history: PrivateNewGame) {
        gameHistories.append(history)
        print("[\(history.answer)] : \(history.playHistories.count)번 도전하여 승리한 게임이 저장되었습니다.")
    }
    
    /// 저장된 게임 기록을 출력하는 메소드
    func printHistories() {
        if gameHistories.count > 0 {
            for (idx, game) in gameHistories.enumerated() {
                print("\(idx+1). \(game.recordName) : \(game.playHistories.count)회")
            }
        } else {
            print("게임 기록이 없습니다. 새로운 게임을 시작해주세요.")
        }
    }
}

/// 각 게임에서 사용자가 입력한 값과 그 처리 결과를 저장하는 모델
private struct PrivatePlayHistory {
    let playedNumber: String
    let strike: Int
    let ball: Int
    
    init( _ playedNumber: String, _ strike: Int, _ ball: Int) {
        self.playedNumber = playedNumber
        self.strike = strike
        self.ball = ball
        
    }
}

/// 메뉴와 기록 보기 등의 기능이 생기며 각 게임을 별도의 클래스로 구분한 모델
private class PrivateNewGame {
    var recordName: String // 게임 종료 후 기록을 남길 때 이니셜 남기기
    var answer: [String]
    var isCorrectAnswer: Bool
    var playHistories: [PrivatePlayHistory]
    
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
        print("\n[\(playHistories.count + 1)회차 시도] 3자리의 숫자를 던져주세요.")
        
        let userInput: String? = readLine()
        var strike: Int = 0
        var ball: Int = 0
        
        
        // 2. 입력 없는 경우를 방어. 입력이 없는 경우 이번 플레이를 종료.
        guard let userInput else {
            print("[Error] : 빈칸을 입력하였습니다.")
            return
        }
        
        // 3. 사용자의 입력값을 체크하는 함수 호출하여, 잘못된 입력 시 이번 플레이를 종료.
        guard privateCheckUserPlayInput(input: userInput) else {
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
        playHistories.append(PrivatePlayHistory( userInput, strike, ball))
        
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

// 야구 게임이라는 앱을 총괄하는 클래스
class BaseballGameLv6 {
    private var user: PrivateUser
    var isRunning: Bool
    
    init() {
        self.user = PrivateUser()
        self.isRunning = true
    }
    
    /// 앱을 시작하는 메소드.
    func start() {
        // 앱 실행 여부를 통해, 각 게임 종료 후 앱을 종료하기 이전까지 반복하여 플레이를 가능하도록 함.
        print("[System Message] : App start!\n")
        print("환영합니다!")
        
        while isRunning {
            print("원하시는 번호를 입력해주세요.")
            print("1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기")
            let menuInput: String? = readLine()
            print("") // 입력값을 하이라트 하기 위한 여백
            
            guard let menuInput else {
                print("[Error] : 빈칸을 입력하였습니다.")
                return
            }
            
            // 플레이볼과 마찬가지로 예외처리를 하는 것도 가능하지만, 메뉴는 가능한 가지수가 매우 적고 정해져있으므로 switch를 이용해 코드 간략화.
            switch menuInput {
            case "1":
                startNewGame()
            case "2":
                showGameHistory()
            case "3":
                isRunning = false
                print("[System Message] : 숫자 야구 게임앱을 종료합니다.")
            default:
                print("[Error] : 잘못된 입력을 수행하였습니다.")
                print("""
                      현재 사용 가능한 항목은 다음과 같습니다.
                      - 1: 게임 시작하기
                      - 2: 게임 기록 보기
                      - 3: 종료하기
                      """)
            }
        }
    }
    
    /// 1번 게임 시작하기 선택시 실행되는, 게임을 시작하는 메소드. 게임이 진행되는 동안 반복적으로 사용자의 입력과 처리를 수행한다.
    func startNewGame() {
        let currentGame: PrivateNewGame = .init()
        currentGame.answer = currentGame.makeAnswer()
                
        print("\n게임을 시작합니다. \(currentGame.answer)\n")
        while currentGame.isCorrectAnswer == false {
            currentGame.playBall()
        }
        
        print("승리의 전당에 기록할 3글자를 입력해주세요. 잘못된 입력시 자동으로 YOU 로 기록됩니다.")
        
        var isCorrectName: Bool = false
        while !isCorrectName {
            let recordInput: String? = readLine()
            
            guard let recordInput else {
                print("[Error] : 빈칸을 입력하였습니다.")
                return
            }

            guard recordInput.count == 3 else {
                print("YOU로 저장되었습니다.")
                currentGame.recordName = "YOU"
                isCorrectName = true
                return
            }
            
            currentGame.recordName = recordInput
            print("\(recordInput) 이름으로 저장되었습니다.")
            isCorrectName = true
            
        }
    
        
        user.gameHistories.append(currentGame)
        print("... 게임 결과가 저장되었습니다.")
        print("[System Message] 게임을 종료합니다. \n")
    }
    
    // 2번 게임 기록 보기 선택시 실행되는, 게임의 기록을 출력해주는 메소드.
    func showGameHistory() {
        var isShowing: Bool = true // false로 전환시 기록보기를 종료하고 초기 화면으로 되돌아가게 처리.
        
        while isShowing {
            user.printHistories()
            if user.gameHistories.isEmpty {
                isShowing = false
                return
            }
            
            print("0. 초기화면으로 돌아가기\n")
            print("상세한 기록확인을 원하는 게임의 번호를 입력해주세요. 0 입력 시 초기화면으로 돌아갑니다.")
            
            let menuInput: String? = readLine()
            
            // 입력 없는 경우를 방어. 기록 선택으로 돌아가기.
            guard let menuInput else {
                print("[Error] : 빈칸을 입력하였습니다.")
                continue
            }
            
            // 잘못된 입력을 방지
            guard privateCheckMenuInput(input: menuInput, number: user.gameHistories.count) else {
                continue
            }
            
            
            
            if menuInput == "0" {
                isShowing = false
                print("초기 화면으로 돌아갑니다.\n")
                return
            } else {
                let record: PrivateNewGame = user.gameHistories[Int(menuInput)! - 1]
                record.printHistories()
                
                print("\n\(record.recordName) 님은 이 게임을 \(record.playHistories.count)회 만에 승리하였습니다.")
                
                if record.playHistories.count < 4 {
                    print("GREAT!!!")
                }
                print("\n엔터를 누르시면 이전 화면으로 돌아갑니다.")
                let _ : String? = readLine()
            }
            
            
            
        }
    }

}


/// 숫자가 아닌 문자를 입력 혹은 3자리가 아닌 숫자를 입력했을 경우 false 반환.
/// - Parameter input: 사용자로부터 입력받은 입력값
/// - Returns: 잘못된 값을 입력받았을 경우 false 반환
private func privateCheckUserPlayInput(input:String) -> Bool {
    
    // 숫자가 아닌 문자 여부 확인
    guard Int(input) != nil else {
        print("[Error] : 숫자만 입력이 가능합니다.\n")
        return false
    }
    
    // 숫자의 길이가 3인지 여부 확인
    guard input.count == 3 else {
        print("[Error] : 3자리의 숫자만 입력 가능합니다.\n")
        return false
    }
    
    // 숫자의 길이가 0으로 시작하는지 여부 확인
    guard String(input.prefix(1)) != "0" else {
        print("[Error] : 0으로 시작하는 수를 입력할 수 없습니다..\n")
        return false
    }
    
    // 숫자에 중복이 있는지 체크
    let inputTest: Set<String> = Set(input.map { String($0) })
    guard inputTest.count == input.count else {
        print("[Error] : 동일한 숫자는 반복하여 사용할 수 없습니다.\n")
        return false
    }
    
    
    
    return true
}


/// 숫자가 아닌 문자를 입력 혹은 원하는 범위(0-number) 내에 있지 않은 숫자를 입력했을 경우 false 반환.
/// - Parameter input: 사용자로부터 입력받은 입력값
/// - Parameter number: 현재 사용자가 선택가능한 가장 큰 번호. 0부터 이 숫자까지의 입력 외엔 잘못된 입력으로 처리한다.
/// - Returns: 잘못된 값을 입력받았을 경우 false 반환
private func privateCheckMenuInput(input:String, number:Int) -> Bool {
    
    // 숫자가 아닌 문자 여부 확인
    guard let inputNum = Int(input) else {
        print("[Error] : 숫자만 입력이 가능합니다.\n")
        return false
    }
    
    // 0 - number 범위 내의 숫자가 아닐 경우 에러
    guard inputNum >= 0 && inputNum <= number else {
        print("[Error] : 0-\(number) 범위 내의 숫자만 입력 가능합니다.\n")
        return false
    }
    
    return true
}
