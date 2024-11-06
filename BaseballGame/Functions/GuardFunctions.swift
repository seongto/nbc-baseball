//
//  GuardFunctions.swift
//  BaseballGame
//
//  Created by MaxBook on 11/6/24.
//

/// 숫자가 아닌 문자를 입력 혹은 3자리가 아닌 숫자를 입력했을 경우 false 반환.
/// - Parameter input: 사용자로부터 입력받은 입력값
/// - Returns: 잘못된 값을 입력받았을 경우 false 반환
func checkUserPlayInput(input:String) -> Bool {
    
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
func checkMenuInput(input:String, number:Int) -> Bool {
    
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
