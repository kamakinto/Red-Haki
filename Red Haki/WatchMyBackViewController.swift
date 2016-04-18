//
//  WatchMyBackViewController.swift
//  Red Haki
//
//  Created by Everett Robinson on 4/13/16.
//  Copyright © 2016 Everett Robinson. All rights reserved.
//

import UIKit

class WatchMyBackViewController: UIViewController{
    let messageComposer = MessageComposer()
    
           override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Action Buttons
    @IBAction func watchMyBackButton(sender: AnyObject) {
        //Make sure the device can send text messages
        if(messageComposer.canSendText()){
            let messageComposeVC = messageComposer.configuredMessageComposeViewController()
            presentViewController(messageComposeVC, animated: true, completion: nil)
        } else {
            
            let errorAlert = UIAlertView(title: "Cannot Send Text Message",
                                         message: "Your device is not able to send text messages.",
                                         delegate: self, cancelButtonTitle: "OK")
        }
    }

    
    
}

