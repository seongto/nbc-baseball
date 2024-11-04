//
//  level1.swift
//  BaseballGame
//  -
//


class BaseballGameLv1 {
    var answer:String
    
    init() {
        self.answer = ""
    }
    
    func start() {
        answer = makeAnswer(from: 1, to: 9)
    }

    func makeAnswer(from:Int, to:Int ) -> String {
        var randomNumber:String = ""
        for _ in 1...3 {
            randomNumber += String(Int.random(in: from...to))
        }
        return randomNumber
    }
    
    func printResult() {
        print(answer)
    }
}

