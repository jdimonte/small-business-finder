//
//  FollowingViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/24/22.
//

import UIKit

class FollowingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var tableView = UITableView()
    var usersArray = [UserObject]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if usersArray.count == 0 {
            return 1
        }
        return usersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if usersArray.count != 0 {
            let cell = UserCell()
            cell.initUserCell(user: usersArray[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
        
        
    }

}
