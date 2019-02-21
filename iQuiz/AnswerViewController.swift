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
    @IBOutlet weak var correctLabel: UILabel!
    
    var selected : String?
    var correct : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if selected != nil {
            selectedLabel.text = selected
        }
        if correct != nil {
            correctLabel.text = correct
        }
    }
}
