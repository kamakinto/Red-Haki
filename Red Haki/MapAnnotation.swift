//
//  MapAnnotation.swift
//  Red Haki
//
//  Created by Everett Robinson on 4/10/16.
//  Copyright © 2016 Everett Robinson. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class MyAnnotation : NSObject, MKAnnotation {
    dynamic var coordinate : CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var key: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String){
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
    }
    
    init(key: String){
        self.key = key
        self.coordinate = CLLocationCoordinate2D(latitude: 0.000, longitude: 0.000)
    }
}
