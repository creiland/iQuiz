//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Conor Reiland on 2/20/19.
//  Copyright © 2019 Conor Reiland. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    @IBOutlet weak var selectedLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var correctIndicator: UILabel!
    
    var selected : String?
    var correctAnswer : String?
    var questionText : String?
    var correct : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.setTitle("Next", for: .normal)
        if selected != nil {
            selectedLabel.text = "Your answer: " + selected!
        }
        if correctAnswer != nil {
            correctLabel.text = "Correct answer: " + correctAnswer!
        }
        if questionText != nil {
            questionLabel.text = questionText!
        }
        correct = (selected == correctAnswer)
        if correct{
            QuizRepo.incrementNumCorrect()
            correctIndicator.text = "Correct!"
        } else {
            correctIndicator.text = "Incorrect"
        }
    }
    
    @IBAction func goToNext(_ sender: Any) {
        QuizRepo.incrementCurrentQ()
        print(QuizRepo.currentQuiz?.questions.count)
        if QuizRepo.getCurrentQ() == QuizRepo.currentQuiz?.questions.count{
            performSegue(withIdentifier: "toResults", sender: correct)
        } else {
            performSegue(withIdentifier: "nextQuestion", sender: correct)
        }
        
    }
    
}
