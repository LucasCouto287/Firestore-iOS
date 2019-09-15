//
//  ViewController.swift
//  Firestore-iOS
//
//  Created by Abdullah Khan on 2019-07-25.
//  Copyright © 2019 Abdullah Khan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loginButton.layer.cornerRadius = 15;
        signUpButton.layer.cornerRadius = 15;
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

