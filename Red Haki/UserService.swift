//
//  UserService.swift
//  Red Haki
//
//  Created by Everett Robinson on 4/9/16.
//  Copyright © 2016 Everett Robinson. All rights reserved.
//

import Foundation
import UIKit
import Firebase



class UserData {
    public static let sharedInstance = UserData()
    
    
    var uid: String = ""
    var username: String = ""
    var status_flag: Bool = false //false = safe
    var first_name: String = ""
    var last_name: String = ""
    var sex: String = ""
    var dob: String = ""
    
    
    func setUserData(uid: String, snapshot: FDataSnapshot) {
    //change snapshot into regular json
    let json = snapshot.value as! Dictionary<String, AnyObject>
        
    //set singleton values
        self.uid = uid
        self.username = json["username"] as? String ?? ""
        self.status_flag = json["status_flag"] as? Bool ?? false
        self.first_name = json["first_name"] as? String ?? ""
        self.last_name = json["last_name"] as? String ?? ""
        self.sex = json["sex"] as? String ?? ""
        self.dob = json["date_of_birth"] as? String ?? ""
}
    func toJson() -> Dictionary<String, AnyObject> {
      return [
        "username" : self.username,
        "status_flag" : self.status_flag,
        "first_name" : self.first_name,
        "last_name" : self.last_name,
        "sex" : self.sex,
        "date_of_birth" : self.dob,
        ];
    }

}

class UserStatus{
    public static let sharedInstance = UserStatus()
    var section: String = ""
    var type: String = ""
    var desc: String = ""
    var date: String = ""
    var longitude: Double = -1
    var latitude: Double = -1
    var media_url: String = ""
    
    func setUserStatusData(snapshot: FDataSnapshot){
        let json = snapshot.value as! Dictionary<String, AnyObject>
        self.section = json["section"] as? String ?? ""
        self.type = json["type"] as? String ?? ""
        self.desc = json["desc"] as? String ?? ""
        self.date = json["date"] as? String ?? ""
        self.longitude = json["longitude"] as? Double ?? -1
        self.latitude = json["latitude"] as? Double ?? -1
        self.media_url = json["media_url"] as? String ?? "https://"
        
        
    }
    func toJson() -> Dictionary<String, AnyObject> {
        return [
            "section" : self.section,
            "type" : self.type,
            "desc" : self.desc,
            "date" : self.date,
            "longitude" : self.longitude,
            "latitude" : self.latitude,
            "media_url" : self.media_url,
        ];
    }
    
    func updateUserStatus(section: String, type: String, desc: String, date: String, longitude: Double, latitude: Double, mediaUrl: String){
        self.section = section
        self.type = type
        self.desc = desc
        self.date = date
        self.longitude = longitude
        self.latitude = latitude
        self.media_url = mediaUrl
    }
    
    func updateUserStatus(longitude: Double, latitude: Double){
        self.longitude = longitude
        self.latitude = latitude
        }
    
}
