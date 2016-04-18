//
//  LocationService.swift
//  Red Haki
//
//  Created by Everett Robinson on 4/9/16.
//  Copyright © 2016 Everett Robinson. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService:NSObject, CLLocationManagerDelegate {
    public static let sharedInstance = LocationService()
    
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocationCoordinate2D?
    var longitude: Double = -1
    var latitude: Double = -1
    var currentCLLocation: CLLocation?
    
    override init(){
        super.init()
        self.locationManager = CLLocationManager()
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager?.delegate = self
        self.locationManager?.requestAlwaysAuthorization()
    }
    
    func startUpdatingLocation(){
        print("Starting Location Updates")
        self.locationManager?.startUpdatingLocation()
    }
  
    func stopUpdatingLocation(){
        print("Stop Location Updates")
        self.locationManager?.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocationCoordinate2D = manager.location!.coordinate
        self.currentLocation = location
        self.currentCLLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
      
        //use for real time update location
        updateLocation(self.currentLocation!)
        
        if UserData.sharedInstance.status_flag {
            updateFirebaseLocation()
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Update Location Error: \(error.description)")
    }
    
    func updateLocation(currentLocation: CLLocationCoordinate2D) {
       self.latitude = currentLocation.latitude
        self.longitude = currentLocation.longitude
    }
    
    func updateFirebaseLocation(){
      //send update to firebase with log and lat
        var loc = ["longitude": self.longitude,
                   "latitude" : self.latitude]
        CURRENT_USER_STATUS.updateChildValues(loc)
    
        //send update to geofire with new location
        GEOFIRE.setLocation(currentCLLocation, forKey: geo_user) { (error) in
            if (error != nil) {
                print("An error occured: \(error)")
            } else {
                print("you are unsafe. user_stats = true")
            }
        }
    }
    
    
}
    


