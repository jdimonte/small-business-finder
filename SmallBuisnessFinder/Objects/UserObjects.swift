//
//  UserObjects.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/9/22.
//

import Foundation
import UIKit


class UserObject {
    var name: String?
    var email: String?
    var profileImageLink: String?
    var profileImage: UIImage?
    var username: String?
    var phoneNumber: String?
    
    
    init(name: String?, email: String?, username: String?, phoneNumber: String?) {
        self.name = name
        self.email = email
        self.username = username
        self.phoneNumber = phoneNumber
    }
}

public class UserFunctions {
    static func saveUserToDefaults(user: UserObject) {
        UserDefaults.standard.setValue(user.name, forKey: "name")
        UserDefaults.standard.setValue(user.username, forKey: "username")
        UserDefaults.standard.setValue(user.email, forKey: "email")
        UserDefaults.standard.setValue(user.phoneNumber, forKey: "phoneNum")
        //UserDefaults.standard.setValue(user.bio, forKey: "bio")
    }
    
    static func getUserFromDefaults() -> UserObject? {
        let user = UserObject(name: "Hello", email: "bye", username: "Hello", phoneNumber: "8104444444")
        guard let name = UserDefaults.standard.value(forKey: "name") as? String else { return nil }
        user.name = name
        user.username = UserDefaults.standard.value(forKey: "username") as? String
        user.email = UserDefaults.standard.value(forKey: "email") as? String
        user.phoneNumber = UserDefaults.standard.value(forKey: "phoneNum") as? String
        
        return user
    }
}
