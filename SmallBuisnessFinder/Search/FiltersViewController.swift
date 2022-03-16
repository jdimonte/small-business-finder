//
//  FiltersViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/14/22.
//

import UIKit
 
class FiltersViewController: UIViewController {
    
    var locationLabel = UILabel()
    var location = UITextView()
    var distanceLabel = UILabel()
    var distance = UISlider()
    var categoriesLabel = UILabel()
    var categories = ["Clothing", "General", "Grocery", "Trinkets", "Restaurant"]
    var dismissButton = UIButton()
    var applyFilters = UIButton()
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
 
        locationLabel.text = "Location"
        locationLabel.textColor = .black
        locationLabel.font = .boldSystemFont(ofSize: 20)
        
        distanceLabel.text = "Radius"
        distanceLabel.textColor = .black
        distanceLabel.font = .boldSystemFont(ofSize: 20)
        
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
        for cat in categories {
            let button = UIButton(frame: CGRect(x: 25, y: 350 + counter, width: 20, height: 20))
            let label = UILabel(frame: CGRect(x: button.frame.maxX + 5, y: 350 + counter, width: view.frame.size.width/2, height: 20))
            label.text = cat
            button.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
            button.addTarget(self, action: #selector(didTapCategory), for: .touchUpInside)
            counter += 30
            view.addSubview(button)
            view.addSubview(label)
            
            
        }
        
        applyFilters.frame = CGRect(x: view.frame.size.width/4, y: 350 + counter + 20, width: view.frame.size.width/2, height: 40)
    }
    
    @objc func didTapCategory() {
        
    }
    
    @objc func didTapDismiss() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func applyFilter() {
        navigationController?.popViewController(animated: true)
    }
    
}
