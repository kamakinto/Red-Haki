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
    
    
    override func viewDidLoad() {
        
    }
    
    
    
    @IBAction func dropboxButton(sender: AnyObject) {
        
        Dropbox.authorizeFromController(self)
        
    }
    
    
}