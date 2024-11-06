//
//  UserModel.swift
//  BaseballGame
//
//  Created by MaxBook on 11/6/24.
//


/// 사용자의 게임 기록을 저장하고 관리하는 유저 모델
class User {
    var name: String
    var gameHistories: [ NewGame ]
    
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
