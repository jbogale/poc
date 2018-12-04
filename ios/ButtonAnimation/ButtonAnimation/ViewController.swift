//
//  ViewController.swift
//  test2
//
//  Created by Joseph Bogale on 5/22/18.
//  Copyright © 2018 Joseph Bogale. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var startOverButton: UIButton!
    @IBAction func startOver(_ sender: Any) {
        startOverButton.isHidden = true
        button.resetBackToInitialState()
    }
    
    @IBAction func completeProcessing(_ sender: Any) {
        button.finishProcessing()
        completeButton.isHidden  = true
        startOverButton.isHidden = false
    }
    
    @IBAction func ProcessButton(_ sender: Any) {
        button.startProcessing{}
        completeButton.isHidden = false
    }
    
    @IBOutlet weak var button: AnimatedUIBUtton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
    
    
}

