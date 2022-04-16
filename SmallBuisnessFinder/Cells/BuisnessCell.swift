//
//  BuisnessCell.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/16/22.
//

import UIKit

class BusinessCell: UITableViewCell {

    
    @IBOutlet weak var businessImage: UIImageView!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var businessDescription: UILabel!
    @IBOutlet weak var businessDistance: UILabel!
    @IBOutlet weak var view: UIView! //added
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.businessImage.layer.cornerRadius = 40
        self.backgroundColor = UIColor(named: "purple")
        self.view.layer.cornerRadius = 0.05 * view.bounds.size.width //added
        self.businessName.font = .boldSystemFont(ofSize: 25) //added
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
