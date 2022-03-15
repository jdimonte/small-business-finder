//
//  NavigationController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/14/22.
//

import Foundation
import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .gray
        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20.0),
                                          .foregroundColor: UIColor.blue]
        
        self.edgesForExtendedLayout = []
        self.navigationBar.tintColor = .white
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
//        self.navigationBar.barStyle = .black
//        self.navigationBar.barTintColor = .conquerBars
//        self.navigationBar.tintColor = .white
        
        
        // Do any additional setup after loading the view.
    }
}
