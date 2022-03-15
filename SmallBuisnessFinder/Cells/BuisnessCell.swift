//
//  BusinessCell.swift
//  SmallBuisnessFinder
//
//  Created by Jacqueline DiMonte on 3/9/22.
//
import UIKit

class BusinessCell: UITableViewCell {

    
    @IBOutlet weak var businessImage: UIImageView!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var businessDescription: UILabel!
    @IBOutlet weak var businessDistance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
