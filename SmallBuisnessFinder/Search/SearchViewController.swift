//
//  SearchViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/14/22.
//

import UIKit

protocol searchDelegate {
    func didApplyFilters()
}
enum searchSettings {
     case businesses, users
}

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, searchDelegate {
    
    
    var tableView = UITableView()
    var usersTableView = UITableView()
    var scrollView = UIScrollView()
    
    private var searchBar = UISearchBar()
    var searchSettings: searchSettings = .businesses
    private var businesses = [BusinessObject]()
    
    var segmentControl: UISegmentedControl!
    var selectionBar: UIView!
    var counter = 0
    
    var businessNames = ["Joe's Pizza", "M-Den", "Target", "No Thai", "Freddy's"," ", " ", " ", " ", " "]
    var businessCategories = ["Restaurant", "Clothing", "General", "Restaurant", "Restaurant", "Grocery", "Clothing", "Restaurant", "Something", "Something"]
    var descriptions = ["Self proclaimed best pizza place in the Ann Arbor area", "Get all your U of M swag, Go Blue", "New addition to Ann Arbor", "Definitely not Thai food", "Second best pizza in the Ann Arbor area because the best was already claimed"]
    
    var users = [UserObject(name: "James Veitch", email: "james.vietch@gmail.com"), UserObject(name: "James Veitch", email: "james.vietch@gmail.com"), UserObject(name: "James Veitch", email: "james.vietch@gmail.com"), UserObject(name: "James Veitch", email: "james.vietch@gmail.com"), UserObject(name: "James Veitch", email: "james.vietch@gmail.com")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.frame = CGRect(x: 0, y: 195, width: view.frame.size.width, height: view.frame.size.height)
        self.scrollView.isPagingEnabled = true
        self.scrollView.alwaysBounceVertical = false
        view.addSubview(scrollView)
        
        view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .plain, target: self, action: #selector(didTapFilters))
        
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        tableView.dataSource = self
        tableView.delegate = self
        
        scrollView.addSubview(tableView)
        
        usersTableView.frame = CGRect(x: view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        usersTableView.dataSource = self
        usersTableView.delegate = self
        scrollView.addSubview(usersTableView)
        
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        counter = 0
        searchBar.text = ""
        searchSettings = .businesses
        segmentControl.selectedSegmentIndex = 0
        selectionBar.frame.origin.x = 0
        tableView.reloadData()
    }
    
    func setup() {
        searchBar.frame = CGRect(x: 0, y: 110, width: view.frame.size.width, height: 40)
        segmentControl = ClearSegmentedControl(items: ["Businesses", "Users"])
        segmentControl.frame = CGRect(x: 0, y: searchBar.frame.maxY, width: view.frame.size.width, height: 40)
        segmentControl.addTarget(self, action: #selector(didChangeSearch), for: .valueChanged)
        view.addSubview(segmentControl)
        
        selectionBar = UIView(frame: CGRect(x: 0, y: segmentControl.frame.maxY , width: view.frame.size.width/2, height: 5))
        selectionBar.backgroundColor = .blue // change to match color scheme
        segmentControl.selectedSegmentIndex = 0
        self.searchBar.delegate = self
        
        view.addSubview(searchBar)
        view.addSubview(selectionBar)
    }
    @objc func didChangeSearch() {
        if segmentControl.selectedSegmentIndex == 1 {
            selectionBar.frame.origin.x = view.frame.size.width/2
            self.searchSettings = .users
            self.usersTableView.reloadData()
        } else {
            selectionBar.frame.origin.x = 0
            self.searchSettings = .businesses
            self.tableView.reloadData()
        }
        self.scrollView.setContentOffset(CGPoint(x: (self.view.frame.size.width * CGFloat(segmentControl.selectedSegmentIndex)), y: 0), animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counter
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch searchSettings {
        case .businesses:
            let cell = FavoritesCell()
            cell.initFavCell(img: UIImage(named: businessNames[indexPath.row])!, name: businessNames[indexPath.row], category: businessCategories[indexPath.row], location: "Ann Arbor, MI")
            return cell
        case .users:
            let cell = UserCell()
            cell.initUserCell(user: users[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = BusinessProfileViewController()
        
        switch searchSettings {
        case .businesses:
            vc.isUser = false
            vc.business = BusinessObject(name: businessNames[indexPath.row], phoneNumber: "800-123-4567", busDescription: descriptions[indexPath.row], latCoord: nil, longCoord: nil, websiteLink: nil, following: nil, followers: nil)
        case .users:
            vc.isUser = true
            vc.user = users[indexPath.row]
        }
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 3 {
            counter = Int.random(in: 0...5)
            switch searchSettings {
            case .businesses:
                tableView.reloadData()
            case .users:
                usersTableView.reloadData()
            }
            //tableView.reloadData()
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView != self.usersTableView && scrollView != self.tableView {
            self.selectionBar.frame.origin.x = (self.scrollView.contentOffset.x/2)
            let width = scrollView.frame.size.width
            let page = (scrollView.contentOffset.x + (0.5 * width)) / width
            if page >= 0 && page < 2 {
                self.segmentControl.selectedSegmentIndex = Int(page)
            }
        }
        resignFirstResponder()
    }

}
