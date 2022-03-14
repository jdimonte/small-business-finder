//
//  FavoritesViewController.swift
//  SmallBuisnessFinder
//
//  Created by Hsiang-Wei Chiu on 3/13/22.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var favoritesTable = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTable.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        favoritesTable.delegate = self
        favoritesTable.dataSource = self

        favoritesTable.tableHeaderView = FavoritesHeader(frame : CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200))
         
        view.backgroundColor = .white
        
        view.addSubview(favoritesTable)
        
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FavoritesCell()
        cell.initFavCell(img: UIImage(systemName: "person")!, name: "Kelp's Paradise", category: "Vegan", location: "Ann Arbor, Michigan")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = BusinessProfileViewController()
        vc.modalPresentationStyle = .fullScreen
        // delete
        // self.coords = CLLocationCoordinate2D(latitude: 25.015941, longitude: 121.303928)
        // vc.coords = self.coords
        self.present(vc, animated: true, completion: nil)
    }

}
