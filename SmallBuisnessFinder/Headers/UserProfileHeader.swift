//
//  UserProfileHeader.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/9/22.
//

import Foundation
import UIKit


class UserProfileHeader: UIView {
    
    var profileImage = UIImageView()
    var name = UILabel()
    
    
    // buttons to switch back and forth between the user's favorites and reviews (could change them, not sure yet)
    var favorites = UIButton()
    var reviews = UIButton()
    
    var user: UserObject?
    
    
    
    init(frame: CGRect, user: UserObject) {
        super.init(frame: frame)
        
        profileImage.image = UIImage(named: "Joe's Pizza")
        name.text = user.name
        
        favorites.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        reviews.setBackgroundImage(UIImage(systemName: "list.bullet.rectangle"), for: .normal)
        favorites.addTarget(self, action: #selector(didPressFavorites), for: .touchUpInside)
        reviews.addTarget(self, action: #selector(didPressReviews), for: .touchUpInside)
        
        addSubview(profileImage)
        addSubview(name)
        addSubview(favorites)
        addSubview(reviews)
        
        layoutConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutConstraints() {
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        favorites.translatesAutoresizingMaskIntoConstraints = false
        reviews.translatesAutoresizingMaskIntoConstraints = false
        
        [
            profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            profileImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            
            name.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            name.centerXAnchor.constraint(equalTo: centerXAnchor),
            name.heightAnchor.constraint(equalToConstant: 30),
            name.widthAnchor.constraint(equalToConstant: 300),
            
            reviews.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
            reviews.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIScreen.main.bounds.width/4),
            reviews.heightAnchor.constraint(equalToConstant: 30),
            reviews.widthAnchor.constraint(equalToConstant: 30),
            
            favorites.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
            favorites.trailingAnchor.constraint(equalTo: trailingAnchor, constant: UIScreen.main.bounds.width/4 * 3),
            favorites.heightAnchor.constraint(equalToConstant: 30),
            favorites.widthAnchor.constraint(equalToConstant: 30),
        
        ]
    }
    
    @objc func didPressFavorites() {
        favorites.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        // display the favorites for the user
    }
    @objc func didPressReviews() {
        reviews.setBackgroundImage(UIImage(systemName: "list.bullet.rectangle.fill"), for: .normal)
        // display the reviews for the user
        
    }
}
