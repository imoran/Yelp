//
//  DetailsViewController.swift
//  Yelp
//
//  Created by Isis  on 2/5/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var restaurantLabel: UILabel!
    
    var business: Business!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantLabel.text = business.name
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
