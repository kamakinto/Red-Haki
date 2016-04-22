//
//  CloudSettingsViewController.swift
//  Red Haki
//
//  Created by Everett Robinson on 4/20/16.
//  Copyright © 2016 Everett Robinson. All rights reserved.
//

import UIKit
import SwiftyDropbox

class CloudSettingsViewController: UIViewController {
    
    @IBOutlet weak var dropboxButton: UIButton!
    
    override func viewDidLoad() {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if Dropbox.authorizedClient != nil{
            dropboxButton.setTitle("Log Out Dropbox", forState: .Normal)
        }else{
            dropboxButton.setTitle("Log In DropBox", forState: .Normal)
        }
    }
    
    
    
    @IBAction func dropboxButton(sender: AnyObject) {
        
        if Dropbox.authorizedClient != nil{
            Dropbox.unlinkClient()
            dropboxButton.setTitle("Log In DropBox", forState: .Normal)
            
        }else{
          Dropbox.authorizeFromController(self)
            dropboxButton.setTitle("Log Out Dropbox", forState: .Normal)
        }
        
        
        
    }
    
    
}