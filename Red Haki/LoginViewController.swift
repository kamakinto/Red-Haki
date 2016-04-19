//
//  LoginViewController.swift
//  Red Haki
//
//  Created by Everett Robinson on 4/9/16.
//  Copyright © 2016 Everett Robinson. All rights reserved.
//

import UIKit
import Firebase


class LoginViewController: UIViewController{
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && CURRENT_USER.authData != nil{
            self.setUserData(CURRENT_USER.authData)
            self.pushToHomeScreen()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginButton(sender: AnyObject) {
        //add authentication code here
        
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
        
        if email != "" && password != ""
        {
            FIREBASE_REF.authUser(email, password: password, withCompletionBlock: { (error, authData) -> Void in
                if error == nil
                {
                   self.setUserData(authData)
                    print( "from user data \(UserData.sharedInstance.first_name)")
                   self.pushToHomeScreen()
                    
                } else {
                    print(error)
                }
            })
        } else {
            
            let alert = UIAlertController(title: "Error", message: "Enter Email and Password.", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
    func logout(){
        CURRENT_USER.unauth()
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
    }
    
    func pushToHomeScreen(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBarController
    }
    
    func setUserData(authData: FAuthData!){
        NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
        
        CURRENT_USER.observeSingleEventOfType(.Value, withBlock:{snapshot in
            print(snapshot.value)
            UserData.sharedInstance.setUserData(authData.uid, snapshot: snapshot)
        })
    }

    /*
    // MARK: - Navigation
     
     

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
