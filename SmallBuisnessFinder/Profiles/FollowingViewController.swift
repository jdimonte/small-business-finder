//
//  FollowingViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/24/22.
//

import UIKit
import FirebaseDatabase

class FollowingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var tableView = UITableView()
    var usersArray = [UserObject]()
    var isFollowing = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        
        view.addSubview(tableView)
        getData()
        
    }
    
    func getData() {
        let ref = Database.database().reference().child("users")
        
        ref.getData() { error, snapshot in
            guard let dict = snapshot.value as? [String:AnyObject] else { return }
            for i in dict.keys {
                if let bus = dict[i] {
                    self.usersArray.append(UserObject(name: bus["name"] as? String, email: i, username: bus["username"] as? String, phoneNumber: bus["number"] as? String))
                }
            }
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = BusinessProfileViewController()
        vc.isUser = true
        vc.user = self.usersArray[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
