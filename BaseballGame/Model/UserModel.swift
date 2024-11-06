//
//  UserModel.swift
//  BaseballGame
//
//  Created by MaxBook on 11/6/24.
//


/// 사용자의 게임 기록을 저장하고 관리하는 유저 모델
/// 추후 사용자를 변경하는 기능 추가 혹은 종료 후 입력하는 이름의 디폴트값을 넣을 경우를 대비해 name 프로퍼티를 할당함
class User {
    var name: String
    var gameHistories: [ NewGame ] // 게임 기록 자체를 저장
    
    init(){
        self.name = "Player"
        self.gameHistories = []
    }
    
    /// User의 NewGame History를 저장하는 메소드
    func addHistory( _ history: NewGame) {
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
