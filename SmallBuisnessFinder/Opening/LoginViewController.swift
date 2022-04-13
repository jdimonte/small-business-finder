//
//  LoginViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 2/24/22.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInDelegate {

    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var button: UIButton! //added
    
    var loginSuccess = true
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? UINavigationController {
            dest.modalPresentationStyle = .fullScreen
        }
    }
    
    @IBAction func googleSignInPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    //Sign in functionality will be handled here
        if let error = error {
        print(error.localizedDescription)
        return
        }
        guard let auth = user.authentication else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        Auth.auth().signIn(with: credentials) { (authResult, error) in
            if let error = error {
            print(error.localizedDescription)
            } else {
                print("Login Successful.")
            //This is where you should add the functionality of successful login
            //i.e. dismissing this view or push the home view controller etc
            }
        }
    }
    
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
        password.isSecureTextEntry = true
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)
        
        button.layer.cornerRadius = 0.05 * button.bounds.size.width //added

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
