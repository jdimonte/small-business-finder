//
//  BusinessProfileViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/9/22.
//

import UIKit
import SafariServices
import FirebaseDatabase

class BusinessProfileViewController: UIViewController {
    
    var businessImage = UIImageView()
    var name = UILabel()
    var busDescription = UILabel()
    var location = UIButton()
    var numFollowers = UILabel()
    var numFollowing = UILabel()
    var followers = UILabel()
    var following = UILabel()
    var phoneNumber = UILabel()
    var websiteLink = UIButton()
    var email = UILabel()
    var tags = UILabel()
    var business: BusinessObject!
    var descriptionView = UIView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setup()
        
        retrieveData()
        
        // Do any additional setup after loading the view.
    }
    
    func setup() {
        self.name.text = "Family Business Beauty Salon"
        self.name.font = .boldSystemFont(ofSize: 24)
        self.name.textColor = .black
        
        self.phoneNumber.text = "810-404-2577"
        self.phoneNumber.font = .systemFont(ofSize: 14)
        
        self.busDescription.text = "Best Beauty Salon in Ann Arbor"
        self.busDescription.font = .systemFont(ofSize: 12)
        self.busDescription.textColor = .black
        
        descriptionView.backgroundColor = .lightGray  // placeholder for now, probably will want to change
        
        location.addTarget(self, action: #selector(didTapLocation), for: .touchUpInside)
        location.backgroundColor = .lightGray // placeholder again
        
        websiteLink.addTarget(self, action: #selector(didTapWebsite), for: .touchUpInside)
        websiteLink.backgroundColor = .lightGray // palceholder again
        
        /*followers.text = "Followers"
        followers.textColor = .black
        followers.font = .boldSystemFont(ofSize: 14)
        numFollowers.text = "10"
        numFollowers.textColor = .black
        numFollowers.font = .systemFont(ofSize: 10)
        
        following.text = "Following"
        following.textColor = .black
        following.font = .boldSystemFont(ofSize: 14)
        numFollowing.text = "10"
        numFollowing.textColor = .black
        numFollowing.font = .systemFont(ofSize: 10)*/
        
        businessImage.image = UIImage(systemName: "person")
        
        view.addSubview(name)
        view.addSubview(phoneNumber)
        view.addSubview(descriptionView)
        view.addSubview(busDescription)
        view.addSubview(location)
        view.addSubview(websiteLink)
        view.addSubview(businessImage)
        
        layoutConstraints()
    }
    
    func layoutConstraints() {
        businessImage.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        busDescription.translatesAutoresizingMaskIntoConstraints = false
        location.translatesAutoresizingMaskIntoConstraints = false
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        websiteLink.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        
        [
            businessImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            businessImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            businessImage.heightAnchor.constraint(equalToConstant: 50),
            businessImage.widthAnchor.constraint(equalToConstant: 50),
            
            name.leadingAnchor.constraint(equalTo: businessImage.trailingAnchor, constant: 20),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            name.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            name.heightAnchor.constraint(equalToConstant: 30),
            
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionView.topAnchor.constraint(equalTo: businessImage.bottomAnchor, constant: 35),
            descriptionView.heightAnchor.constraint(equalToConstant: 50),
            busDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            busDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            busDescription.topAnchor.constraint(equalTo: businessImage.bottomAnchor, constant: 40),
            busDescription.heightAnchor.constraint(equalToConstant: 40),
            
            location.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            location.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 40),
            location.heightAnchor.constraint(equalToConstant: 40),
            location.widthAnchor.constraint(equalToConstant: 150),
            
            websiteLink.leadingAnchor.constraint(equalTo: location.trailingAnchor, constant: 15),
            websiteLink.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 40),
            websiteLink.heightAnchor.constraint(equalToConstant: 40),
            websiteLink.widthAnchor.constraint(equalToConstant: 150),
        ].forEach { $0.isActive = true }
    }
    
    
    @objc func didTapLocation() {
        // take user to map VC and display the location(s) of their business
        let vc = BusinessLocationViewController()
    }
    
    @objc func didTapWebsite() {
        // take user to the businesses website
    }
    
    
    func retrieveData() {
        let ref = Database.database().reference(withPath: "businesses")
        ref.getData() { error, snapshot in
            print(snapshot)
        }
    }

}
