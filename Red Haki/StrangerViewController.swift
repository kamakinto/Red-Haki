//
//  StrangerViewController.swift
//  Red Haki
//
//  Created by Everett Robinson on 4/8/16.
//  Copyright © 2016 Everett Robinson. All rights reserved.
//

import UIKit

class StrangerViewController: UIViewController, UIPickerViewDelegate {
    @IBOutlet weak var quickStatusUILabel: UILabel!
    @IBOutlet weak var statusPickerUIPicker: UIPickerView!
    @IBOutlet weak var detailsTextView: UITextView!
    var statusPicked: String = ""
    var strangerOptions = ["Followed", "Verbally assaulted", "Physically assaulted"]
    
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
       return strangerOptions.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return strangerOptions[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(strangerOptions[row])
        statusPicked = strangerOptions[row]
    }
    @IBAction func notifyButton(sender: AnyObject) {
        let problem = statusPicked
        let description = detailsTextView.text
        print("\(problem), here is what happened:\(description)")
        
    }
    
}

