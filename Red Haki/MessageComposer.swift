//
//  MessageComposer.swift
//  Red Haki
//
//  Created by Everett Robinson on 4/13/16.
//  Copyright © 2016 Everett Robinson. All rights reserved.
//

import Foundation
import MessageUI

let textMessageRecipients = ["enter recipeints numbers in here as an array of strings. ex: [+1 803 327 3370, +33 06 41 23 43 84]"]
class MessageComposer: NSObject, MFMessageComposeViewControllerDelegate {
   
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }

    func configuredMessageComposeViewController() -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self
        //messageComposeVC.recipients = textMessageRecipients
        messageComposeVC.body = "Hey! so I'm walking home, come walk with me by clicking this link!"
        return messageComposeVC
    }
    
    //dismisses the view controller when the user is finished with 
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }


}







