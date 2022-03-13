//
//  BusinessProfileViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/9/22.
//

import UIKit
import SafariServices
import FirebaseDatabase

struct reviewContent {
    var title: String?
    var rating: String?
    var reviewDescription: String?
}

class BusinessProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
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
    var reviewsArray: [reviewContent]?
    
    var favorite = UIButton()
    
    var reviewCollection: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        retrieveData()
        
       /* while(!isReady) {
            if let business = self.business {
                isReady = true
            }
        }*/
        runEverything()
    }
    
    func runEverything() {
        setup()
    }
    
    func setup() {
        
        self.name.text = "Beauty Salon" // business.name ??
        self.name.font = .boldSystemFont(ofSize: 24)
        self.name.textColor = .black
        
        self.phoneNumber.text = "810-404-2577"
        self.phoneNumber.font = .systemFont(ofSize: 14)
        
        self.busDescription.text = "Best Beauty Salon in Ann Arbor" //business.busDescription ??
        self.busDescription.font = .systemFont(ofSize: 12)
        self.busDescription.textColor = .black
        
        descriptionView.backgroundColor = .extraLightGray  // placeholder for now, probably will want to change
        descriptionView.layer.cornerRadius = 30
        descriptionView.layer.masksToBounds = true
        
        location.addTarget(self, action: #selector(didTapLocation), for: .touchUpInside)
        location.backgroundColor = .extraLightGray // placeholder again
        location.layer.cornerRadius = 10
        location.layer.masksToBounds = true
        let config = UIImage.SymbolConfiguration(pointSize: 30)
        location.setImage(UIImage(systemName: "location.circle", withConfiguration: config), for: .normal)
        //location.setBackgroundImage(UIImage(systemName: "location.circle"), for: .normal)
        
        websiteLink.addTarget(self, action: #selector(didTapWebsite), for: .touchUpInside)
        websiteLink.backgroundColor = .extraLightGray // palceholder again
        websiteLink.layer.cornerRadius = 10
        websiteLink.layer.masksToBounds = true
        websiteLink.setImage(UIImage(systemName: "globe", withConfiguration: config), for: .normal)
        
        
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
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: view.frame.size.width/2 - 20, height: 200)
        reviewCollection = UICollectionView(frame: CGRect(x: 0, y: 400, width: view.frame.size.width, height: view.frame.size.height - 400), collectionViewLayout: layout)
        reviewCollection.delegate = self
        reviewCollection.dataSource = self
        reviewCollection?.register(reviewCell.self, forCellWithReuseIdentifier: "MyCell")
        
        
        favorite.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        favorite.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        
        view.addSubview(reviewCollection)
        view.addSubview(name)
        view.addSubview(phoneNumber)
        view.addSubview(descriptionView)
        view.addSubview(busDescription)
        view.addSubview(location)
        view.addSubview(websiteLink)
        view.addSubview(businessImage)
        view.addSubview(favorite)
        
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
        favorite.translatesAutoresizingMaskIntoConstraints = false
        
        [
            businessImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            businessImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            businessImage.heightAnchor.constraint(equalToConstant: 50),
            businessImage.widthAnchor.constraint(equalToConstant: 50),
            
            name.leadingAnchor.constraint(equalTo: businessImage.trailingAnchor, constant: 20),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -75),
            name.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            name.heightAnchor.constraint(equalToConstant: 30),
            
            phoneNumber.leadingAnchor.constraint(equalTo: businessImage.trailingAnchor, constant: 20),
            phoneNumber.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            phoneNumber.widthAnchor.constraint(equalToConstant: 100),
            phoneNumber.heightAnchor.constraint(equalToConstant: 20),
            
            favorite.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            favorite.topAnchor.constraint(equalTo: view.topAnchor, constant: 105),
            favorite.heightAnchor.constraint(equalToConstant: 30),
            favorite.widthAnchor.constraint(equalToConstant: 30),
            
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionView.topAnchor.constraint(equalTo: businessImage.bottomAnchor, constant: 35),
            descriptionView.heightAnchor.constraint(equalToConstant: 100),
            busDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            busDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            busDescription.topAnchor.constraint(equalTo: businessImage.bottomAnchor, constant: 40),
            busDescription.heightAnchor.constraint(equalToConstant: 90),
            
            location.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
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
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func didTapWebsite() {
        // take user to the business's website
        let url = URL(string: "https://www.espn.com/") // business.websiteLink
        guard let websiteURL = url else {
            return
        }
        let vc = SFSafariViewController(url: websiteURL)
        present(vc, animated: true, completion: nil)
    }
    
    @objc func didTapFavorite() {
        if favorite.currentBackgroundImage == UIImage(systemName: "star") {
            favorite.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        } else if favorite.currentBackgroundImage == UIImage(systemName: "star.fill") {
            favorite.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    
    func retrieveData() {
        let ref = Database.database().reference(withPath: "businesses")
        
        ref.getData() { error, snapshot in
            guard let dict = snapshot.value as? [String:AnyObject] else { return }
            for i in dict.keys {
                if let bus = dict[i] {
                    self.business = BusinessObject(name: dict[i] as? String, phoneNumber: "810-404-2577", busDescription: bus["description"] as? String, latCoord: nil, longCoord: nil, websiteLink: bus["website"] as? String, following: 10, followers: 10)
                }
            }
        }
    }
    
    func retrieveReviews() {
        let ref = Database.database().reference(withPath: "reviews")
        
        // get the reviews for the specific business and store them in reviewsArray
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let reviewsArray = self.reviewsArray {
            return reviewsArray.count
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = reviewCollection.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! reviewCell
        
        // static content for now, will fill in with review data from the reviewsArray
        cell.reviewCellInit(title: "Great Business", rating: "5", descrip: "really friendly staff, super helpful. Felt right at home the entire time. Would definitely recommend to friends")
        cell.backgroundColor = UIColor.black
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (reviewCollection.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return
    }

}
