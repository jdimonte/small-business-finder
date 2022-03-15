//
//  SearchViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/14/22.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var tableView = UITableView()
    
    private var searchBar = UISearchBar()
    private var businesses = [BusinessObject]()
    var counter = 0
    
    var businessNames = ["Joe's Pizza", "M-Den", "Target", "No Thai", "Freddy's", "", "", "", "", ""]
    var businessCategories = ["Restaurant", "Clothing", "General", "Restaurant", "Restaurant", "Grocery", "Clothing", "Restaurant", "Something", "Something"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .plain, target: self, action: #selector(didTapFilters))
        
        tableView.frame = CGRect(x: 0, y: 150, width: view.frame.size.width, height: view.frame.size.height)
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        setup()

        // Do any additional setup after loading the view.
    }
    
    func setup() {
        searchBar.frame = CGRect(x: 0, y: 110, width: view.frame.size.width, height: 40)
        self.searchBar.delegate = self
        view.addSubview(searchBar)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counter
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FavoritesCell()
        cell.initFavCell(img: UIImage(systemName: "person")!, name: businessNames[indexPath.row], category: businessCategories[indexPath.row], location: "Ann Arbor, MI")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = BusinessProfileViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 3 {
            counter = Int.random(in: 0...10)
            tableView.reloadData()
        }
    }
    
    @objc func didTapFilters() {
        let vc = FiltersViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
