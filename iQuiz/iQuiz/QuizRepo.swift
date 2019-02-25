//
//  QuizRepo.swift
//  iQuiz
//
//  Created by Conor Reiland on 2/24/19.
//  Copyright © 2019 Conor Reiland. All rights reserved.
//

import Foundation
import UIKit

class QuizRepo{
    static var quizList : [Quiz] = []
    
    static var currentQuestion : Int = 0
    static var numCorrect : Int = 0
    static var currentQuiz: Quiz?
    
    class func setQuiz(quiz:Quiz){
        currentQuiz = quiz
    }
    
    class func getQuiz() -> Quiz{
        return currentQuiz!
    }
    
    class func getQuizzes() -> [Quiz]{
        return quizList
    }
    
    class func getCurrentQ() -> Int {
        return currentQuestion
    }
    
    class func incrementCurrentQ(){
        currentQuestion = currentQuestion + 1
    }
    
    class func resetCurrentQ(){
        currentQuestion = 0
    }
    
    class func getNumCorrect() -> Int {
        return numCorrect
    }
    
    class func incrementNumCorrect(){
        numCorrect = numCorrect + 1
    }
    class func resetNumCorrect(){
        numCorrect = 0
    }
    
    class func initializeRepo(completion: @escaping([Quiz])->()){
        if let url = URL(string: "http://tednewardsandbox.site44.com/questions.json") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                       quizList = try JSONDecoder().decode([Quiz].self, from: data)
                        completion(quizList)
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }
}


