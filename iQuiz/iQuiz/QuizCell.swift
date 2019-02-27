//
//  Quiz Cell.swift
//  iQuiz
//
//  Created by Conor Reiland on 2/16/19.
//  Copyright © 2019 Conor Reiland. All rights reserved.
//

import UIKit

class QuizCell: UITableViewCell {

    @IBOutlet weak var CellTitleLabel: UILabel!
    
    @IBOutlet weak var QuizImageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    var quiz: Quiz?
    
    func setQuiz(quiz: Quiz){
        self.quiz = quiz
        QuizImageView.image = quiz.image
        CellTitleLabel.text = quiz.title
        descriptionLabel.text = quiz.desc
    }
    
}
