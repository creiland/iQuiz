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
    
    var answers : [String] = []
    var question : String = "test"
    
    var selectedAnswer : String = ""
    var correctAnswer : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answers = ["test", "test2"]
        selectedAnswer = "test"
        correctAnswer = "test"
        qTableView.delegate = self
        qTableView.dataSource = self
        submitButton.setTitle("Submit", for: .normal)
        questionLabel.text = "test question"
    }
    
    @IBAction func submitClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "answerSegue", sender: selectedAnswer)
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
            vc.selected = detailToSend
        }
    }
    
}
