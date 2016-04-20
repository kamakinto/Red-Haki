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
class LookAroundViewController: UIViewController, MKMapViewDelegate {
    var queryHandle: UInt!
    var annotationsDict = [String: MyAnnotation]()
    
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
    
        
        //for loop. at the end of each loop, append the object
        for index in 0...5 {
            let long = Long + (0.0002 * Double(index))
            let lat = Lat + (0.0003 * Double(index))
            let anno = MyAnnotation(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long ), title: "Test Anno \(index)", subtitle: "Info \(index)")
            mapView.addAnnotation(anno)
        }

        
        //find a way to loop through that array, changing the locations of the points every time the users geolocation chanes.
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    //Set Geofire Listeners
        let query = GEOFIRE.queryAtLocation(LocationService.sharedInstance.currentCLLocation, withRadius: 5.0)
         queryHandle = query.observeEventType(.KeyMoved, withBlock: { (key: String!, location: CLLocation!) in
            self.annotationsDict[key]?.coordinate = location.coordinate
        })
        
        query.observeEventType(.KeyEntered, withBlock: { (key: String!, location: CLLocation!) in
            if key != geo_user{
                 self.addMapAnnotations(key, location: location)
            }
           
        })

        query.observeEventType(.KeyExited, withBlock: { (key: String!, location: CLLocation!) in
            if key != geo_user {
                self.mapView.removeAnnotation(self.annotationsDict[key]!)
                self.annotationsDict[key] = nil
            }
        })
        //Set user safety switch
        if !UserData.sharedInstance.status_flag {
            safetyStatusLabel.text = "Safe"
            safetyStatusSwitch.setOn(false, animated: false)
            
        }else{
            safetyStatusLabel.text = "Not Safe"
            safetyStatusSwitch.setOn(true, animated: false)
        }
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        GEOFIRE_REF.removeAllObservers()
    }
    
    func addMapAnnotations(key: String!, location: CLLocation){
        let annotation = MyAnnotation(key: key)
        //query firebase for stats on user status
        FIREBASE_REF.childByAppendingPath("statuses").childByAppendingPath(key).observeSingleEventOfType(.Value, withBlock: { snapshot in
            var json = snapshot.value as! Dictionary<String, AnyObject>
            var otherUserSection = json["section"] as? String ?? "unknown"
            var otherUserType = json["type"] as? String ?? "unknown"
            annotation.title = otherUserSection
            annotation.subtitle = otherUserType
        }, withCancelBlock: { error in
        print(error.description)
        })
        annotation.coordinate = location.coordinate
        self.mapView.addAnnotation(annotation)
        self.annotationsDict[key] = annotation
        
    }
    
    @IBAction func safetySwitchButton(sender: AnyObject) {
        //change state of safety label
        if safetyStatusSwitch.on{
            
            safetyStatusLabel.text = "Not Safe"
            
            //update firebase status
            let status_flag = ["status_flag": "true"]
            CURRENT_USER.updateChildValues(status_flag)
            
            //navigate them to the Not Safe view Controller
            tabBarController?.selectedIndex = 2
            tabBarController?.tabBar.hidden = false
            self.navigationController?.popToRootViewControllerAnimated(false)
                    }else{
            safetyStatusLabel.text = "Safe"
            GEOFIRE.removeKey(geo_user)
            //update firebase status
            let status_flag = ["status_flag": "false"]
            CURRENT_USER.updateChildValues(status_flag)
            //self.mapView.removeAnnotation(self.annotationsDict[geo_user]!)
            
            self.annotationsDict[geo_user] = nil
            UserData.sharedInstance.status_flag = false
        }
        //if it the type was "following", alert loved ones you are fine
        //(If Possible) change color of the map marker back to the normal blue
    }
    
}
