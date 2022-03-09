//
//  BusinessProfileHeader.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/9/22.
//

import Foundation
import UIKit


class BusinessProfileHeader: UIView {
    var businessImage = UIImageView()
    var name = UILabel()
    var busDescription = UILabel()
    var location = UIButton()
    var numFollowers = UILabel()
    var phoneNumber = UILabel()
    var websiteLink = UIButton()
    var email = UILabel()
    var business: BusinessObject!
    
    init(frame: CGRect, input: BusinessObject) {
        super.init(frame: frame)
        self.business = input
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
    }
    
}
