//
//  CreateAccountViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 2/24/22.
//

import UIKit

class CreateAccountViewController: UIViewController {

    
    @IBOutlet weak var haveAccount: UIButton!
    @IBOutlet weak var createAccount: UIButton!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    var isPassword = false
    
    @IBAction func submit(_ sender: Any) {
        
        if checkInputs() {
            guard let name = fullName.text else { return }
            guard let username = username.text else { return }
            guard let email = email.text else { return }
            guard let password = password.text else { return }
            
            AuthManager.sharedAuth.newUser(username: username, email: email, password: password, number: phoneNumber.text ?? nil, name: name, likedBusinesses: []) { didRegister in
                // possibly need to put the registration on a separte thread
                if didRegister {
                    // enter app
                    self.performSegue(withIdentifier: "accountCreated", sender: self)
                } else {
                    // create alert for account creation error
                    self.createAlert(with: "Error", message: "Unable to create account")
                }
            }
        } else {
            if !isPassword {
                createAlert(with: "Error", message: "You are missing one or more of the required fields")
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? UINavigationController {
            dest.modalPresentationStyle = .fullScreen
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setup()
    }
    
    func setup() {
        password.isSecureTextEntry = true
        confirmPassword.isSecureTextEntry = true
        createAccount.layer.cornerRadius = 0.05 * createAccount.bounds.size.width //added

    }
    
    func checkInputs() -> Bool {
        if fullName.text == nil {
            return false
        }
        
        if email.text == nil {
            return false
        }
        
        if username.text == nil {
            return false
        }
        
        if password.text == nil {
            return false
        }
        if password.text != confirmPassword.text {
            isPassword = true
            createAlert(with: "Error", message: "Passwords do not match")
            return false
        }
        return true
    }

}
