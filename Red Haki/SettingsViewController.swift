//
//  SettingsViewController.swift
//  Red Haki
//
//  Created by Everett Robinson on 4/7/16.
//  Copyright © 2016 Everett Robinson. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UITableViewController{
    var names = [String]()
    var identities = [String]()
    var subtitles = [String]()
    
    
    override func viewDidLoad() {
        names = ["User Profile","Cloud Storage","Misc"]
        identities = ["User Profile","Cloud Storage", "Misc"]
        subtitles = ["Edit your user settings", "manage cloud storage", "other"]
        
}
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vcName = identities[indexPath.row]
        let viewController = storyboard?.instantiateViewControllerWithIdentifier(vcName)
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Settings")
       cell?.textLabel?.text = names[indexPath.row]
        return cell!
    }
    
    
}