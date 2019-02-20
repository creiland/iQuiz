//
//  iQuizTableViewController.swift
//  iQuiz
//
//  Created by Conor Reiland on 2/16/19.
//  Copyright © 2019 Conor Reiland. All rights reserved.
//

import UIKit

class iQuizTableViewController: UIViewController {
    
    var quizzes: [Quiz] = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var SettingsButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizzes = createArray()
        tableView.delegate = self
        tableView.dataSource = self
        SettingsButton.setTitle("Settings", for: .normal)
        SettingsButton.addTarget(self, action: #selector(iQuizTableViewController.showSettings(_:)), for: .touchUpInside)
    }
    
    func createArray() -> [Quiz]{
        var temp : [Quiz] = []
        
        let img1 = Quiz(image: #imageLiteral(resourceName: "math"), title:"Math")
        let img2 = Quiz(image: #imageLiteral(resourceName: "marvel.png"), title: "Marvel Super Heroes")
        let img3 = Quiz(image: #imageLiteral(resourceName: "science"), title: "Science")
        
        temp.append(img1)
        temp.append(img2)
        temp.append(img3)
        
        return temp
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
    
}
