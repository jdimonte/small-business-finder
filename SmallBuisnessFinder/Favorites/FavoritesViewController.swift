//
//  FavoritesViewController.swift
//  SmallBuisnessFinder
//
//  Created by Hsiang-Wei Chiu on 3/13/22.
//

import UIKit
import FirebaseDatabase

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var favoritesTable = UITableView()
    var user: UserObject!
    var businessArray = [BusinessObject]()
    
    var businessNames = ["Joe's Pizza", "M-Den", "Target", "No Thai", "Freddy's"," ", " ", " ", " ", " "]
    var businessCategories = ["Restaurant", "Clothing", "General", "Restaurant", "Restaurant", "Grocery", "Clothing", "Restaurant", "Something", "Something"]
    var descriptions = ["Self proclaimed best pizza place in the Ann Arbor area", "Get all your U of M swag, Go Blue", "New addition to Ann Arbor", "Definitely not Thai food", "Second best pizza in the Ann Arbor area because the best was already claimed"]

    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTable.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        favoritesTable.delegate = self
        favoritesTable.dataSource = self

        favoritesTable.tableHeaderView = FavoritesHeader(frame : CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200))
        
        favoritesTable.backgroundColor = UIColor(named: "purple") //added
        self.view.backgroundColor = UIColor(named: "purple") //added
        
        view.addSubview(favoritesTable)
        
        //getFavorites()
    }
    
    // get favorites for current user from firebase
    func getFavorites() {
        if let email = user.email {
            let ref = Database.database().reference().child("favorites").child(email)
            
            ref.getData() { error, snapshot in
                guard let dict = snapshot.value as? [String:AnyObject] else { return }
                for i in dict.keys {
                    if let bus = dict[i] {
                        self.businessArray.append(BusinessObject(name: dict[i] as? String, phoneNumber: "810-404-2577", busDescription: bus["description"] as? String, category: bus["category"] as? String, latCoord: nil, longCoord: nil, websiteLink: bus["website"] as? String, following: 10, followers: 10))
                    }
                }
                DispatchQueue.main.async { self.favoritesTable.reloadData() }
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FavoritesCell()
        cell.initFavCell(img: UIImage(named: businessNames[indexPath.row])!, name: businessNames[indexPath.row], category: businessCategories[indexPath.row], location: "Ann Arbor, Michigan")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = BusinessProfileViewController()
        vc.business = BusinessObject(name: businessNames[indexPath.row], phoneNumber: "800-123-4567", busDescription: descriptions[indexPath.row], category: "category", latCoord: nil, longCoord: nil, websiteLink: nil, following: nil, followers: nil)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
