//
//  reviewCell.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/12/22.
//

import Foundation
import UIKit


class reviewCell: UICollectionViewCell {
    
    var title = UILabel()
    var rating = UILabel()
    var reviewDescription = UILabel()
    
    
    var recommendedCellWidth: CGFloat = UIScreen.main.bounds.width/2 - 20
    
    
    func reviewCellInit(title: String, rating: String, descrip: String) {
        self.title.text = title
        self.rating.text = "rating: " + rating
        self.reviewDescription.text = descrip
        
        self.title.frame = CGRect(x: 10, y: 5, width: recommendedCellWidth - 15, height: 30)
        self.title.textColor = .white
        self.title.font = .boldSystemFont(ofSize: 20)
        
        self.rating.frame = CGRect(x: 10, y: 40, width: recommendedCellWidth - 15, height: 20)
        self.rating.font = .systemFont(ofSize: 14)
        self.rating.textColor = .white
        
        self.reviewDescription.frame = CGRect(x: 5, y: self.rating.frame.maxY + 10, width: recommendedCellWidth - 10, height: 130)
        self.reviewDescription.font = .systemFont(ofSize: 14)
        self.reviewDescription.textColor = .white
        self.reviewDescription.numberOfLines = 0
        
        addSubview(self.title)
        addSubview(self.rating)
        addSubview(self.reviewDescription)
    }
    
}
