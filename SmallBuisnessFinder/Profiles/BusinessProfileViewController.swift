//
//  BusinessProfileViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/9/22.
//

import UIKit
import MapKit
import SafariServices
import FirebaseDatabase

struct reviewContent {
    var title: String?
    var rating: String?
    var reviewDescription: String?
}

protocol PopUpDelegate {
    func setAlphaValue()
}

class BusinessProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, PopUpDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var businessNames = ["Joe's Pizza", "M-Den", "Target", "No Thai", "Freddy's"," ", " ", " ", " ", " "]
    var businessCategories = ["Restaurant", "Clothing", "General", "Restaurant", "Restaurant", "Grocery", "Clothing", "Restaurant", "Something", "Something"]
    var descriptions = ["Self proclaimed best pizza place in the Ann Arbor area", "Get all your U of M swag, Go Blue", "New addition to Ann Arbor", "Definitely not Thai food", "Second best pizza in the Ann Arbor area because the best was already claimed"]
    
    var businessImage = UIImageView()
    var name = UILabel()
    var busDescription = UILabel()
    var location = UIButton()
    /*var numFollowers = UILabel()
    var numFollowing = UILabel()
    var followers = UILabel()
    var following = UILabel()*/
    var phoneNumber = UILabel()
    var websiteLink = UIButton()
    var email = UILabel()
    var tags = UILabel()
    var business = BusinessObject(name: "Definitely a business", phoneNumber: "800-123-4567", busDescription: "Best business in the entire world", latCoord: nil, longCoord: nil, websiteLink: nil, following: nil, followers: nil)
    var descriptionView = UIView()
    var reviewsArray = [reviewContent]()
    
    var favorite = UIButton()
    
    var reviewCollection: UICollectionView!
    var coords : CLLocationCoordinate2D!
    var isUser = true
    
    // user variables
    var profileImage: UIImageView!
    var userName: UILabel!
    var favoritesButton: UIButton!
    var reviewsButton: UIButton!
    var followers: UILabel!
    var following: UILabel!
    var numFollowers: UILabel!
    var numFollowing: UILabel!
    var user = UserObject(name: "Wilson Chiu", email: "joe-wentz-gmail-com", username: nil, phoneNumber: nil)
    var followersButton: UIButton!
    var followingButton: UIButton!
    var scrollView: UIScrollView!
    var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.title = "Profile"
        
        retrieveData()
        runEverything()
    }
    
    func runEverything() {
        if isUser {
            retrieveReviews()
            setupUser()
        } else {
            setup()
        }
    }
    
    func setup() {
        
        self.name.text = business.name ?? "Joe's Pizza"
        self.name.font = .boldSystemFont(ofSize: 24)
        self.name.textColor = .black
        
        self.phoneNumber.text = business.phoneNumber ?? "810-404-2577"
        self.phoneNumber.font = .systemFont(ofSize: 14)
        
        self.busDescription.text = business.busDescription ?? "Self proclaimed best pizza place in the Ann Arbor area, hands down" //business.busDescription ??
        self.busDescription.font = .systemFont(ofSize: 12)
        self.busDescription.textColor = .black
        self.busDescription.numberOfLines = 0
        
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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(didTapHere))
        
        
        businessImage.image = UIImage(named: business.name ?? " ")
        businessImage.layer.cornerRadius = 40
        businessImage.layer.masksToBounds = true
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: view.frame.size.width/2 - 20, height: 200)
        reviewCollection = UICollectionView(frame: CGRect(x: 0, y: 425, width: view.frame.size.width, height: view.frame.size.height - 400), collectionViewLayout: layout)
        reviewCollection.delegate = self
        reviewCollection.dataSource = self
        reviewCollection?.register(reviewCell.self, forCellWithReuseIdentifier: "MyCell")
        
        
        favorite.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
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
            businessImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
            businessImage.heightAnchor.constraint(equalToConstant: 80),
            businessImage.widthAnchor.constraint(equalToConstant: 80),
            
            name.leadingAnchor.constraint(equalTo: businessImage.trailingAnchor, constant: 20),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -75),
            name.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
            name.heightAnchor.constraint(equalToConstant: 30),
            
            phoneNumber.leadingAnchor.constraint(equalTo: businessImage.trailingAnchor, constant: 20),
            phoneNumber.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            phoneNumber.widthAnchor.constraint(equalToConstant: 100),
            phoneNumber.heightAnchor.constraint(equalToConstant: 20),
            
            favorite.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            favorite.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
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
        vc.name = business.name ?? "Joe's Pizza"
        // delete
        self.coords = CLLocationCoordinate2D(latitude: 42.279594, longitude: -83.732124) // lat: , long: -83.732124
        vc.coords = self.coords
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func didTapWebsite() {
        // take user to the business's website
        let url = URL(string: "https://www.joespizzanycmenu.com/") // business.websiteLink
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
    @objc func didTapHere() {
        //let vc = SetttingsViewController()
        //let vc = ReviewViewController()
        let vc = CreateBusinessProfileViewController()
        //let vc = LaunchScreenViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupUser() {
        
        if let user = UserFunctions.getUserFromDefaults() {
            self.user = user
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(didTapHere))
        
        profileImage = UIImageView()
        profileImage.image = UIImage(named: "Joe's Pizza")
        profileImage.layer.cornerRadius = 50
        profileImage.layer.masksToBounds = true
        
        name = UILabel()
        name.text = user.name
        name.font = .boldSystemFont(ofSize: 20)
        name.textAlignment = .center
        
        following = UILabel()
        following.text = "Following"
        following.font = .boldSystemFont(ofSize: 18)
        
        followers = UILabel()
        followers.text = "Followers"
        followers.font = .boldSystemFont(ofSize: 18)
        
        numFollowing = UILabel()
        numFollowing.text = "15"
        numFollowing.font = .systemFont(ofSize: 16)
        
        numFollowers = UILabel()
        numFollowers.text = "10"
        numFollowers.font = .systemFont(ofSize: 16)
        
        
        favoritesButton = UIButton()
        reviewsButton = UIButton()
        favoritesButton.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        reviewsButton.setBackgroundImage(UIImage(systemName: "list.bullet.rectangle.fill"), for: .normal)
        favoritesButton.addTarget(self, action: #selector(didPressFavorites), for: .touchUpInside)
        reviewsButton.addTarget(self, action: #selector(didPressReviews), for: .touchUpInside)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: view.frame.size.width/2 - 20, height: 200)
        reviewCollection = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - 400), collectionViewLayout: layout) // 425
        reviewCollection.delegate = self
        reviewCollection.dataSource = self
        reviewCollection?.register(reviewCell.self, forCellWithReuseIdentifier: "MyCell")
        
        followersButton = UIButton()
        followersButton.addTarget(self, action: #selector(didTapFollowers), for: .touchUpInside)
        
        followingButton = UIButton()
        followingButton.addTarget(self, action: #selector(didTapFollowing), for: .touchUpInside)
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 375, width: view.frame.size.width, height: view.frame.size.height - 375))
        scrollView.addSubview(reviewCollection)
        
        
        tableView = UITableView(frame: CGRect(x: view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height - 375))
        tableView.delegate = self
        tableView.dataSource = self
        scrollView.addSubview(tableView)
        
        view.addSubview(scrollView)
        
        //view.addSubview(reviewCollection)
        view.addSubview(profileImage)
        view.addSubview(name)
        view.addSubview(favoritesButton)
        view.addSubview(reviewsButton)
        view.addSubview(followers)
        view.addSubview(following)
        view.addSubview(numFollowers)
        view.addSubview(numFollowing)
        view.addSubview(followingButton)
        view.addSubview(followersButton)
        
        layoutUserConstraints()
    }
    func layoutUserConstraints() {
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        favoritesButton.translatesAutoresizingMaskIntoConstraints = false
        reviewsButton.translatesAutoresizingMaskIntoConstraints = false
        followers.translatesAutoresizingMaskIntoConstraints = false
        following.translatesAutoresizingMaskIntoConstraints = false
        numFollowers.translatesAutoresizingMaskIntoConstraints = false
        numFollowing.translatesAutoresizingMaskIntoConstraints = false
        followingButton.translatesAutoresizingMaskIntoConstraints = false
        followersButton.translatesAutoresizingMaskIntoConstraints = false
        
        [
            profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            
            name.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            name.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            name.heightAnchor.constraint(equalToConstant: 30),
            name.widthAnchor.constraint(equalToConstant: 300),
            
            followers.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20),
            followers.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.size.width/4 - 40),
            followers.heightAnchor.constraint(equalToConstant: 30),
            followers.widthAnchor.constraint(equalToConstant: 100),
            
            following.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20),
            following.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.frame.size.width/4 + 40)),
            following.heightAnchor.constraint(equalToConstant: 30),
            following.widthAnchor.constraint(equalToConstant: 100),
            
            numFollowers.topAnchor.constraint(equalTo: followers.bottomAnchor, constant: 5),
            numFollowers.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.size.width/4 - 10),
            numFollowers.heightAnchor.constraint(equalToConstant: 30),
            numFollowers.widthAnchor.constraint(equalToConstant: 100),
            
            numFollowing.topAnchor.constraint(equalTo: following.bottomAnchor, constant: 5),
            numFollowing.leadingAnchor.constraint(equalTo: numFollowers.trailingAnchor, constant: view.frame.size.width/4 + 5),
            numFollowing.heightAnchor.constraint(equalToConstant: 30),
            numFollowing.widthAnchor.constraint(equalToConstant: 100),
            
            followersButton.topAnchor.constraint(equalTo: followers.topAnchor, constant: 10),
            followersButton.leadingAnchor.constraint(equalTo: followers.leadingAnchor, constant: 10),
            followersButton.trailingAnchor.constraint(equalTo: followers.trailingAnchor, constant: 10),
            followersButton.bottomAnchor.constraint(equalTo: numFollowers.bottomAnchor, constant: 10),
            
            followingButton.topAnchor.constraint(equalTo: following.topAnchor, constant: 10),
            followingButton.leadingAnchor.constraint(equalTo: following.leadingAnchor, constant: 10),
            followingButton.trailingAnchor.constraint(equalTo: following.trailingAnchor, constant: 10),
            followingButton.bottomAnchor.constraint(equalTo: numFollowing.bottomAnchor, constant: 10),
            
            reviewsButton.bottomAnchor.constraint(equalTo: reviewCollection.topAnchor, constant: -10),
            reviewsButton.centerXAnchor.constraint(equalTo: view.leadingAnchor, constant: UIScreen.main.bounds.width/4),
            reviewsButton.heightAnchor.constraint(equalToConstant: 30),
            reviewsButton.widthAnchor.constraint(equalToConstant: 30),
            
            favoritesButton.bottomAnchor.constraint(equalTo: reviewCollection.topAnchor, constant: -10),
            favoritesButton.centerXAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIScreen.main.bounds.width/4),
            favoritesButton.heightAnchor.constraint(equalToConstant: 30),
            favoritesButton.widthAnchor.constraint(equalToConstant: 30),
        
        ].forEach { $0.isActive = true }
    }
    @objc func didPressFavorites() {
        favoritesButton.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        reviewsButton.setBackgroundImage(UIImage(systemName: "list.bullet.rectangle"), for: .normal)
        // display the favorites for the user
        scrollView.setContentOffset(CGPoint(x: view.frame.size.width, y: 0), animated: true)
        
    }
    @objc func didPressReviews() {
        reviewsButton.setBackgroundImage(UIImage(systemName: "list.bullet.rectangle.fill"), for: .normal)
        favoritesButton.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        // display the reviews for the user
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    @objc func didTapFollowers() {
        let vc = FollowingViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func didTapFollowing() {
        let vc = FollowingViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FavoritesCell()
        cell.initFavCell(img: UIImage(named: businessNames[indexPath.row])!, name: businessNames[indexPath.row], category: businessCategories[indexPath.row], location: "Ann Arbor, Michigan")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = BusinessProfileViewController()
        vc.isUser = false
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
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
        if isUser {
            // get the reviews the user has left
            //if let user = UserFunctions.getUserFromDefaults() {
                //if let email = user.email {
            let email = "jdimonte-umich-edu"
                    let ref = Database.database().reference(withPath: "reviews").child(email)
                    
                    ref.getData() { error, snapshot in
                        guard let dict = snapshot.value as? [String:AnyObject] else { return }
                        for i in dict.keys {
                            if let bus = dict[i] {
                                self.reviewsArray.append(reviewContent(title: dict[i] as? String, rating: bus["rating"] as? String, reviewDescription: bus["description"] as? String))
                            }
                        }
                        DispatchQueue.main.async { self.reviewCollection.reloadData() }
                    }
                //}
            //}
        } else {
            if let email = business.email {
                let ref = Database.database().reference(withPath: "reviews").child(email)
                
                ref.getData() { error, snapshot in
                    guard let dict = snapshot.value as? [String:AnyObject] else { return }
                    for i in dict.keys {
                        if let bus = dict[i] {
                            self.reviewsArray.append(reviewContent(title: dict[i] as? String, rating: bus["rating"] as? String, reviewDescription: bus["description"] as? String))
                        }
                    }
                }
            }
        }
        // get the reviews for the specific business and store them in reviewsArray
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.reviewsArray.count == 0 {
            return 0
        } else {
            return self.reviewsArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = reviewCollection.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! reviewCell
        
        if self.reviewsArray.count > 0 {
            cell.reviewCellInit(title: reviewsArray[indexPath.row].title ?? "Great Company", rating: reviewsArray[indexPath.row].rating ?? "5", descrip: reviewsArray[indexPath.row].reviewDescription ?? "This couldn't be better")
        } else {
            // static content for now, will fill in with review data from the reviewsArray
            cell.reviewCellInit(title: "Great Business", rating: "5", descrip: "really friendly staff, super helpful. Felt right at home the entire time. Would definitely recommend to friends")
        }

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
        self.view.alpha = 0.5
        
        // PopUpViewController(title: reviewsArray[indexPath.row].title, text: reviewsArray[indexPath.row].reviewDescription, rating: reviewsArray[indexPath.row].rating, buttonText: "Close")
        let vc = PopUpViewController(title: "Great Business", text: "really friendly staff, super helpful. Felt right at home the entire time. Would definitely recommend to friends", rating: 5, buttonText: "Close")
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    func setAlphaValue() {
        view.alpha = 1.0
    }
}


private class ReviewPopUp: UIView {
    
    let popUpView = UIView(frame: CGRect.zero)
    let title = UILabel(frame: CGRect.zero)
    let rating = UILabel(frame: CGRect.zero)
    let reviewDes = UILabel(frame: CGRect.zero)
    let username = UILabel(frame: CGRect.zero)
    let cancelButton = UIButton(frame: CGRect.zero)
    let starOne = UIImageView(frame: CGRect.zero)
    let starTwo = UIImageView(frame: CGRect.zero)
    let starThree = UIImageView(frame: CGRect.zero)
    let starFour = UIImageView(frame: CGRect.zero)
    let starFive = UIImageView(frame: CGRect.zero)
    
    let borderWidth: CGFloat = 2.0
    
    init() {
        super.init(frame: CGRect.zero)
        
        popUpView.backgroundColor = .black
        popUpView.layer.masksToBounds = true
        popUpView.layer.borderWidth = borderWidth
        popUpView.layer.borderColor = UIColor.blue.cgColor
        
        title.textColor = .white
        title.layer.masksToBounds = true
        title.font = .boldSystemFont(ofSize: 35)
        
        rating.textColor = .white
        rating.font = .systemFont(ofSize: 20)
        rating.layer.masksToBounds = true
        
        reviewDes.textColor = .white
        reviewDes.font = .systemFont(ofSize: 20)
        reviewDes.layer.masksToBounds = true
        reviewDes.numberOfLines = 0
        
        username.textColor = .white
        username.font = .systemFont(ofSize: 12)
        username.layer.masksToBounds = true
        
        cancelButton.backgroundColor = .blue
        cancelButton.setTitle("Close", for: .normal)
        cancelButton.layer.masksToBounds = true
        
        let config = UIImage.SymbolConfiguration(pointSize: 25)
        starOne.image = UIImage(systemName: "star", withConfiguration: config)
        starOne.tintColor = .gold
        starTwo.image = UIImage(systemName: "star", withConfiguration: config)
        starTwo.tintColor = .gold
        starThree.image = UIImage(systemName: "star", withConfiguration: config)
        starThree.tintColor = .gold
        starFour.image = UIImage(systemName: "star", withConfiguration: config)
        starFour.tintColor = .gold
        starFive.image = UIImage(systemName: "star", withConfiguration: config)
        starFive.tintColor = .gold
        
        
        popUpView.addSubview(title)
        popUpView.addSubview(rating)
        popUpView.addSubview(reviewDes)
        popUpView.addSubview(cancelButton)
        popUpView.addSubview(starOne)
        popUpView.addSubview(starTwo)
        popUpView.addSubview(starThree)
        popUpView.addSubview(starFour)
        popUpView.addSubview(starFive)
        addSubview(popUpView)
        
        popUpView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popUpView.widthAnchor.constraint(equalToConstant: 350),
            popUpView.heightAnchor.constraint(equalToConstant: 450),
            popUpView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            popUpView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: popUpView.centerXAnchor),
            title.topAnchor.constraint(equalTo: popUpView.topAnchor, constant: 20),
            title.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        rating.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rating.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 10),
            rating.widthAnchor.constraint(equalToConstant: 70),
            rating.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            rating.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        starOne.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starOne.leadingAnchor.constraint(equalTo: rating.trailingAnchor, constant: 5),
            starOne.widthAnchor.constraint(equalToConstant: 20),
            starOne.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            starOne.heightAnchor.constraint(equalToConstant: 20)
        ])
        starTwo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starTwo.leadingAnchor.constraint(equalTo: starOne.trailingAnchor, constant: 0),
            starTwo.widthAnchor.constraint(equalToConstant: 20),
            starTwo.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            starTwo.heightAnchor.constraint(equalToConstant: 20)
        ])
        starThree.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starThree.leadingAnchor.constraint(equalTo: starTwo.trailingAnchor, constant: 0),
            starThree.widthAnchor.constraint(equalToConstant: 20),
            starThree.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            starThree.heightAnchor.constraint(equalToConstant: 20)
        ])
        starFour.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starFour.leadingAnchor.constraint(equalTo: starThree.trailingAnchor, constant: 0),
            starFour.widthAnchor.constraint(equalToConstant: 20),
            starFour.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            starFour.heightAnchor.constraint(equalToConstant: 20)
        ])
        starFive.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starFive.leadingAnchor.constraint(equalTo: starFour.trailingAnchor, constant: 0),
            starFive.widthAnchor.constraint(equalToConstant: 20),
            starFive.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            starFive.heightAnchor.constraint(equalToConstant: 20)
        ])
                
                
        reviewDes.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reviewDes.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),
            reviewDes.topAnchor.constraint(equalTo: rating.bottomAnchor, constant: 8),
            reviewDes.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 15),
            reviewDes.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -15),
        ])
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),
            cancelButton.bottomAnchor.constraint(equalTo: popUpView.bottomAnchor, constant: -15),
            cancelButton.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 15),
            cancelButton.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -15),
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PopUpViewController: UIViewController {
    
    private let popUpWindowView = ReviewPopUp()
    var delegate: PopUpDelegate?
        
    init(title: String, text: String, rating: Int, buttonText: String) {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        
        popUpWindowView.title.text = title
        popUpWindowView.reviewDes.text = text
        popUpWindowView.rating.text = "Rating: "
        popUpWindowView.cancelButton.setTitle(buttonText, for: .normal)
          
        popUpWindowView.cancelButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
            
        view = popUpWindowView
        
        let config = UIImage.SymbolConfiguration(pointSize: 25)
        for i in 1...rating {
            if i == 1 {
                popUpWindowView.starOne.image = UIImage(systemName: "star.fill", withConfiguration: config)
            } else if i == 2 {
                popUpWindowView.starTwo.image = UIImage(systemName: "star.fill", withConfiguration: config)
            } else if i == 3 {
                popUpWindowView.starThree.image = UIImage(systemName: "star.fill", withConfiguration: config)
            } else if i == 4 {
                popUpWindowView.starFour.image = UIImage(systemName: "star.fill", withConfiguration: config)
            } else if i == 5 {
                popUpWindowView.starFive.image = UIImage(systemName: "star.fill", withConfiguration: config)
            }
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismissView() {
        self.delegate?.setAlphaValue()
        self.dismiss(animated: true, completion: nil)
    }
}
