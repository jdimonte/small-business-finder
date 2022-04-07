//
//  SettingsViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/16/22.
//

// Happy Birthday Joe
import UIKit

// struct to help with the groupings of cells

struct SettingsCell {
    let title: String
    let handler: (() -> Void)
}

class SetttingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}
