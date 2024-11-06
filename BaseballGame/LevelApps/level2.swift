//
//  level2.swift
//  BaseballGame
//  -
//


class BaseballGameLv2 {
    var answer: [String]
    var isCorrectAnswer: Bool
    
    init() {
        self.answer = []
        self.isCorrectAnswer = false
    }
    
    /// 게임을 시작하는 메소드. 게임이 진행되는 동안 반복적으로 사용자의 입력과 처리를 수행한다.
    func start() {
        isCorrectAnswer = false
        answer = makeAnswer()
        
        print("\n게임을 시작합니다. \(answer)\n")
        while isCorrectAnswer == false {
            playBall()
        }
        
        print("게임을 종료합니다.")
        
    }

    /// 랜덤 정답을 만드는 메소드
    /// - Returns: 만들어진 랜덤 정답( String의 배열 )을 반환
    func makeAnswer() -> [String] {
        // 정답의 각 숫자는 고유성을 가져야하므로, 고유한 숫자의 배열로부터 하나씩 추출하는 방식으로 진행. 코드가 매우 간결해짐.
        var numberArray: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9"].shuffled()
        
        
        /*
        // 레거시 코드 : 반복문으로 위 배열에서 하나씩 뽑아 쓰는 방식.
        var randomNumber:[String] = []
         
        for _ in 1...3 {
            randomNumber.append(numberArray.remove(at: Int.random(in: 0..<numberArray.count)))
        }
         
        return randomNumber
        */
        
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
        guard checkUserInput(input: userInput) else {
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
    
    /// 숫자가 아닌 문자를 입력 혹은 3자리가 아닌 숫자를 입력했을 경우 false 반환.
    func checkUserInput(input:String) -> Bool {
        
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
      
        // 숫자에 0이 포함되어 있는지 확인
        let inputArr: [String] = input.map { String($0) }
        guard !inputArr.contains("0") else {
            print("0은 입력할 수 없습니다.\n")
            return false
        }
        
        // 숫자에 중복이 있는지 체크
        let inputSet: Set<String> = Set(inputArr)
        guard inputSet.count == input.count else {
            print("동일한 숫자는 반복하여 사용할 수 없습니다.\n")
            return false
        }
        
        return true
    }
    
    /// 현재 정답을 반환한다.
    func printResult() {
        print(answer)
    }
}

