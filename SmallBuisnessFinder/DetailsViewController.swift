//
//  DetailsViewController.swift
//  SmallBuisnessFinder
//
//  Created by Jacqueline DiMonte on 3/15/22.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var businessImage: UIImageView!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var businessDistance: UILabel!
    @IBOutlet weak var businessDescription: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        if((self.businessImage) != nil){
            self.businessImage.layer.cornerRadius = 10
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
