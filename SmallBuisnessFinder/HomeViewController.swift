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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailsViewController()
        performSegue(withIdentifier: "detail", sender: self)
        //self.navigationController?.pushViewController(vc, animated: true)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*
        let tappedCell = sender
        let indexPath = self.tableView .indexPath(for: tappedCell as! UITableViewCell)
        //let business = self.businessesArray[indexPath]
        let business:[String:String] = ["name":"Freddy's", "description":"Best Pizza in Ann Arbor!", "distance": "10"]

        let detailsViewController = segue destinationViewController
        
        detailsViewController.business = business
        */
        print("AHHHH")
        
        //let controller = (segue.destination as! UINavigationController).viewControllers[0] as! DetailsViewController
        //controller.businessName.text = "Done..."
    

        
        //guard let firstVC = segue.destination as? DetailsViewController else { return }
        //firstVC.businessName.text = "Freddy's"
        
        print("AHHHH")
        /*
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        NSDictionary *movie = self.movies[indexPath.row];
        
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.movie = movie;
 */
    }
    
    // need to get this setup properly so the segue will not happen if the credentials are incorrect
    //override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
      //  return loginSuccess
}
