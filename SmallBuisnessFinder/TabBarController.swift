//
//  TabBarController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/14/22.
//

import Foundation
import UIKit


class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .gray
        appearance.compactInlineLayoutAppearance.normal.iconColor = .blue
        appearance.inlineLayoutAppearance.normal.iconColor = .blue
        appearance.stackedLayoutAppearance.normal.iconColor = .blue
        
        self.tabBar.tintColor = .orange
        
        self.tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            //self.tabBar.scrollEdgeAppearance = appearance
        }
        
        
        
    }
}
