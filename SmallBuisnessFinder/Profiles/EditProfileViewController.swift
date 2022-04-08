//
//  EditProfileViewController.swift
//  SmallBuisnessFinder
//
//  Created by Hsiang-Wei Chiu on 4/6/22.
//

import UIKit
import FirebaseDatabase

class EditProfileViewController: UIViewController {

    var userInfo : UserObject?
    
    var changeAccount = UIButton()
    var fullName = UITextField()
    var email = UITextField()
    var phoneNumber = UITextField()
    var username = UITextField()
    
    var FNLabel = UILabel()
    var ELabel = UILabel()
    var PNLabel = UILabel()
    var UNLabel = UILabel()
//    var oldPassword = UITextField()
//    var newPassword = UITextField()
//    var confirmPassword = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // consider loading the value for the inital user info as default value
        changeAccount.setTitle("Update Account", for: .normal)
        changeAccount.setTitleColor(UIColor.black, for: .normal)
        changeAccount.backgroundColor = .red
        changeAccount.layer.borderWidth = 1
        changeAccount.layer.borderColor = UIColor.black.cgColor
        changeAccount.layer.cornerRadius = 10
        changeAccount.addTarget(self, action: #selector(accUpdate), for: .touchUpInside)
        
        fullName.text = "Full Name"
        fullName.borderStyle = UITextField.BorderStyle.roundedRect
        email.text = "joewentz-gmail-com"
        email.borderStyle = UITextField.BorderStyle.roundedRect
        email.isUserInteractionEnabled = false;
        email.backgroundColor = .lightGray
        phoneNumber.text = "Phone Number"
        phoneNumber.borderStyle = UITextField.BorderStyle.roundedRect
        username.text = "Username"
        username.borderStyle = UITextField.BorderStyle.roundedRect
//        oldPassword.text = "Previous Password UWU"
//        oldPassword.borderStyle = UITextField.BorderStyle.roundedRect
//        newPassword.text = "Enter New Password OwO"
//        newPassword.borderStyle = UITextField.BorderStyle.roundedRect
//        confirmPassword.text = "Confirm Password"
//        confirmPassword.borderStyle = UITextField.BorderStyle.roundedRect
        
        initTexts()
        
        
        FNLabel.text = "Full Name"
        FNLabel.font = .boldSystemFont(ofSize: 20)
        FNLabel.textColor = .purple
        ELabel.text = "Email"
        ELabel.font = .boldSystemFont(ofSize: 20)
        ELabel.textColor = .purple
        PNLabel.text = "Phone Number"
        PNLabel.font = .boldSystemFont(ofSize: 20)
        PNLabel.textColor = .purple
        UNLabel.text = "Username"
        UNLabel.font = .boldSystemFont(ofSize: 20)
        UNLabel.textColor = .purple
         
        view.backgroundColor = .white
        
        view.addSubview(changeAccount)
        view.addSubview(fullName)
        view.addSubview(email)
        view.addSubview(phoneNumber)
        view.addSubview(username)
//        view.addSubview(oldPassword)
//        view.addSubview(newPassword)
//        view.addSubview(confirmPassword)
        
        view.addSubview(FNLabel)
        view.addSubview(ELabel)
        view.addSubview(PNLabel)
        view.addSubview(UNLabel)
        
        
        layoutConstraints()
    }
    
    func initTexts(){
        if let getUser = UserFunctions.getUserFromDefaults(){
            self.userInfo = getUser
            self.fullName.text = self.userInfo?.name
            self.email.text = self.userInfo?.email
            self.phoneNumber.text = self.userInfo?.phoneNumber
            self.username.text = self.userInfo?.username
        } else {
            self.fullName.text = "UwU"
            self.email.text = "joewentz-gmail-com"
            self.phoneNumber.text = "-W-"
            self.username.text = "T_T"
        }
    }
    
    func layoutConstraints() {
        changeAccount.translatesAutoresizingMaskIntoConstraints = false
        fullName.translatesAutoresizingMaskIntoConstraints = false
        email.translatesAutoresizingMaskIntoConstraints = false
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        username.translatesAutoresizingMaskIntoConstraints = false
//        oldPassword.translatesAutoresizingMaskIntoConstraints = false
//        newPassword.translatesAutoresizingMaskIntoConstraints = false
//        confirmPassword.translatesAutoresizingMaskIntoConstraints = false
        
        FNLabel.translatesAutoresizingMaskIntoConstraints = false
        ELabel.translatesAutoresizingMaskIntoConstraints = false
        PNLabel.translatesAutoresizingMaskIntoConstraints = false
        UNLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [
            FNLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            FNLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -75),
            FNLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
            FNLabel.heightAnchor.constraint(equalToConstant: 30),
            
            fullName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fullName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -75),
            fullName.topAnchor.constraint(equalTo: FNLabel.bottomAnchor, constant: 0),
            fullName.heightAnchor.constraint(equalToConstant: 30),
            
