//
//  FavoritesHeader.swift
//  SmallBuisnessFinder
//
//  Created by Hsiang-Wei Chiu on 3/13/22.
//

import Foundation
import UIKit

class FavoritesHeader : UIView {
    var headerText = UILabel()
    
    override init(frame : CGRect){
        super.init(frame : frame)
        
        initHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initHeader() {
        headerText.font = .boldSystemFont(ofSize: 50)
        headerText.text = "Favorites"
        headerText.frame = CGRect(x: 50, y: 75, width: UIScreen.main.bounds.width - 100, height: 50)
        
        headerText.textAlignment = .center
        
        addSubview(headerText)
    }
}
