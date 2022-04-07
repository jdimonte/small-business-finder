//
//  ReviewViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/26/22.
//

import UIKit
import FirebaseDatabase

class ReviewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        writeReview()

        // Do any additional setup after loading the view.
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
