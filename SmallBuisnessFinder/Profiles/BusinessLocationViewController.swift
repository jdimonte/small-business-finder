//
//  BusinessLocationViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/9/22.
//

import UIKit
import MapKit

class BusinessLocationViewController: UIViewController {
    
    var dismissButton = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        dismissButton.addTarget(self, action: #selector(dismissed), for: .touchUpInside)
        dismissButton.frame = CGRect(x: 10, y: 75, width: 30, height: 30)
        dismissButton.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        
        view.addSubview(dismissButton)

        // Do any additional setup after loading the view.
    }
    
    
    @objc func dismissed() {
        self.dismiss(animated: true, completion: nil)
    }
    

}
