//
//  NotSafeViewController.swift
//  Red Haki
//
//  Created by Everett Robinson on 4/8/16.
//  Copyright © 2016 Everett Robinson. All rights reserved.
//

import Foundation
import UIKit

class NotSafeViewController: UITableViewController{
    var names = [String]()
    var identities = [String]()
    var subtitles = [String]()
    
    
    override func viewDidLoad() {
        names = ["Stranger","Police","Accident","Watch My Back","Other"]
        identities = ["Stranger", "Police", "Accident", "Watch My Back", "Other"]
        subtitles = ["You feel unsafe around a stranger", "You feel unsafe around the Police", "There has been an accident","Have a friend watch your back", "You feel unsafe"]
        self.view.backgroundColor = UIColor.darkGrayColor()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("notSafe")
        
        cell?.textLabel!.text = names[indexPath.row]
        cell?.detailTextLabel!.text = subtitles[indexPath.row]
        cell?.backgroundColor = UIColor.darkGrayColor()
        cell?.textLabel?.textColor = UIColor.whiteColor()
        cell?.detailTextLabel?.textColor = UIColor.whiteColor()
        return cell!
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vcName = identities[indexPath.row]
        let viewController = storyboard?.instantiateViewControllerWithIdentifier(vcName)
        self.navigationController?.pushViewController(viewController!, animated: true)
        
    }
    
    
}
