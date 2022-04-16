//
//  BusinessObject.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/9/22.
//

import Foundation
import MapKit
import UIKit


class BusinessObject {
    var name: String?
    var phoneNumber: String?
    var busDescription: String?
    var latCoord: Double?
    var longCoord: Double?
    var category: String?
    //var latCoord: Int?
    //var longCoord: Int?
    var websiteLink: String?
    var following: Int?
    var followers: Int?
    var email: String?
    
    
    init(name: String?, phoneNumber: String?, busDescription: String?, category: String?, latCoord: Double?, longCoord: Double?, websiteLink: String?, following: Int?, followers: Int?) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.busDescription = busDescription
        self.category = category
        self.latCoord = latCoord
        self.longCoord = longCoord
        self.websiteLink = websiteLink
        self.following = following
        self.followers = followers
    }
    
}
