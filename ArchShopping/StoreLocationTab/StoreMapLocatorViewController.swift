//
//  StoreMapLocatorViewController.swift
//  ArchShopping
//
//  Created by Chetan Melkote nagaraj on 12/5/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class StoreMapLocatorViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func close(_ sender: Any) {
        presentingViewController?.dismiss(animated: true)
    }
    var selectedLocation : LocationModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        var poiCoodinates = CLLocationCoordinate2D()
        
        poiCoodinates.latitude = CDouble(self.selectedLocation!.storeLatitude!)!
        poiCoodinates.longitude = CDouble(self.selectedLocation!.storeLongitude!)!
        let viewRegion = MKCoordinateRegion.init(center: poiCoodinates, latitudinalMeters: 500, longitudinalMeters: 500)
        
        self.mapView.setRegion(viewRegion, animated: true)
        let pin: MKPointAnnotation = MKPointAnnotation()
        pin.coordinate = poiCoodinates
        self.mapView.addAnnotation(pin)
        
        pin.title = selectedLocation!.storeAddress
        
    }
    
}
