//
//  LookAroundViewController.swift
//  Red Haki
//
//  Created by Everett Robinson on 4/7/16.
//  Copyright © 2016 Everett Robinson. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Firebase

// LOOK AT THE OFFICE MOVER PROJECT, IN THE ROOMSYNC.SWIFT FILE TO MIMIC HOW TO HANDLE CHANGES IN GEOLOCATION OF USER
class LookAroundViewController: UIViewController {
    var queryHandle: UInt!
    
   
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var safetyStatusSwitch: UISwitch!
    @IBOutlet weak var safetyStatusLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    let geofireUserKey = UserData.sharedInstance.uid
    var Lat = LocationService.sharedInstance.latitude
    var Long = LocationService.sharedInstance.longitude
    mapView.showsUserLocation = true
    mapView.userTrackingMode = MKUserTrackingMode.Follow
        
    //Set location needs to keep fireing as the User moves, and their status is set to"unsafe"
    GEOFIRE.setLocation(CLLocation(latitude: Lat, longitude: Long), forKey: geofireUserKey) { (error) in
            if (error != nil) {
                print("An error occured: \(error)")
            } else {
                print("Saved location successfully!")
            }
        }
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    //Set Geofire Listener
        let query = GEOFIRE.queryAtLocation(LocationService.sharedInstance.currentCLLocation, withRadius: 5.0)
         queryHandle = query.observeEventType(.KeyMoved, withBlock: { (key: String!, location: CLLocation!) in
            print("Key '\(key)' moved in the search area and is at location '\(location)'")
        })
        
    //Set user safety switch
        if UserData.sharedInstance.status_flag {
            safetyStatusLabel.text = "Safe"
            safetyStatusSwitch.setOn(false, animated: false)
        }else{
            safetyStatusLabel.text = "Not Safe"
            safetyStatusSwitch.setOn(true, animated: false)
        }
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        GEOFIRE_REF.removeObserverWithHandle(queryHandle)
    }
    
    @IBAction func safetySwitchButton(sender: AnyObject) {
        //change state of safety label
        if safetyStatusSwitch.on{
            safetyStatusLabel.text = "Not Safe"
        }else{
            safetyStatusLabel.text = "Safe"
        }
        //stop sending location to firebase
        //change state on local user value status_flag
        //if it the type was "following", alert loved ones you are fine
        //(If Possible) change color of the map marker back to the normal blue
    }
    
}
