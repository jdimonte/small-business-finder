//
//  FeedViewController.swift
//  SmallBuisnessFinder
//
//  Created by Jacqueline DiMonte on 3/9/22.
//
import UIKit
import FirebaseDatabase

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as? BusinessCell
        //let business = self.businessesArray[indexPath.row]
        cell?.businessImage.image = UIImage(named: "pizza")!
        cell?.businessName.text = "Freddy's"
        cell?.businessDescription.text = "Best Pizza in Ann Arbor!"
        cell?.businessDistance.text = "10"

        return cell!
    }
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var businessesArray: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.fetchBusinesses()
    }
    
    func fetchBusinesses() {
        //make array of businesses
        /*
        var ref:DatabaseReference!
        ref = Database.database().reference()
         */
        
        /*
        let ref = Database.database().reference()
        let usersRef = ref.child("businesses").observeSingleEvent(of: .value, with: {(snapshot) in
        print(snapshot)
        self.businessesArray = snapshot.value as! NSDictionary
        print(self.businessesArray)
        */
//stores users data in dictionary(key/value pairs)
        /*
        let item = ref.child("businesses").observe(.childAdded) { (snapshot) in
          print("\((snapshot.value as? NSDictionary)!)")
          self.tableView.reloadData()
        }
        */
    }
    
    // need to get this setup properly so the segue will not happen if the credentials are incorrect
    //override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
      //  return loginSuccess
}
