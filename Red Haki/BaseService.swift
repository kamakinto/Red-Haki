//
//  BaseService.swift
//  Red Haki
//
//  Created by Everett Robinson on 4/9/16.
//  Copyright © 2016 Everett Robinson. All rights reserved.
//

import Foundation
import Firebase
import GeoFire


//MARK: Firebase settings
let BASE_URL = "https://red-haki.firebaseio.com/"
let FIREBASE_REF = Firebase(url: BASE_URL)

var CURRENT_USER: Firebase{
    let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
    let currentUser = Firebase(url: "\(FIREBASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
    
    return currentUser!
}

var CURRENT_USER_STATUS: Firebase{
    let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
    let currentUserStatus = Firebase(url: "\(FIREBASE_REF)").childByAppendingPath("statuses").childByAppendingPath(userID)
    
    return currentUserStatus!
}

//MARK: Geofire Settings
let GEOFIRE_REF = FIREBASE_REF
let GEOFIRE = GeoFire(firebaseRef: GEOFIRE_REF.childByAppendingPath("user_locations"))

let geo_user = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String



//let query = GEOFIRE.queryAtLocation(LocationService.sharedInstance.currentCLLocation, withRadius: 5.0)
//var queryHandle = query.observeEventType(.KeyEntered, withBlock: { (key: String!, location: CLLocation!) in
//    print("Key '\(key)' entered the search area and is at location '\(location)'")
//})

//MARK: time and date settings

var Timestamp: String {
    return "\(NSDate().timeIntervalSince1970 * 1000)"
}




