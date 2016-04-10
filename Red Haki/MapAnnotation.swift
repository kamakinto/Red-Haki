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
    var title: String!
    var subtitle: String!
    
    init(title: String, coordinate: CLLocationCoordinate2D, subtitle: String){
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
    }
}
