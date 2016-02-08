//
//  DetailsViewController.swift
//  Yelp
//
//  Created by Isis  on 2/5/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var foodCategoryLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var business: Business!
    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantLabel.text = business.name
        addressLabel.text = business.address
        foodCategoryLabel.text = business.categories
        
        let centerLocation = CLLocation(latitude: 37.7833, longitude: -122.4167)
        goToLocation(centerLocation)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
