//
//  WatchMyBackViewController.swift
//  Red Haki
//
//  Created by Everett Robinson on 4/13/16.
//  Copyright © 2016 Everett Robinson. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}
class WatchMyBackViewController: UIViewController{
    
    let messageComposer = MessageComposer()
    var resultSearchController:UISearchController? = nil
    var selectedPin: MKPlacemark? = nil
    var destLong: Double = 0.0
    var destLat: Double? = 0.0
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var watchMyBackButton: UIButton!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var safeButton: UIButton!
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = MKUserTrackingMode.Follow
        self.safeButton.hidden = true
        self.watchMyBackButton.enabled = false
            
            if WMBUserStatus.sharedInstance.walkingHome {
               self.safeButton.hidden = false
            }
        
            
        let locationSearchTable = storyboard!.instantiateViewControllerWithIdentifier("LocationSearchTable") as! LocationSearchTable
            resultSearchController = UISearchController(searchResultsController: locationSearchTable)
            resultSearchController?.searchResultsUpdater = locationSearchTable
            
            let searchBar = resultSearchController!.searchBar
            searchBar.sizeToFit()
            searchBar.placeholder = "type your destination"
            navigationItem.titleView = resultSearchController?.searchBar
            resultSearchController?.hidesNavigationBarDuringPresentation = false
            resultSearchController?.dimsBackgroundDuringPresentation = true
            definesPresentationContext = true
            
            locationSearchTable.mapView = mapView
            
            locationSearchTable.handleMapSearchDelegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        //check if WMB is turned on. If so: 
        //get the destination, and current location to set up map
        //display the clear button - clears annotations, allows them to pick another destination
        //display the I am safe now button - stops the firebase tracking
        
        if WMBUserStatus.sharedInstance.walkingHome{
            let lat = WMBUserStatus.sharedInstance.destLat
            let long = WMBUserStatus.sharedInstance.destLong
            
            let anno = MyAnnotation(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long ), title: "Test Anno", subtitle: "Info")
            mapView.addAnnotation(anno)
            
            //display clear button to remove annotations
            //display the i am safe now button
            }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Action Buttons
    @IBAction func watchMyBackButton(sender: AnyObject) {
        let long = LocationService.sharedInstance.longitude
        let lat = LocationService.sharedInstance.latitude
        
        //configure data and start geolocation
        WMBUserStatus.sharedInstance.updateUserStatus("Watch My Back", desc: "Going Home", date: Timestamp, longitude: long, latitude: lat, destLong: destLong, destLat: destLat!, mediaUrl: "Https://", walkingHome: true)
        
        let wmbStatusUpdate = WMBUserStatus.sharedInstance.toJson()
    
        CURRENT_USER_STATUS_WMB.setValue(wmbStatusUpdate)
        
        //generate link to send in text message
        //Send Text Message
        if(messageComposer.canSendText()){
            let messageComposeVC = messageComposer.configuredMessageComposeViewController()
            presentViewController(messageComposeVC, animated: true, completion: nil)
        } else {
            
            let errorAlert = UIAlertView(title: "Cannot Send Text Message",
                                         message: "Your device is not able to send text messages.",
                                         delegate: self, cancelButtonTitle: "OK")
        }
    }

    
    @IBAction func safeButton(sender: AnyObject) {
        
        //add logic to stop tracking in firebase
    }
    
}

extension WatchMyBackViewController: HandleMapSearch {
    
    func dropPinZoomIn(placemark:MKPlacemark){
        //cache the pin
        selectedPin = placemark
        destLong = (selectedPin?.coordinate.longitude)!
        destLat = (selectedPin?.coordinate.longitude)!
        
        //clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
        
        //set pin location in user details
        //push destination to firebase
        //unhide the watch my back button
        self.watchMyBackButton.enabled = true
        
    }
    
    
    
    
    
}

