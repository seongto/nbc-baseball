//
//  PlayHistory.swift
//  BaseballGame
//
//  Created by MaxBook on 11/6/24.
//

// 각 게임내에서 모든 사용자의 입력과 그 처리결과를 저장하기 위한 모델
struct PlayHistory {
    let playedNumber: String // 사용자가 입력한 숫자
    let strike: Int
    let ball: Int
    
    init( _ playedNumber: String, _ strike: Int, _ ball: Int) {
        self.playedNumber = playedNumber
        self.strike = strike
        self.ball = ball
        
    }
}
