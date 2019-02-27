//
//  iQuizTableViewController.swift
//  iQuiz
//
//  Created by Conor Reiland on 2/16/19.
//  Copyright © 2019 Conor Reiland. All rights reserved.
//

import UIKit
import SystemConfiguration
import Foundation

class iQuizTableViewController: UIViewController {
    
    let cacher: Cacher = Cacher(destination: .atFolder("Cacher"))
    
    var NetworkConnected: Bool = false
    var spinner = UIActivityIndicatorView(style: .gray)
    var quizzes: [Quiz] = []
    var currentQuiz: Quiz?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var SettingsButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showNetworkAlert()
        
        if NetworkConnected{
            QuizRepo.initializeRepo(completion: { (newQuestions: [Quiz]) in
                self.quizzes = newQuestions
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.currentQuiz = self.quizzes[0]
                    self.cacher.persist(item: Quizzes(quizList: newQuestions)) { url, error in
                        if let error = error {
                            print("Text failed to persist: \(error)")
                        } else {
                            print("Text persisted in \(String(describing: url))")
                        }
                    }
                }
            })
        } else {
            if let cachedQuizzes: Quizzes = cacher.load(fileName: "cachedQuizzes") {
                QuizRepo.setQuizList(list: cachedQuizzes.quizzes)
                self.quizzes = QuizRepo.getQuizzes()
            }
            
        }
        tableView.delegate = self
        tableView.dataSource = self
        SettingsButton.setTitle("Settings", for: .normal)
        SettingsButton.addTarget(self, action: #selector(iQuizTableViewController.showSettings(_:)), for: .touchUpInside)
        
    }
    
    //show settings alert
    @IBAction func showSettings(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Settings", message:
            "Enter a quiz link", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Download", style: .default) { (_) in
            guard let textFields = alertController.textFields,
                textFields.count > 0 else {
                    // Could not find textfield
                    return
            }
            
            QuizRepo.setJson(url: textFields[0].text!)
            DispatchQueue.main.async {
                QuizRepo.initializeRepo(completion: { (newQuestions: [Quiz]) in
                    self.cacher.persist(item: Quizzes(quizList: newQuestions)) { url, error in
                        if let error = error {
                            print("Text failed to persist: \(error)")
                        } else {
                            print("Text persisted in \(String(describing: url))")
                        }
                    }
                    self.quizzes = newQuestions
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.currentQuiz = self.quizzes[0]
                    }
                })
                print("reloaded")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Quiz Link"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        //alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //check network connection
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    //shows alert if no connection
    func showNetworkAlert() {
        self.NetworkConnected = isInternetAvailable()
        if !self.NetworkConnected {
            let alert = UIAlertController(title: "Warning", message: "No Network Connection", preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
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
