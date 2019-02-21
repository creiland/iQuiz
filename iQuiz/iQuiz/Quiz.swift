//
//  Quiz.swift
//  iQuiz
//
//  Created by Conor Reiland on 2/16/19.
//  Copyright © 2019 Conor Reiland. All rights reserved.
//

import Foundation
import UIKit

class Quiz{
    var image: UIImage
    var title: String
    var res: [Q]
    
    init(image: UIImage, title: String){
        self.image = image
        self.title = title
        self.res = [Q]()
        parseJson()
    }
    
    struct question: Codable{
        var text : String
        var answer : String
        var answers : [String]
    }
    
    struct Q: Codable {
        var title: String
        var questions: [question]
    }
    
    
    func parseJson (){
        if let url = URL(string: "http://tednewardsandbox.site44.com/questions.json") {
            print("******************")
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        self.res = try JSONDecoder().decode([Q].self, from: data)
                        print(self.res)
                    } catch let error {
                        print(error)
                    }
                }
                }.resume()
        }
    }
}
