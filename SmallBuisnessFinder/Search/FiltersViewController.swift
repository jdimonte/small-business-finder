//
//  FiltersViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/14/22.
//

import UIKit
import CoreLocation

public struct Filters {
    var location: CLLocationCoordinate2D?
    var radius: Int?
    var categories: [String]?
}
 
class FiltersViewController: UIViewController {
    
    var locationLabel = UILabel()
    var location = UITextView()
    var distanceLabel = UILabel()
    var distance = UISlider()
    var categoriesLabel = UILabel()
    var categories = ["Clothing", "General", "Grocery", "Trinkets", "Restaurant"]
    var dismissButton = UIButton()
    var applyFilters = UIButton()
    var delegate: searchDelegate!
    var filters = [String]()
    var filterButtons = [UIButton]()
    var appliedFilters = Filters(location: nil, radius: nil, categories: nil)
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)
        
        
        view.backgroundColor = .white
 
        locationLabel.text = "Location"
        locationLabel.textColor = .black
        locationLabel.font = .boldSystemFont(ofSize: 20)
        
        distanceLabel.text = "Radius"
        distanceLabel.textColor = .black
        distanceLabel.font = .boldSystemFont(ofSize: 20)
        
        self.distance.minimumValue = 1
        self.distance.maximumValue = 100
        
        categoriesLabel.text = "Products"
        categoriesLabel.textColor = .black
        categoriesLabel.font = .boldSystemFont(ofSize: 20)
        
        location.backgroundColor = .extraLightGray
        location.layer.cornerRadius = 5
        location.layer.masksToBounds = true
        location.font = .systemFont(ofSize: 20)
        
        dismissButton.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        dismissButton.addTarget(self, action: #selector(didTapDismiss), for: .touchUpInside)
        
        applyFilters.setTitle("Apply Filters", for: .normal)
        applyFilters.addTarget(self, action: #selector(applyFilter), for: .touchUpInside)
        applyFilters.backgroundColor = .blue
        applyFilters.layer.cornerRadius = 10
        applyFilters.layer.masksToBounds = true
        applyFilters.setTitleColor(.white, for: .normal)
        
        setupCategories()
        
        view.addSubview(locationLabel)
        view.addSubview(location)
        view.addSubview(distanceLabel)
        view.addSubview(distance)
        view.addSubview(categoriesLabel)
        view.addSubview(dismissButton)
        view.addSubview(applyFilters)
        
        layoutConstraints()
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    func layoutConstraints() {
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        location.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distance.translatesAutoresizingMaskIntoConstraints = false
        categoriesLabel.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        
        [
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            dismissButton.widthAnchor.constraint(equalToConstant: 30),
            dismissButton.heightAnchor.constraint(equalToConstant: 30),
            
            locationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            locationLabel.heightAnchor.constraint(equalToConstant: 40),
            
            location.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5),
            location.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            location.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            location.heightAnchor.constraint(equalToConstant: 40),
            
            distanceLabel.topAnchor.constraint(equalTo: location.bottomAnchor, constant: 20),
            distanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            distanceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            distanceLabel.heightAnchor.constraint(equalToConstant: 40),
            
            distance.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 5),
            distance.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            distance.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            distance.heightAnchor.constraint(equalToConstant: 40),
            
            categoriesLabel.topAnchor.constraint(equalTo: distance.bottomAnchor, constant: 20),
            categoriesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            categoriesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            categoriesLabel.heightAnchor.constraint(equalToConstant: 40),
            
        ].forEach { $0.isActive = true }
    }
    
    func setupCategories() {
        var counter: CGFloat = 5
        var i = 0
        for cat in categories {
            let button = UIButton(frame: CGRect(x: 25, y: 350 + counter, width: 20, height: 20))
            button.tag = i
            let label = UILabel(frame: CGRect(x: button.frame.maxX + 5, y: 350 + counter, width: view.frame.size.width/2, height: 20))
            label.text = cat
            button.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
            button.addTarget(self, action: #selector(didTapCategory(sender:)), for: .touchUpInside)
            counter += 30
            filterButtons.append(button)
            view.addSubview(button)
            view.addSubview(label)
            i+=1
        }
        applyFilters.frame = CGRect(x: view.frame.size.width/4, y: 350 + counter + 20, width: view.frame.size.width/2, height: 40)
    }
    
    @objc func didTapCategory(sender: UIButton) {
        var categoryButton = UIButton()
        categoryButton = filterButtons[sender.tag]
        if categoryButton.currentBackgroundImage == UIImage(systemName: "square") {
            categoryButton.setBackgroundImage(UIImage(systemName: "checkmark.square"), for: .normal)
            filters.append(categories[sender.tag])
        } else {
            categoryButton.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
            filters.removeAll(where: { $0 == categories[sender.tag] })
        }
        
    }
    
    @objc func didTapDismiss() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func applyFilter() {
        appliedFilters.categories = filters
        appliedFilters.radius = Int(distance.value.rounded())
        delegate.didApplyFilters(filters: appliedFilters)
        navigationController?.popViewController(animated: true)
    }
    
}
