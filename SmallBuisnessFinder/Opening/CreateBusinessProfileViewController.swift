//
//  CreateBusinessProfileViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 4/9/22.
//

import UIKit
import CoreLocation

class CreateBusinessProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {
    
    var name = UITextField()
    var email = UITextField()
    var username = UITextField()
    var password = UITextField()
    var confirmPassword = UITextField()
    var phoneNumber = UITextField()
    var location = UITextField()
    var websiteLink = UITextField()
    var submit = UIButton()
    var coordinates: CLLocationCoordinate2D?
    var category = UIPickerView()
    //var categoryLabel = UILabel()
    var backButton = UIButton()
    var bio = UITextView()
    
    var categoryOptions = ["Food and Hospitality", "Clothing", "Grocery Store", "Physical Labor", "IT & Internet", "Miscellaneous"]
    var coordinates: CLLocation?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setup()
        // Do any additional setup after loading the view.
    }
    
    
    func setup() {
        
        name.placeholder = "Business Name"
        email.placeholder = "Email"
        username.placeholder = "Username"
        password.placeholder = "Password"
        confirmPassword.placeholder = "Confirm Password"
        phoneNumber.placeholder = "PhoneNumber"
        websiteLink.placeholder = "Website Link"
        //bio.placeholder = "Business Description"
        bio.text = "Business Description"
        
        name.font = .systemFont(ofSize: 14)
        email.font = .systemFont(ofSize: 14)
        username.font = .systemFont(ofSize: 14)
        password.font = .systemFont(ofSize: 14)
        confirmPassword.font = .systemFont(ofSize: 14)
        phoneNumber.font = .systemFont(ofSize: 14)
        websiteLink.font = .systemFont(ofSize: 14)
        bio.font = .systemFont(ofSize: 14)
        
        password.isSecureTextEntry = true
        confirmPassword.isSecureTextEntry = true
        //bio.contentVerticalAlignment = .top
        
        
        submit.setTitle("Create Account", for: .normal)
        submit.layer.cornerRadius = 10
        submit.layer.masksToBounds = true
        submit.setTitleColor(.systemBlue, for: .normal)
        //submit.backgroundColor = .blue // change to color scheme
        submit.addTarget(self, action: #selector(didCreateAccount), for: .touchUpInside)
        
        name.borderStyle = UITextField.BorderStyle.roundedRect
        email.borderStyle = UITextField.BorderStyle.roundedRect
        username.borderStyle = UITextField.BorderStyle.roundedRect
        password.borderStyle = UITextField.BorderStyle.roundedRect
        confirmPassword.borderStyle = UITextField.BorderStyle.roundedRect
        phoneNumber.borderStyle = UITextField.BorderStyle.roundedRect
        websiteLink.borderStyle = UITextField.BorderStyle.roundedRect
        location.borderStyle = UITextField.BorderStyle.roundedRect
        //bio.borderStyle = UITextField.BorderStyle.roundedRect
        bio.layer.borderWidth = 0.5
        bio.layer.borderColor = UIColor.extraLightGray.cgColor
        bio.layer.cornerRadius = 5
        bio.layer.masksToBounds = true
        bio.textColor = .lightGray
        bio.delegate = self
        
        category = UIPickerView()
        category.delegate = self
        category.dataSource = self
        
        
        backButton.setTitle("Have an Account?", for: .normal)
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        backButton.setTitleColor(.systemBlue, for: .normal)
        
        
        view.addSubview(name)
        view.addSubview(email)
        view.addSubview(username)
        view.addSubview(password)
        view.addSubview(confirmPassword)
        view.addSubview(phoneNumber)
        view.addSubview(websiteLink)
        view.addSubview(location)
        view.addSubview(submit)
        view.addSubview(category)
        view.addSubview(backButton)
        view.addSubview(bio)
        
        layoutConstraints()
    }
    
    
    func layoutConstraints() {
        name.translatesAutoresizingMaskIntoConstraints = false
        email.translatesAutoresizingMaskIntoConstraints = false
        username.translatesAutoresizingMaskIntoConstraints = false
        password.translatesAutoresizingMaskIntoConstraints = false
        confirmPassword.translatesAutoresizingMaskIntoConstraints = false
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        websiteLink.translatesAutoresizingMaskIntoConstraints = false
        location.translatesAutoresizingMaskIntoConstraints = false
        submit.translatesAutoresizingMaskIntoConstraints = false
        category.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        bio.translatesAutoresizingMaskIntoConstraints = false
        
        [
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            name.topAnchor.constraint(equalTo: view.topAnchor, constant: 75),
            name.heightAnchor.constraint(equalToConstant: 30),
            
            email.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            email.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 30),
            email.heightAnchor.constraint(equalToConstant: 30),
            
            username.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            username.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            username.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 30),
            username.heightAnchor.constraint(equalToConstant: 30),
            
            password.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            password.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            password.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 30),
            password.heightAnchor.constraint(equalToConstant: 30),
            
            confirmPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmPassword.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 30),
            confirmPassword.heightAnchor.constraint(equalToConstant: 30),
            
            bio.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bio.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bio.topAnchor.constraint(equalTo: confirmPassword.bottomAnchor, constant: 30),
            bio.heightAnchor.constraint(equalToConstant: 100),
            
            phoneNumber.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneNumber.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            phoneNumber.topAnchor.constraint(equalTo: bio.bottomAnchor, constant: 30),
            phoneNumber.heightAnchor.constraint(equalToConstant: 30),
            
            websiteLink.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            websiteLink.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            websiteLink.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: 30),
            websiteLink.heightAnchor.constraint(equalToConstant: 30),
            
            category.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            category.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            category.topAnchor.constraint(equalTo: websiteLink.bottomAnchor, constant: 30),
            category.heightAnchor.constraint(equalToConstant: 50),
            
            location.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            location.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            location.topAnchor.constraint(equalTo: websiteLink.bottomAnchor, constant: 30),
            location.heightAnchor.constraint(equalToConstant: 30),
            
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submit.topAnchor.constraint(equalTo: location.bottomAnchor, constant: 15),
            submit.heightAnchor.constraint(equalToConstant: 40),
            submit.widthAnchor.constraint(equalToConstant: 200),
            
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 150)
            
        ].forEach { $0.isActive = true }
    }
    
    @objc func didTapLocation() {
        // go to location view controller
    }
    //42.2808° N, 83.7430° W
    @objc func didCreateAccount() {
        if checkInputs() {
            guard let name = name.text else { return }
            guard let username = username.text else { return }
            guard let email = email.text else { return }
            guard let password = password.text else { return }
            guard let bio = bio.text else { return }
            
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(location.text!) { (placemarks, error) in
                if error == nil{
                    if let placemark = placemarks?[0]{
                        self.coordinates = placemark.location!
                    }
                }
                else {
                    print("OH NYO CAN'T FIND PLACE AHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH")
                    print("OOOHHHH GOOD LORD PWEASE SAVE MWEEEEEEEEE")
                }
            }
            print(coordinates?.coordinate.latitude)
            print(coordinates?.coordinate.longitude)
            
            AuthManager.sharedAuth.newBusiness(name: name, email: email, password: password, username: username, phoneNumber: phoneNumber.text ?? "", websiteLink: websiteLink.text ?? nil, latCoord: coordinates?.coordinate.latitude ?? nil, longCoord: coordinates?.coordinate.longitude ?? nil) { didRegister in
                // possibly need to put the registration on a separte thread
                if didRegister {
                    // enter app
                    //self.performSegue(withIdentifier: "accountCreated", sender: self)
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    guard let tabbar = storyboard.instantiateViewController(identifier: "tabBar") as? TabBarController else { return }
                    guard let vcs = tabbar.viewControllers else { return }
                    guard let navbar = vcs[0] as? NavigationController else { return }
                    //guard let vc = navbar.topViewController as? HomeViewController else { return }
                    
                    self.present(tabbar, animated: true, completion: nil)
                } else {
                    // create alert for account creation error
                    self.createAlert(with: "Error", message: "Unable to create account")
                }
            }
        }
    }
    @objc func didTapBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func checkInputs() -> Bool {
        if name.text == "" {
            self.createAlert(with: "Missing Info", message: "The name field is required")
            return false
        }
        return true
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryOptions.count
    }
    
    /*func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var pickerLabel = UILabel()
        pickerLabel.text = categoryOptions[row]
        pickerLabel.font = .systemFont(ofSize: 14)
        return categoryOptions[row]
    }*/
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.text = categoryOptions[row]
        pickerLabel.font = .systemFont(ofSize: 16)
        pickerLabel.textColor = .black
        pickerLabel.textAlignment = .center
        return pickerLabel
    }
    
    func textViewDidBeginEditing (_ textView: UITextView) {
        if textView.text == "Business Description" {
            textView.text = ""
            textView.textColor = .black
        }
    }
}
