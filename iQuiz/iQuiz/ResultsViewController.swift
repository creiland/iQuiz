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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Results"
        userScore.text = "You got " + String(QuizRepo.numCorrect) + "/" + String(QuizRepo.currentQuestion) + " correct"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
