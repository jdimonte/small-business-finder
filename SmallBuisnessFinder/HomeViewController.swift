//
//  HomeViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/16/22.
//

import UIKit
import FirebaseDatabase

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var businessNames = ["Joe's Pizza", "M-Den", "Target", "No Thai", "Freddy's"," ", " ", " ", " ", " "]
    var businessCategories = ["Restaurant", "Clothing", "General", "Restaurant", "Restaurant", "Grocery", "Clothing", "Restaurant", "Something", "Something"]
    var descriptions = ["Self proclaimed best pizza place in the Ann Arbor area", "Get all your U of M swag, Go Blue", "New addition to Ann Arbor", "Definitely not Thai food", "Second best pizza in the Ann Arbor area because the best was already claimed"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as? BusinessCell
        //let business = self.businessesArray[indexPath.row]
        cell?.businessImage.image = UIImage(named: businessNames[indexPath.row])!
        cell?.businessName.text = businessNames[indexPath.row]
        cell?.businessDescription.text = descriptions[indexPath.row]
        cell?.businessDistance.text = "10 mi"

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = BusinessProfileViewController()
        vc.business = BusinessObject(name: businessNames[indexPath.row], phoneNumber: "800-123-4567", busDescription: descriptions[indexPath.row], latCoord: nil, longCoord: nil, websiteLink: nil, following: nil, followers: nil)
        //performSegue(withIdentifier: "detail", sender: self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    
    

    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var businessesArray: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)
        
        self.fetchBusinesses()
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
