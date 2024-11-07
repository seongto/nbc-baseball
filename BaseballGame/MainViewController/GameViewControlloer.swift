//
//  GameViewControlloer.swift
//  BaseballGame
//
//  Created by MaxBook on 11/6/24.
//

// 야구 게임이라는 앱을 총괄하는 클래스
class BaseballGame: FinalAppProtocol {
    var user: User
    var isRunning: Bool // 앱이 가동 중임을 표시. false일 경우 앱의 종료를 의미한다.
    
    init() {
        self.user = User()
        self.isRunning = true
    }
    
    /// 앱을 시작하는 메소드.
    func start() {
        // 앱 실행 여부를 통해, 각 게임 종료 후 앱을 종료하기 이전까지 반복하여 플레이를 가능하도록 함.
        print("[System Message] : App start!\n")
        print("""
          _                    _           _ _ 
         | |__   __ _ ___  ___| |__   __ _| | |
         | '_ \\ / _` / __|/ _ \\ '_ \\ / _` | | |
         | |_) | (_| \\__ \\  __/ |_) | (_| | | |
         |_.__/ \\__,_|___/\\___|_.__/ \\__,_|_|_|

        """)
        print("환영합니다!")
        
        while isRunning {
            print("원하시는 번호를 입력해주세요.")
            print("1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기")
            print(">> ", terminator: "")
            
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
                excuteGameOver()
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
        let currentGame: NewGame = .init()
        currentGame.answer = currentGame.makeAnswer()
                
        print("\n게임을 시작합니다.\n")
        
        // 정답을 맞출 때까지 플레이(숫자입력후 검증)를 반복.
        while currentGame.isCorrectAnswer == false {
            currentGame.playBall()
        }
        
        
        
        var isCorrectName: Bool = false
        
        // 게임 승리 후 이름을 기록하는 기능을 담당. 특별한 에러처리를 통해 재입력을 요구하는 대신 디폴트 값을 주는 방향으로 진행.
        while !isCorrectName {
            print("승리의 전당에 기록할 3글자를 입력해주세요. 잘못된 입력 시 YOU 로 기록됩니다.")
            print(">> ", terminator: "")
            let recordInput: String? = readLine()
            
            
            // 입력이 없을 경우 nil 에러를 방지하고 다시 입력을 요구하도록 하는 코드이나, 이 부분에 전혀 걸리지 않는다. 입력이 없더라도 빈 "" String 으로 값이 들어오기 때문인듯.
            guard let recordInput else {
                print("[Error] : 빈칸을 입력하였습니다.")
                continue
            }
            
            // 형식에 안 맞는 모든 경우에 이름을 동일하게 저장시킨다.
            guard recordInput.count == 3 else {
                print("YOU 로 저장되었습니다.")
                currentGame.recordName = "YOU"
                break
            }
            
            isCorrectName = true
            currentGame.recordName = recordInput
            print("\(recordInput) 이름으로 저장되었습니다.")
        }
    
        // 이번 게임 데이터를 사용자에 저장한다.
        user.gameHistories.append(currentGame)
        print("... 게임 결과가 저장되었습니다.")
        print("[System Message] 게임을 종료합니다. \n")
    }
    
    // 2번 게임 기록 보기 선택시 실행되는, 게임의 기록을 출력해주는 메소드.
    func showGameHistory() {
        var isShowing: Bool = true // false로 전환시 기록보기를 종료하고 초기 화면으로 되돌아가게 처리.
        
        // 게임 기록 보기 상태를 유지시키기 위해 while을 통해 사용자 입력을 반복적으로 받게 설계함.
        // 게임 기록 보기에서 오류를 일으키거나 세부 내용 확인 후 돌아오기 등, 돌아오는 기점을 만들기 위함.
        while isShowing {
            user.printHistories()
            if user.gameHistories.isEmpty {
                isShowing = false
                return
            }
            
            print("0. 초기화면으로 돌아가기\n")
            print("상세한 기록 확인을 원하는 게임의 번호를 입력해주세요. 0 입력 시 초기화면으로 돌아갑니다.")
            print(">> ", terminator: "")
            
            // 게임 기록 보기 내에서 각 게임의 기록을 선택하거나 초기 화면으로 돌아갈 수 있는 입력을 받는 곳.
            let menuInput: String? = readLine()
            
            // 입력 없는 경우를 방어. 기록 선택으로 돌아가기.
            guard let menuInput else {
                print("[Error] : 빈칸을 입력하였습니다.")
                continue
            }
            
            // 잘못된 입력을 방지
            guard checkMenuInput(input: menuInput, number: user.gameHistories.count) else {
                continue
            }
            
            if menuInput == "0" {
                isShowing = false
                print("초기 화면으로 돌아갑니다.\n")
                return
            } else {
                let record: NewGame = user.gameHistories[Int(menuInput)! - 1]
                record.printHistories()
                
                print("\n\(record.recordName) 님은 이 게임을 \(record.playHistories.count)회 만에 승리하였습니다.")
                
                if record.playHistories.count < 4 {
                    print("GREAT!!!")
                }
                
                print("\n엔터를 누르시면 이전 화면으로 돌아갑니다.")
                print(">> 확인", terminator: "")
                
                // 세부 정보를 출력 후 바로 메뉴 화면으로 돌아가기 전에 여유를 두고 기록을 볼 수 있도록 무의미한 엔터 확인 과정을 넣어주었다.
                let _ : String? = readLine()
            }
        }
    }
    
    /// 앱을 종료하는 메소드
    func excuteGameOver() {
        print("[System Message] : 숫자 야구 게임앱을 종료합니다.")
        isRunning = false
    }

}
