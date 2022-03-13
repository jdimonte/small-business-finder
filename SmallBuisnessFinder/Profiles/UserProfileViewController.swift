//
//  UserProfileViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/9/22.
//

import UIKit

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var profileImage = UIImageView()
    var userName = UILabel()
    var tableView = UITableView()
    var following = UILabel()
    var followers = UILabel()
    var numFollowing = UILabel()
    var numFollower = UILabel()
    var user: UserObject!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    
    func setup() {
        
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableHeaderView = UserProfileHeader(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 500), user: user)
        
        
        layoutConstraints()
    }
    
    
    func layoutConstraints() {
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        userName.translatesAutoresizingMaskIntoConstraints = false
        following.translatesAutoresizingMaskIntoConstraints = false
        followers.translatesAutoresizingMaskIntoConstraints = false
        numFollower.translatesAutoresizingMaskIntoConstraints = false
        numFollowing.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // I have no idea what we are going to do with this
    }

}
