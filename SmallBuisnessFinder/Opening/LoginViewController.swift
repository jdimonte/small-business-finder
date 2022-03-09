//
//  LoginViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 2/24/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    var loginSuccess = true
    
    
    @IBAction func login(_ sender: Any) {
    
        guard let username = username.text else { return }
        guard let password = password.text else { return }
        
        
        // figure out how we will validate emails
        AuthManager.sharedAuth.loginUser(email: username, password: password) { success in
            if success {
                // user logged in
                self.performSegue(withIdentifier: "login", sender: self)
            }
            else {
                // error
                self.createAlert(with: "Error", message: "Invalid username or password")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // need to get this setup properly so the segue will not happen if the credentials are incorrect
    //override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
      //  return loginSuccess
    //}
}
