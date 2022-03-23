//
//  extensions.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 2/24/22.
//

import UIKit

extension String {
    func safeDatabaseKey() -> String {
        return self.replacingOccurrences(of: "@", with: "-").replacingOccurrences(of: ".", with: "-")
    }
}

extension UIViewController {
    
    func createAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIColor {
    static var extraLightGray = UIColor(displayP3Red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
    static var gold = UIColor(displayP3Red: 255/255, green: 215/255, blue: 0/255, alpha: 1)
}
