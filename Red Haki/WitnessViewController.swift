//
//  WitnessViewController.swift
//  Red Haki
//
//  Created by Everett Robinson on 4/20/16.
//  Copyright © 2016 Everett Robinson. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVKit
import AVFoundation
import SwiftyDropbox

class WitnessViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    let saveFileName = "/Incident-Recording-\(Timestamp).mp4"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.darkGrayColor()
        if (Dropbox.authorizedClient != nil) {
            self.progressBar.hidden = true
            self.progressLabel.hidden = true
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func recordButton(sender: AnyObject) {
        
        if(UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                imagePicker.sourceType = .Camera
                imagePicker.mediaTypes = [kUTTypeMovie as String]
                imagePicker.allowsEditing = false
                imagePicker.delegate = self
                
                
                presentViewController(imagePicker, animated: true, completion: {})
           }else{
                postAlert("Rear camera doesnt exist", message: "Application cannot access the camera")
            }
        }
        
}
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("Got a video")
        
        if let pickedVideo:NSURL = (info[UIImagePickerControllerMediaURL] as? NSURL) {
            
            // Save video to the main photo album
            let selectorToCall = Selector("videoWasSavedSuccessfully:didFinishSavingWithError:context:")
            UISaveVideoAtPathToSavedPhotosAlbum(pickedVideo.relativePath!, self, selectorToCall, nil)
            
            // Save the video to the app directory so we can play it later
            let videoData = NSData(contentsOfURL: pickedVideo)
            let paths = NSSearchPathForDirectoriesInDomains(
                NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            let documentsDirectory: AnyObject = paths[0]
            let dataPath = documentsDirectory.stringByAppendingPathComponent(saveFileName)
            videoData?.writeToFile(dataPath, atomically: false)
            
            
        }
        
        imagePicker.dismissViewControllerAnimated(true, completion: {
            // Anything you want to happen when the user saves an video
        })
    }
  
    
    // Called when the user selects cancel
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("User canceled image")
        dismissViewControllerAnimated(true, completion: {
            // Anything you want to happen when the user selects cancel
        })
    }
    
    // Any tasks you want to perform after recording a video
    func videoWasSavedSuccessfully(video: String, didFinishSavingWithError error: NSError!, context: UnsafeMutablePointer<()>){
        print("Video saved")
        if let theError = error {
            print("An error happened while saving the video = \(theError)")
        } else {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                // What you want to happen
                //save video to dropbox
                let paths = NSSearchPathForDirectoriesInDomains(
                    NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                let documentsDirectory: AnyObject = paths[0]
                let dataPath = documentsDirectory.stringByAppendingPathComponent(self.saveFileName)
                //self.pictureStatusLabel.text = "Picture was saved at: \(dataPath)"
                self.progressLabel.hidden = false
                self.progressLabel.text = "uploading..."
                self.progressBar.hidden = false
                self.uploadToDropbox(dataPath)
            })
        }
    }
    
    func uploadToDropbox(filePath: String!){
        //make sure they are logged in. if not, show label to log them into dropbox
        if let client = Dropbox.authorizedClient{
            let fileUrl = NSURL(string: filePath)
           
            client.files.upload(path: "/red-haki\(self.saveFileName)", mode: .Add, autorename: true, clientModified: nil, mute: false, body: fileUrl!).progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
                
                print("bytesRead: \(bytesRead)")
                print("totalBytesRead: \(totalBytesRead)")
                print("totalBytesExpectedToRead: \(totalBytesExpectedToRead)")
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                   // self.progressLabel.text = "\((totalBytesRead/totalBytesExpectedToRead) * 100)%"
                    self.progressBar.setProgress(Float(totalBytesRead)/Float(totalBytesExpectedToRead), animated: true)
                    self.progressLabel.text = "uploading..."
                    if totalBytesExpectedToRead == totalBytesRead {
                        self.progressBar.hidden = true
                        self.progressLabel.hidden = true
                    }
                    
                });
            }
            
                   
            
                
                        }
    }
    
    // MARK: Utility methods for app
    // Utility method to display an alert to the user.
    func postAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}
