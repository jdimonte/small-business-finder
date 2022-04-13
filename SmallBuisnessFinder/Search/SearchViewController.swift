//
//  SearchViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/14/22.
//

import UIKit
import FirebaseDatabase

protocol searchDelegate {
    func didApplyFilters()
}

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, searchDelegate {
    
    
    var tableView = UITableView()
    
    private var searchBar = UISearchBar()
    var businessArray = [BusinessObject]()
    var filteredBusinessArray = [BusinessObject]()
    private var businesses = [BusinessObject]()
    var counter = 0
    
    var businessNames = ["Joe's Pizza", "M-Den", "Target", "No Thai", "Freddy's"," ", " ", " ", " ", " "]
    var businessCategories = ["Restaurant", "Clothing", "General", "Restaurant", "Restaurant", "Grocery", "Clothing", "Restaurant", "Something", "Something"]
    var descriptions = ["Self proclaimed best pizza place in the Ann Arbor area", "Get all your U of M swag, Go Blue", "New addition to Ann Arbor", "Definitely not Thai food", "Second best pizza in the Ann Arbor area because the best was already claimed"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .plain, target: self, action: #selector(didTapFilters))
        
        tableView.frame = CGRect(x: 0, y: 150, width: view.frame.size.width, height: view.frame.size.height)
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BusinessCell")
        
        view.addSubview(tableView)
        
        self.view.backgroundColor = UIColor(named: "purple") //added
        
        setup()
        fetchBusinesses()

    }
    
    func fetchBusinesses() {
        //make array of businesses
        
        let ref = Database.database().reference(withPath: "businesses")
        
        ref.getData() { error, snapshot in
            guard let dict = snapshot.value as? [String:AnyObject] else { return }
            
            for i in dict.keys {
                if let bus = dict[i] {
                    self.businessArray.append(BusinessObject(name: i, phoneNumber: "810-404-2577", busDescription: bus["description"] as? String, category: bus["category"] as? String, latCoord: nil, longCoord: nil, websiteLink: bus["website"] as? String, following: 10, followers: 10))
                }
            }
            self.filteredBusinessArray = self.businessArray
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
    
    func setup() {
        searchBar.frame = CGRect(x: 0, y: 110, width: view.frame.size.width, height: 40)
        self.searchBar.delegate = self
        view.addSubview(searchBar)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredBusinessArray.count == 0 {
            return 0
        } else {
            return filteredBusinessArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView .dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as? BusinessCell
        let cell = FavoritesCell()
        cell.initFavCell(img: UIImage(named: businessNames[indexPath.row])!, name: filteredBusinessArray[indexPath.row].name!, category: filteredBusinessArray[indexPath.row].category!, location: "10 mi")
        //let business = self.businessesArray[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = BusinessProfileViewController()
        vc.business = BusinessObject(name: businessNames[indexPath.row], phoneNumber: "800-123-4567", busDescription: filteredBusinessArray[indexPath.row].busDescription, category: filteredBusinessArray[indexPath.row].category, latCoord: nil, longCoord: nil, websiteLink: nil, following: nil, followers: nil)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchText.count != 0) {
            filteredBusinessArray = businessArray.filter { $0.name!.range(of: searchText, options: .caseInsensitive) != nil }
        }
        else {
            filteredBusinessArray = businessArray;
        }
        
        tableView.reloadData()
        
        
        if searchText.count >= 3 {
            counter = Int.random(in: 0...5)
            tableView.reloadData()
        }
    }
    
    @objc func didTapFilters() {
        let vc = FiltersViewController()
        vc.delegate = self
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didApplyFilters() {
        counter = 5
        tableView.reloadData()
    }
    

}
