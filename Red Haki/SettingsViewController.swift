//
//  SettingsViewController.swift
//  Red Haki
//
//  Created by Everett Robinson on 4/7/16.
//  Copyright © 2016 Everett Robinson. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource {
    
    let settingsMenu1: [String] = ["Setting 1", "Setting 2", "Setting 3"]
    let settingsMenu2: [String] = ["Setting a", "Setting b"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Settings", forIndexPath: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = settingsMenu1[indexPath.row]
            cell.detailTextLabel?.text = "Test subtitles"
        }
        if indexPath.section == 1{
            cell.textLabel?.text = settingsMenu2[indexPath.row]
        }
        
        cell.textLabel?.text = settingsMenu1[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return settingsMenu1.count
        }
        
        return settingsMenu2.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "User Info"
        }
        return "Privacy"
    }
    
    
}

