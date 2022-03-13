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
    var numFollowers = UILabel()
    var numFollowing = UILabel()
    var followers = UILabel()
    var following = UILabel()
    
    // buttons to switch back and forth between the user's favorites and reviews (could change them, not sure yet)
    var favorites = UIButton()
    var reviews = UIButton()
    
    var user: UserObject?
    
    
    
    init(frame: CGRect, user: UserObject) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
