//
//  LaunchScreenViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 4/10/22.
//

import UIKit
import SpriteKit

class LaunchScreenViewController: UIViewController {
    
    var launchImage = UIImageView()
    var labelPositionisLeft = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        launchImage.frame = CGRect(x: view.frame.size.width/4, y: view.frame.size.height/2 - 100, width: view.frame.size.width/2, height: 200)
        launchImage.image = UIImage(named: "Joe's Pizza")
        
        view.addSubview(launchImage)
        
        setup()
    }
    
    func setup() {
        self.animate()
        
    }
    
    func animate() {
        UIImageView.animate(withDuration: 3, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [.curveEaseInOut], animations: {
            self.launchImage.center.y = self.view.bounds.width - 500
            
        }) { _ in
            //self.launchImage.removeFromSuperview()
            
        }
    }

}
