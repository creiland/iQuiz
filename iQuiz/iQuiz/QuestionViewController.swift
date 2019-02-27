//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Conor Reiland on 2/20/19.
//  Copyright © 2019 Conor Reiland. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var qTableView: UITableView!
    
    var quiz: Quiz?
    
    var answers : [String] = []
    var questionTitle: String?
    var currentQuestion: Int = 0
    
    var selectedAnswer : String = ""
    var correctAnswer : String = ""
    
    var swipeDirection: String = "right"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quiz = QuizRepo.getQuiz()
        currentQuestion = QuizRepo.getCurrentQ()
        print(quiz!.questions[currentQuestion].text)
        if quiz != nil{
            answers = quiz!.questions[currentQuestion].answers
            correctAnswer = quiz!.questions[currentQuestion].answer
            questionLabel.text = quiz!.questions[currentQuestion].text
        }
        
        qTableView.delegate = self
        qTableView.dataSource = self
        submitButton.setTitle("Submit", for: .normal)
        
        //swipe gestures
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.rightSwipe))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.leftSwipe))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @IBAction func submitClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "answerSegue", sender: selectedAnswer)
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
    
    @objc func rightSwipe(gesture: UIGestureRecognizer) {
        if gesture is UISwipeGestureRecognizer {
            swipeDirection = "right"
            performSegue(withIdentifier: "answerSegue", sender: selectedAnswer)
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

extension QuestionViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let a = answers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionOptionCell") as! QuestionOptionCell
        
        cell.cellTitle.text = a
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var detailToSend: String?
        detailToSend = answers[indexPath.row]
        selectedAnswer = detailToSend!
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AnswerViewController, let detailToSend = sender as? String {
            let correctIndex:Int? = Int(correctAnswer)
            vc.selected = detailToSend
            vc.correctAnswer = answers[correctIndex! - 1]
            vc.questionText = quiz!.questions[currentQuestion].text
        }
    }
    
}
