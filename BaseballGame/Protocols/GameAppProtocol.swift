//
//  GameAppProtocol.swift
//  BaseballGame
//
//  Created by MaxBook on 11/6/24.
//

/// 프로그램의 기본 기능인 시작과 게임을 시작하는 기능을 다룸
protocol GameAppProtocol {
    
    func start()
    func startNewGame()
}


/// 최종앱에서 필요로 하는 기능들을 구조로 갖는 프로토콜.
protocol FinalAppProtocol: GameAppProtocol {
    var user: User { get }
    var isRunning: Bool { get }
    
    func showGameHistory()
    func excuteGameOver()
}
