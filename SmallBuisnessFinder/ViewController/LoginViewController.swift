//
//  LoginViewController.swift
//  SmallBuisnessFinder
//
//  Created by Jacqueline DiMonte on 2/26/22.
//

import UIKit
import FirebaseDatabase

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let ref = Database.database().reference()
        let users = Database.database().reference(withPath: "users")
    }


}

