//
//  FavoritesCell.swift
//  SmallBuisnessFinder
//
//  Created by Hsiang-Wei Chiu on 3/13/22.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

class FavoritesCell : UITableViewCell {
    var img = UIImageView()
    var starButton = UIButton()
    var name = UILabel()
    var category = UILabel()
    var location = UILabel()
    
    func initFavCell(img : UIImage, name : String, category : String, location : String){
        self.img.image = img
        self.name.text = name
        self.category.text = category
        self.location.text = location
        
        
        self.name.font = .boldSystemFont(ofSize: 18)
        self.category.font = .systemFont(ofSize: 12)
        self.location.font = .systemFont(ofSize: 12)
        
        self.starButton.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        
        self.img.frame = CGRect(x: 5, y: 10, width: 60, height: 60)
        self.starButton.frame = CGRect(x: UIScreen.main.bounds.width - 65, y: 25, width: 30, height: 30)
        self.name.frame = CGRect(x: self.img.frame.maxX + 15, y: 10, width: 200, height: 30)
        self.category.frame = CGRect(x: self.img.frame.maxX + 15, y: 45, width: 60, height: 20)
        self.location.frame = CGRect(x: self.category.frame.maxX + 15, y: 45, width: 180, height: 20)
        
        self.img.layer.cornerRadius = 30
        self.img.layer.masksToBounds = true
        
        self.starButton.addTarget(self, action: #selector(didTapStar), for: .touchUpInside)
        
        contentView.addSubview(self.img)
        contentView.addSubview(self.starButton)
        contentView.addSubview(self.name)
        contentView.addSubview(self.category)
        contentView.addSubview(self.location)
    }
    
    @objc func didTapStar(){
        if self.starButton.currentBackgroundImage == UIImage(systemName: "star") {
            self.starButton.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            //like business!!
            //1) connect to user in database
            let ref = Database.database().reference(withPath:  "users")
            let array_ref = ref.child((Auth.auth().currentUser?.email?.safeDatabaseKey())!)
            //2)add to array
        } else if self.starButton.currentBackgroundImage == UIImage(systemName: "star.fill") {
            self.starButton.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
            //unlike business!!
            //1) connect to user in database
            let ref = Database.database().reference(withPath:  "users")
            let array_ref = ref.child((Auth.auth().currentUser?.email?.safeDatabaseKey())!)
            let thisPostRef = array_ref.childByAutoId //create a new post node
            thisPostRef().setValue("here's a new post") //store the post in it
            //let array_ref = ref.child((Auth.auth().currentUser?.email)!).child("likes")
            //2)remove from array
        }
    }
    
}
