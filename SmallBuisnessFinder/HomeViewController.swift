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
    var userLocation : CLLocation?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var businessesArray: NSDictionary!
    
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
            userLocation = location
//            self.dist = round(location.distance(from: otherLocation)/1600.0*10)/10.0
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
                    self.businessArray.append(BusinessObject(name: i, phoneNumber: "810-404-2577", busDescription: bus["description"] as? String, latCoord: Int.random(in: -90..<91), longCoord: Int.random(in: -180..<181), websiteLink: bus["website"] as? String, following: 10, followers: 10))
                }
            }
            
            DispatchQueue.main.async { self.tableView.reloadData() }
            
        }
       
        self.tableView.reloadData()
        
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
        var otherLocation : CLLocation?
        if let businessLat = businessArray[indexPath.row].latCoord {
            if let businessLong = businessArray[indexPath.row].longCoord{
                otherLocation = CLLocation(latitude: Double(businessLat), longitude: Double(businessLong))
            }
        }
        if let UL = self.userLocation, let OL = otherLocation {
            let dist = round(UL.distance(from: OL)/1600.0*10)/10.0
            cell?.businessDistance.text = String(dist)
        }else{
            if let OL = otherLocation {
                var area : CLPlacemark!
                let cityFinder = CLGeocoder()
                cityFinder.reverseGeocodeLocation(OL, completionHandler: { (placemarks, error) in
                    if error == nil, let placemark = placemarks, !placemark.isEmpty {
                        area = placemark.last
                        if let text = area.locality {
                            cell?.businessDistance.text = text
                        }else if let text = area.country {
                            cell?.businessDistance.text = text
                        }else{
                            cell?.businessDistance.text = "Location Unknown"
                        }
                    }
                })
            }else{
                cell?.businessDistance.text = ""
            }
        }
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
}
