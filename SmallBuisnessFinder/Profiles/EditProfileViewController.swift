//
//  EditProfileViewController.swift
//  SmallBuisnessFinder
//
//  Created by Hsiang-Wei Chiu on 4/6/22.
//

import UIKit

class EditProfileViewController: UIViewController {

    
    var changeAccount = UIButton()
    var fullName = UITextField()
    var email = UITextField()
    var phoneNumber = UITextField()
    var username = UITextField()
    var oldPassword = UITextField()
    var newPassword = UITextField()
    var confirmPassword = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // consider loading the value for the inital user info as default value
        changeAccount.setTitle("Update Account Information", for: .normal)
        
        fullName.text = "Full Name"
        fullName.borderStyle = UITextField.BorderStyle.roundedRect
        email.text = "Email"
        email.borderStyle = UITextField.BorderStyle.roundedRect
        phoneNumber.text = "Phone Number"
        phoneNumber.borderStyle = UITextField.BorderStyle.roundedRect
        username.text = "User Name"
        username.borderStyle = UITextField.BorderStyle.roundedRect
        oldPassword.text = "Previous Password UWU"
        oldPassword.borderStyle = UITextField.BorderStyle.roundedRect
        newPassword.text = "Enter New Password OwO"
        newPassword.borderStyle = UITextField.BorderStyle.roundedRect
        confirmPassword.text = "Confirm Password"
        confirmPassword.borderStyle = UITextField.BorderStyle.roundedRect
        
        
        fullName.backgroundColor = .yellow
         
        view.backgroundColor = .white
        
        view.addSubview(changeAccount)
        view.addSubview(fullName)
        view.addSubview(email)
        view.addSubview(phoneNumber)
        view.addSubview(username)
        view.addSubview(oldPassword)
        view.addSubview(newPassword)
        view.addSubview(confirmPassword)
        
        
        layoutConstraints()
    }
    
    func layoutConstraints() {
        changeAccount.translatesAutoresizingMaskIntoConstraints = false
        fullName.translatesAutoresizingMaskIntoConstraints = false
        email.translatesAutoresizingMaskIntoConstraints = false
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        username.translatesAutoresizingMaskIntoConstraints = false
        oldPassword.translatesAutoresizingMaskIntoConstraints = false
        newPassword.translatesAutoresizingMaskIntoConstraints = false
        confirmPassword.translatesAutoresizingMaskIntoConstraints = false
        
        [
            
            fullName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fullName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -75),
            fullName.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
            fullName.heightAnchor.constraint(equalToConstant: 30),
            
            email.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            email.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 5),
            email.widthAnchor.constraint(equalToConstant: 100),
            email.heightAnchor.constraint(equalToConstant: 20),
            
            phoneNumber.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            phoneNumber.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            phoneNumber.widthAnchor.constraint(equalToConstant: 30),
            phoneNumber.heightAnchor.constraint(equalToConstant: 30),
            
            username.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            username.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            username.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: 35),
            username.heightAnchor.constraint(equalToConstant: 100),
            
            oldPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            oldPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            oldPassword.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: 40),
            oldPassword.heightAnchor.constraint(equalToConstant: 90),
            
            newPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            newPassword.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: 40),
            newPassword.heightAnchor.constraint(equalToConstant: 40),
            newPassword.widthAnchor.constraint(equalToConstant: 150),
            
            confirmPassword.leadingAnchor.constraint(equalTo: fullName.trailingAnchor, constant: 15),
            confirmPassword.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: 40),
            confirmPassword.heightAnchor.constraint(equalToConstant: 40),
            confirmPassword.widthAnchor.constraint(equalToConstant: 150),
            
            changeAccount.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            changeAccount.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
            changeAccount.heightAnchor.constraint(equalToConstant: 80),
            changeAccount.widthAnchor.constraint(equalToConstant: 80),
            
        ].forEach { $0.isActive = true }
    }
    


}
