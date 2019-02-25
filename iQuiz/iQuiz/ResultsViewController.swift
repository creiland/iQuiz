//
//  ResultsViewController.swift
//  iQuiz
//
//  Created by Conor Reiland on 2/24/19.
//  Copyright © 2019 Conor Reiland. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userScore: UILabel!
    @IBOutlet weak var backToQuizzes: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Results"
        userScore.text = "You got " + String(QuizRepo.numCorrect) + "/" + String(QuizRepo.currentQuestion) + " correct"
        QuizRepo.resetCurrentQ()
        QuizRepo.resetNumCorrect()
        backToQuizzes.setTitle("Back to Quizzes", for: .normal)
    }
    
    @IBAction func goBack(_ sender: Any) {
        performSegue(withIdentifier: "backToQuizzes", sender: userScore)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if navigationController != nil && !(navigationController?.viewControllers)!.contains(self) {
            // back button was pressed
            self.navigationController?.popToRootViewController(animated: animated)
            QuizRepo.resetCurrentQ()
            QuizRepo.resetNumCorrect()
        }
        super.viewWillDisappear(animated)
    }
    
    
}
