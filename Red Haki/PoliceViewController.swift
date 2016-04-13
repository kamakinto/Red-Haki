//
//  PoliceViewController.swift
//  Red Haki
//
//  Created by Everett Robinson on 4/8/16.
//  Copyright © 2016 Everett Robinson. All rights reserved.
//

import UIKit

class PoliceViewController: UIViewController, UIPickerViewDelegate{
    @IBOutlet weak var policePicker: UIPickerView!
    @IBOutlet weak var policeDescText: UITextView!
    @IBOutlet weak var policeNotifyButton: UIButton!
    
    var policePicked = ""
    var policeOptions = ["Followed", "Verbally assaulted", "Physically assaulted"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return policeOptions.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return policeOptions[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(policeOptions[row])
        policePicked = policeOptions[row]

    
    
}

    @IBAction func policeButton(sender: AnyObject) {
        let problem = policePicked
        let description = policeDescText.text
        let longitude = LocationService.sharedInstance.longitude
        let latitude = LocationService.sharedInstance.latitude

        //configure data to send
        UserStatus.sharedInstance.updateUserStatus("police", type: problem, desc: description, date: Timestamp, longitude: longitude, latitude: latitude, mediaUrl: "https://")
        UserData.sharedInstance.status_flag = true
        let statusUpdate = UserStatus.sharedInstance.toJson()
        CURRENT_USER_STATUS.setValue(statusUpdate)
        
        // navigate to look around tab
        tabBarController?.selectedIndex = 1
        tabBarController?.tabBar.hidden = false
        self.navigationController?.popToRootViewControllerAnimated(false)
    
        
    }
   }