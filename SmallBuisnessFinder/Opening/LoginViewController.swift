//
//  LoginViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 2/24/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {

    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var loginSuccess = true
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? UINavigationController {
            dest.modalPresentationStyle = .fullScreen
        }
    }
    
    
    @IBAction func login(_ sender: Any) {
    
        guard let username = username.text else { return }
        guard let password = password.text else { return }
        
        
        // figure out how we will validate emails
        AuthManager.sharedAuth.loginUser(email: username, password: password) { success in
            if success {
                // user logged in
                let safeKey = username.safeDatabaseKey()
                let ref = Database.database().reference(withPath: "users").child(safeKey)
                ref.getData() { errror, snapshot in
                    guard let dict = snapshot.value as? [String:AnyObject] else { return }
                    let user = UserObject(name: dict["name"] as? String, email: username, username: dict["username"] as? String, phoneNumber: dict["number"] as? String)
                    UserFunctions.saveUserToDefaults(user: user)
                }
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
        password.isSecureTextEntry = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
    // need to get this setup properly so the segue will not happen if the credentials are incorrect
    //override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
      //  return loginSuccess
    //}
}
