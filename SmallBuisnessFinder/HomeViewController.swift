//
//  HomeViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/16/22.
//

import UIKit
import FirebaseDatabase
import CoreLocation

// Jackson MI
// lat: 42.2459
// long: -84.4013

// New york
// lat:
// long:

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    var businessNames = ["Joe's Pizza", "M-Den", "Target", "No Thai", "Freddy's"," ", " ", " ", " ", " "]
    var businessCategories = ["Restaurant", "Clothing", "General", "Restaurant", "Restaurant", "Grocery", "Clothing", "Restaurant", "Something", "Something"]
    var descriptions = ["Self proclaimed best pizza place in the Ann Arbor area", "Get all your U of M swag, Go Blue", "New addition to Ann Arbor", "Definitely not Thai food", "Second best pizza in the Ann Arbor area because the best was already claimed"]
    var dist = 0.0
    
    
    @IBOutlet weak var tableView: UITableView!
     
    var businessArray = [BusinessObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let locationManager = CLLocationManager()
        locationManager.delegate = self

        // Request user location
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()

        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        //let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        //view.addGestureRecognizer(tap)
        
        self.fetchBusinesses()
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.first {
            let otherLocation = CLLocation(latitude: 42, longitude: -83)
            self.dist = location.distance(from: otherLocation)/1600.0
            print(self.dist)
            self.tableView.reloadData()
            
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        //in failure condition, atm nothing happens
        //TODO : set up a boolean for whether we have user location or not
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
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
    
    // need to get this setup properly so the segue will not happen if the credentials are incorrect
    //override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
      //  return loginSuccess
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businessArray.count == 0 {
            return 0
        } else {
            return businessArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as? BusinessCell
        //let business = self.businessesArray[indexPath.row]
        cell?.businessImage.image = UIImage(named: businessNames[indexPath.row])!
        cell?.businessName.text = businessArray[indexPath.row].name
        cell?.businessDescription.text = businessArray[indexPath.row].busDescription
        cell?.businessDistance.text = String(self.dist)

        return cell!
    }
    /*
     self.businessArray.append(BusinessObject(name: i, phoneNumber: "810-404-2577", busDescription: bus["description"] as? String, latCoord: nil, longCoord: nil, websiteLink: bus["website"] as? String, following: 10, followers: 10))
     */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = BusinessProfileViewController()
        vc.business = BusinessObject(name: businessArray[indexPath.row].name, phoneNumber: businessArray[indexPath.row].phoneNumber, busDescription: businessArray[indexPath.row].busDescription, category: businessArray[indexPath.row].category, latCoord: businessArray[indexPath.row].latCoord, longCoord: businessArray[indexPath.row].longCoord, websiteLink: businessArray[indexPath.row].websiteLink, following: businessArray[indexPath.row].following, followers: businessArray[indexPath.row].followers)
        //performSegue(withIdentifier: "detail", sender: self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}
