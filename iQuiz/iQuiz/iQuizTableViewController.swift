//
//  iQuizTableViewController.swift
//  iQuiz
//
//  Created by Conor Reiland on 2/16/19.
//  Copyright © 2019 Conor Reiland. All rights reserved.
//

import UIKit

class iQuizTableViewController: UIViewController {
    
    var spinner = UIActivityIndicatorView(style: .gray)
    var quizzes: [Quiz] = []
    var currentQuiz: Quiz?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var SettingsButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        QuizRepo.initializeRepo(completion: { (newQuestions: [Quiz]) in
            self.quizzes = newQuestions
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.currentQuiz = self.quizzes[0]
            }
        })
        tableView.delegate = self
        tableView.dataSource = self
        SettingsButton.setTitle("Settings", for: .normal)
        SettingsButton.addTarget(self, action: #selector(iQuizTableViewController.showSettings(_:)), for: .touchUpInside)
    }
    
    //show settings alert
    @IBAction func showSettings(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Settings", message:
            "Settings go here", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }

}

extension iQuizTableViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let q = quizzes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell") as! QuizCell
        
        cell.setQuiz(quiz: q)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var detailToSend: Quiz?
        detailToSend = quizzes[indexPath.row]
        currentQuiz = detailToSend!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? QuestionViewController, let detailToSend = sender as? QuizCell {
            vc.quiz = detailToSend.quiz
            QuizRepo.setQuiz(quiz: detailToSend.quiz!)
        }
    }
    
}
