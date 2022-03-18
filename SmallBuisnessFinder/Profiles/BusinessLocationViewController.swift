//
//  BusinessLocationViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/9/22.
//

import UIKit
import MapKit

class BusinessLocationViewController: UIViewController {
    
    var dismissButton = UIButton()
    
    var mapView = MKMapView()
//    var location = MKMapItem()
    
    var coords : CLLocationCoordinate2D!
    
    var name = String()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        dismissButton.addTarget(self, action: #selector(dismissed), for: .touchUpInside)
        dismissButton.frame = CGRect(x: 10, y: 75, width: 30, height: 30)
        dismissButton.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        
        
        
        mapView.centerCoordinate = coords
        mapView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        //let placemark = MKPlacemark(coordinate: coords)
        //mapView.addAnnotation(placemark)
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.title = name
        pointAnnotation.coordinate = coords
        mapView.addAnnotation(pointAnnotation)
        
        let regionRadius : CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(
            center: coords,
            latitudinalMeters: regionRadius * 2.0,
            longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
        view.addSubview(mapView)
        view.addSubview(dismissButton)
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func dismissed() {
        self.dismiss(animated: true, completion: nil)
    }
    

}
