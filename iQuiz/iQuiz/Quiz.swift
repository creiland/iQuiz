//
//  Quiz.swift
//  iQuiz
//
//  Created by Conor Reiland on 2/16/19.
//  Copyright © 2019 Conor Reiland. All rights reserved.
//

import Foundation
import UIKit

class Quiz: Codable{
    
    
    var image: UIImage = #imageLiteral(resourceName: "math.png")
    var title: String
    var desc: String
    var questions : [Question]
    
    private enum CodingKeys: String, CodingKey{
        case title
        case desc
        case questions
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        desc = try values.decode(String.self, forKey: .desc)
        questions = try values.decode([Question].self, forKey: .questions)
    }
    
    init(title: String, desc: String, questions: [Question]){
        self.title = title
        self.desc = desc
        self.questions = questions
    }
    
}

class Question: Codable{
    
    var text: String = ""
    var answers: [String] = []
    var answer: String = ""
    
    private enum CodingKeys: String, CodingKey{
        case text
        case answers
        case answer
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        text = try values.decode(String.self, forKey: .text)
        answer = try values.decode(String.self, forKey: .answer)
        answers = try values.decode([String].self, forKey: .answers)
    }
}


//add extension to UIApp
//lazy initialize
//abstract to repository ** generally singleton
//get quiz and instantiate object
//long term use interface based approach so you can get data from multiple sources
//use one coordinator to check if theres a network connection etc

//generally use one or the other storyboard or programmatic
//repo makes it so you dont have to worry about passing info for segues
//keeps sync better


//lazily instantiate instances of view controllers
//.share on UIApplication
//downcast to delegate
//
//wire up using Viewcontroller present
//gcd
///one thread message loop
///do http off the main UI thread
////otherwise the UI breaks
///delegate http request to worker backhround thread, then move code back to UI thread
////never touch UI from anything other than UI thread

//dispatchqueue.async
//use spinner while json downloads
//once json is done, view controller has variable that stores the data from the ananymous block of clode (closures)
