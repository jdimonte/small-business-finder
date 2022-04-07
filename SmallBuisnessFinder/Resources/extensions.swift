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

class ClearSegmentedControl: UISegmentedControl {
    override init(items: [Any]?) {
        super.init(items: items)

        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Used for the unselected labels
    override var tintColor: UIColor! {
        didSet {
            setTitleTextAttributes([.foregroundColor: tintColor!, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)], for: .normal)
        }
    }

    // Used for the selected label
    override var selectedSegmentTintColor: UIColor? {
        didSet {
            setTitleTextAttributes([.foregroundColor: selectedSegmentTintColor ?? tintColor!, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)], for: .selected)
        }
    }

    private func setup() {
        backgroundColor = .clear

        // Use a clear image for the background and the dividers
        let tintColorImage = UIImage()
        tintColorImage.withTintColor(.clear)
        //tintColorImage.size = CGSize(width: 1, height: 32)
        setBackgroundImage(tintColorImage, for: .normal, barMetrics: .default)
        setDividerImage(tintColorImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)

        // Set some default label colors
        setTitleTextAttributes([.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)], for: .normal)
        setTitleTextAttributes([.foregroundColor: tintColor!, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)], for: .selected)
    }
}
