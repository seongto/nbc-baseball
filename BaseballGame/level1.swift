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
            var isUnique:Bool = false
            
            while !isUnique {
                let newNumber:String = String(Int.random(in: from...to))
                guard randomNumber.contains(newNumber) == false else {
                    continue
                }
                randomNumber += newNumber
                isUnique = true
            }

        }
        return randomNumber
    }
    
    func printResult() {
        print(answer)
    }
}

