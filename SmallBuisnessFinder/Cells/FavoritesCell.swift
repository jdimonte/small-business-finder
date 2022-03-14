//
//  FavoritesCell.swift
//  SmallBuisnessFinder
//
//  Created by Hsiang-Wei Chiu on 3/13/22.
//

import Foundation
import UIKit

class FavoritesCell : UITableViewCell {
    var img = UIImageView()
    var starButton = UIButton()
    var name = UILabel()
    var category = UILabel()
    var location = UILabel()
    
    func initFavCell(img : UIImage, name : String, category : String, location : String){
        self.img.image = img
        self.name.text = name
        self.category.text = category
        self.location.text = location
        
        self.name.font = .boldSystemFont(ofSize: 18)
        self.category.font = .systemFont(ofSize: 12)
        self.location.font = .systemFont(ofSize: 12)
        
        self.starButton.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        
        self.img.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        self.starButton.frame = CGRect(x: UIScreen.main.bounds.width - 65, y: 25, width: 30, height: 30)
        self.name.frame = CGRect(x: self.img.frame.maxX + 15, y: 10, width: 200, height: 30)
        self.category.frame = CGRect(x: self.img.frame.maxX + 15, y: 45, width: 60, height: 20)
        self.location.frame = CGRect(x: self.category.frame.maxX + 15, y: 45, width: 180, height: 20)
        
        self.starButton.addTarget(self, action: #selector(didTapStar), for: .touchUpInside)
        
        addSubview(self.img)
        addSubview(self.starButton)
        addSubview(self.name)
        addSubview(self.category)
        addSubview(self.location)
    }
    
    @objc func didTapStar(){
        self.starButton.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
    }
    
}
