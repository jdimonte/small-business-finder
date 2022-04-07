//
//  ReviewViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/26/22.
//

import UIKit
import FirebaseDatabase

class ReviewViewController: UIViewController {
    
    var reviewTitle: UITextField!
    var desciptionBox: UITextField!
    var submitButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        reviewTitle = UITextField()
        
        submitButton = UIButton()
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = .blue // change to match color scheme
        submitButton.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
        
        
        layoutConstraints()

        // Do any additional setup after loading the view.
    }
    
    
    
    func layoutConstraints() {
        
    }
    
    @objc func didTapSubmit() {
        // create alert to ask the user if they are sure they want to submit the review and tell them they can't edit it later?
        
        writeReview()
    }
    
    func writeReview() {
        //guard let user = UserFunctions.getUserFromDefaults() else { self.createAlert(with: "Error", message: "Could not find user"); return}
        //if let email = user.email {
            //let safeKey = email.safeDatabaseKey()
        let safeKey = "jdimonte-umich-edu"
        Database.database().reference().child("reviews").child(safeKey).child("Great Company").setValue(["username": "Jaqueline", "rating": "5", "description": "Best company ever"]) { error, _ in
                if error == nil {
                    //completion(true)
                    return
                }
                else {
                    //completion(false)
                    print("Didn't fucking work")
                    return
                }
            }
        //}
        let safeKey1 = "business name"
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
        }
    }

}
