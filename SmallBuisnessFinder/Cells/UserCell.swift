//
//  UserCell.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 4/2/22.
//

import Foundation
import UIKit


class UserCell: UITableViewCell {
    
    var profilePicture = UIImageView()
    var name = UILabel()
    var followButton = UIButton()
    
    
    func initUserCell(user: UserObject) {
        self.profilePicture.image = UIImage(named: "Joe's Pizza")
        self.name.text = user.name
        
        self.profilePicture.frame = CGRect(x: 10, y: 10, width: 60, height: 60)
        self.profilePicture.layer.cornerRadius = 30
        self.profilePicture.layer.masksToBounds = true
        self.name.frame = CGRect(x: profilePicture.frame.maxX + 10, y: 20, width: 150, height: 40)
        self.followButton.frame = CGRect(x: name.frame.maxX + 20, y: 20, width: 150, height: 40)
        self.followButton.layer.borderWidth = 3
        self.followButton.layer.borderColor = UIColor.gray.cgColor
        
        contentView.addSubview(name)
        contentView.addSubview(profilePicture)
        contentView.addSubview(followButton)
        
        determineFollowButton()
    }
    
    
    func determineFollowButton() {
        // see if the user for the cell is already followed by the user
        
        var isFollowed = false
        
        if isFollowed {
            followButton.setTitle("Following", for: .normal)
            followButton.backgroundColor = .extraLightGray
            followButton.setTitleColor(.black, for: .normal)
            followButton.addTarget(self, action: #selector(didTapUnfollow), for: .touchUpInside)
        } else {
            followButton.setTitle("Follow", for: .normal)
            followButton.backgroundColor = .white
            followButton.setTitleColor(.black, for: .normal)
            followButton.addTarget(self, action: #selector(didTapFollow), for: .touchUpInside)
        }
    }
    
    @objc func didTapFollow() {
        followButton.backgroundColor = .extraLightGray
        followButton.setTitle("Following", for: .normal)
        followButton.removeTarget(self, action: #selector(didTapFollow), for: .touchUpInside)
        followButton.addTarget(self, action: #selector(didTapUnfollow), for: .touchUpInside)
    }
    @objc func didTapUnfollow() {
        followButton.backgroundColor = .white
        followButton.setTitle("Follow", for: .normal)
        followButton.removeTarget(self, action: #selector(didTapUnfollow), for: .touchUpInside)
        followButton.addTarget(self, action: #selector(didTapFollow), for: .touchUpInside)
    }
}
