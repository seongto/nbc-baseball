//
//  PlayHistory.swift
//  BaseballGame
//
//  Created by MaxBook on 11/6/24.
//

struct PlayHistory {
    let playedNumber: String
    let strike: Int
    let ball: Int
    
    init( _ playedNumber: String, _ strike: Int, _ ball: Int) {
        self.playedNumber = playedNumber
        self.strike = strike
        self.ball = ball
        
    }
}