            ELabel.leadingAnchor.constraint(equalTo: fullName.leadingAnchor, constant: 0),
            ELabel.trailingAnchor.constraint(equalTo: fullName.trailingAnchor, constant: 0),
            ELabel.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: 30),
            ELabel.heightAnchor.constraint(equalToConstant: 30),
            
            email.leadingAnchor.constraint(equalTo: fullName.leadingAnchor, constant: 0),
            email.trailingAnchor.constraint(equalTo: fullName.trailingAnchor, constant: 0),
            email.topAnchor.constraint(equalTo: ELabel.bottomAnchor, constant: 0),
            email.heightAnchor.constraint(equalToConstant: 30),
            
            PNLabel.leadingAnchor.constraint(equalTo: fullName.leadingAnchor, constant: 0),
            PNLabel.trailingAnchor.constraint(equalTo: fullName.trailingAnchor, constant: 0),
            PNLabel.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 30),
            PNLabel.heightAnchor.constraint(equalToConstant: 30),
            
            phoneNumber.leadingAnchor.constraint(equalTo: fullName.leadingAnchor, constant: 0),
            phoneNumber.trailingAnchor.constraint(equalTo: fullName.trailingAnchor, constant: 0),
            phoneNumber.topAnchor.constraint(equalTo: PNLabel.bottomAnchor, constant: 0),
            phoneNumber.heightAnchor.constraint(equalToConstant: 30),
            
            UNLabel.leadingAnchor.constraint(equalTo: fullName.leadingAnchor, constant: 0),
            UNLabel.trailingAnchor.constraint(equalTo: fullName.trailingAnchor, constant: 0),
            UNLabel.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: 30),
            UNLabel.heightAnchor.constraint(equalToConstant: 30),
            
            username.leadingAnchor.constraint(equalTo: fullName.leadingAnchor, constant: 0),
            username.trailingAnchor.constraint(equalTo: fullName.trailingAnchor, constant: 0),
            username.topAnchor.constraint(equalTo: UNLabel.bottomAnchor, constant: 0),
            username.heightAnchor.constraint(equalToConstant: 30),
            
//            oldPassword.leadingAnchor.constraint(equalTo: fullName.leadingAnchor, constant: 0),
//            oldPassword.trailingAnchor.constraint(equalTo: fullName.trailingAnchor, constant: 0),
//            oldPassword.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 10),
//            oldPassword.heightAnchor.constraint(equalToConstant: 30),
//
//            newPassword.leadingAnchor.constraint(equalTo: fullName.leadingAnchor, constant: 0),
//            newPassword.trailingAnchor.constraint(equalTo: fullName.trailingAnchor, constant: 0),
//            newPassword.topAnchor.constraint(equalTo: oldPassword.bottomAnchor, constant: 10),
//            newPassword.heightAnchor.constraint(equalToConstant: 30),
//
//            confirmPassword.leadingAnchor.constraint(equalTo: fullName.leadingAnchor, constant: 0),
//            confirmPassword.trailingAnchor.constraint(equalTo: fullName.trailingAnchor, constant: 0),
//            confirmPassword.topAnchor.constraint(equalTo: newPassword.bottomAnchor, constant: 10),
//            confirmPassword.heightAnchor.constraint(equalToConstant: 30),
            
            changeAccount.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            changeAccount.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 40),
            changeAccount.heightAnchor.constraint(equalToConstant: 30),
            changeAccount.widthAnchor.constraint(equalToConstant: 200),
            
        ].forEach { $0.isActive = true }
    }
    
    @objc func accUpdate(){
        if let safeKey = email.text{
            Database.database().reference().child("users").child(safeKey).setValue(["username": username.text, "number": phoneNumber.text, "name": fullName.text]) { error, _ in
                if error == nil {
                    self.navigationController?.popViewController(animated: true)
                    return
                }
                else {
                    return
                }
            }
        }else{
            print("Email not found, bad")
        }
        
    }


}
