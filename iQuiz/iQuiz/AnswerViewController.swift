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
    
    
    var swipeDirection : String = "right"
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
        
        //swipe gestures
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.rightSwipe))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.leftSwipe))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @IBAction func goToNext(_ sender: Any) {
        QuizRepo.incrementCurrentQ()
        if QuizRepo.getCurrentQ() == (QuizRepo.currentQuiz?.questions.count)!{
            performSegue(withIdentifier: "toResults", sender: correct)
        } else {
            performSegue(withIdentifier: "toNext", sender: correct)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print(swipeDirection)
        if swipeDirection == "left" && navigationController != nil && !(navigationController?.viewControllers)!.contains(self) {
            // back button was pressed
            self.navigationController?.popToRootViewController(animated: animated)
            QuizRepo.resetCurrentQ()
            QuizRepo.resetNumCorrect()
        }
        super.viewWillDisappear(animated)
    }
    
    @objc func rightSwipe(gesture: UIGestureRecognizer) {
        if gesture is UISwipeGestureRecognizer {
                swipeDirection = "right"
                if QuizRepo.getCurrentQ() == (QuizRepo.currentQuiz?.questions.count)!{
                    performSegue(withIdentifier: "toResults", sender: correct)
                } else {
                    performSegue(withIdentifier: "toNext", sender: correct)
                }
        }
    }
    
    @objc func leftSwipe(gesture: UIGestureRecognizer) {
        if gesture is UISwipeGestureRecognizer {
                //left view controller
                swipeDirection = "left"
                self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
