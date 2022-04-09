//
//  ReviewViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/26/22.
//

import UIKit
import FirebaseDatabase

class ReviewViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    var reviewTitle: UITextField!
    var descriptionBox: UITextField!
    var submitButton: UIButton!
    var businessName: UILabel!
    var descriptionLabel: UILabel!
    var titleLabel: UILabel!
    var rating: UIPickerView!
    
    var ratingsArray = ["1 star", "2 stars", "3 stars", "4 stars", "5 stars"]
    
    var business: BusinessObject?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        view.backgroundColor = .white
        
        titleLabel = UILabel()
        titleLabel.text = "Title"
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textColor = .blue // change to match color scheme
        
        reviewTitle = UITextField()
        reviewTitle.layer.cornerRadius = 10
        reviewTitle.layer.masksToBounds = true
        reviewTitle.backgroundColor = .extraLightGray
        reviewTitle.setLeftPaddingPoints(5)
        
        rating = UIPickerView()
        rating.delegate = self
        rating.dataSource = self
        
        descriptionLabel = UILabel()
        descriptionLabel.text = "Description"
        descriptionLabel.font = .boldSystemFont(ofSize: 24)
        descriptionLabel.textColor = .blue // change to match color scheme
        
        descriptionBox = UITextField()
        descriptionBox.layer.cornerRadius = 10
        descriptionBox.layer.masksToBounds = true
        descriptionBox.backgroundColor = .extraLightGray
        descriptionBox.setLeftPaddingPoints(7)
        descriptionBox.contentVerticalAlignment = .top
        
        businessName = UILabel()
        if let business = business {
            businessName.text = business.name
        } else {
            businessName.text = "Joe's Pizza"
        }
        businessName.textColor = .black
        businessName.textAlignment = .center
        businessName.font = .boldSystemFont(ofSize: 24)
        
        submitButton = UIButton()
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = .blue // change to match color scheme
        submitButton.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
        submitButton.layer.cornerRadius = 10
        submitButton.layer.masksToBounds = true
        
        view.addSubview(businessName)
        view.addSubview(reviewTitle)
        view.addSubview(descriptionBox)
        view.addSubview(submitButton)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(rating)
        
        layoutConstraints()

        // Do any additional setup after loading the view.
    }
    
    
    
    func layoutConstraints() {
        businessName.translatesAutoresizingMaskIntoConstraints = false
        reviewTitle.translatesAutoresizingMaskIntoConstraints = false
        descriptionBox.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        rating.translatesAutoresizingMaskIntoConstraints = false
        [
            businessName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            businessName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            businessName.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
            businessName.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleLabel.topAnchor.constraint(equalTo: businessName.bottomAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            reviewTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            reviewTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            reviewTitle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            reviewTitle.heightAnchor.constraint(equalToConstant: 35),
            
            rating.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            rating.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            rating.topAnchor.constraint(equalTo: reviewTitle.bottomAnchor, constant: 15),
            rating.heightAnchor.constraint(equalToConstant: 50),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            descriptionLabel.topAnchor.constraint(equalTo: rating.bottomAnchor, constant: 15),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 200),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 40),
            
            descriptionBox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            descriptionBox.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            descriptionBox.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            descriptionBox.heightAnchor.constraint(equalToConstant: 200),
            
            submitButton.topAnchor.constraint(equalTo: descriptionBox.bottomAnchor, constant: 30),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 40),
            submitButton.widthAnchor.constraint(equalToConstant: 200),
        ].forEach { $0.isActive = true }
        
    }
    
    @objc func didTapSubmit() {
        // create alert to ask the user if they are sure they want to submit the review and tell them they can't edit it later?
        
        writeReview()
    }
    
    func writeReview() {
        if checkInputs() {
            guard let user = UserFunctions.getUserFromDefaults() else { self.createAlert(with: "Error", message: "Could not find user"); return}
            if let email = user.email {
                let safeKey = email.safeDatabaseKey()
            //let safeKey = "jdimonte-umich-edu"
                Database.database().reference().child("reviews").child(safeKey).child(reviewTitle.text ?? "").setValue(["username": user.username ?? "", "rating": "5", "description": descriptionBox.text ?? ""]) { error, _ in
                    if error == nil {
                        //completion(true)
                        self.navigationController?.popViewController(animated: true)
                        return
                    }
                    else {
                        //completion(false)
                        self.createAlert(with: "Error", message: "There was a problem submitting your review")
                        print("Didn't fucking work")
                        return
                    }
                }
            }
            /*let safeKey1 = "business name"
            Database.database().reference().child("reviews").child(safeKey1).child("Great Company").setValue(["username": "Jaqueline", "rating": "5", "description": "Best company ever"]) { error, _ in
                if error == nil {
                    //completion(true)
                    return
                }
                else {
                    //completion(false)
                    print("Didn't fucking work")
                    return
                }
            }*/
        }
        
    }
    
    func checkInputs() -> Bool {
        if reviewTitle.text != nil && descriptionBox.text != nil {
            return true
        } else {
            self.createAlert(with: "Error", message: "Please make sure you have filled in all the boxes")
            return false
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        ratingsArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ratingsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        return
    }

}
