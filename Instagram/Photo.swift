//
//  Photo.swift
//  Pods
//
//  Created by Nathan Ansel on 1/30/16.
//
//

import Foundation

class Photo {
  
  var username:          String
  var pictureURL:        NSURL
  var profilePictureURL: NSURL
  
  init(username: String?, pictureURL: String?, profilePictureURL: String?) {
    self.username = username ?? ""
    if let s = pictureURL        { self.pictureURL        = NSURL(string: s) ?? NSURL() } else { self.pictureURL = NSURL() }
    if let s = profilePictureURL { self.profilePictureURL = NSURL(string: s) ?? NSURL() } else { self.profilePictureURL = NSURL() }
  }
  
  convenience init() {
    self.init(username: nil, pictureURL: nil, profilePictureURL: nil)
  }
  
  convenience init(dictionary: NSDictionary) {
    let uname = (dictionary["user"] as? NSDictionary)?["username"] as? String
    let ppURL = (dictionary["user"] as? NSDictionary)?["profile_picture"] as? String
    let tempD = (dictionary["images"]) as? NSDictionary
    let tempD2 = (tempD?["standard_resolution"]) as? NSDictionary
    let url = tempD2?["url"] as? String
    let pURL = ((dictionary["images"] as? NSDictionary)?["standard_resolution"] as? NSDictionary)?["url"] as? String
    
    self.init(username: uname, pictureURL: pURL, profilePictureURL: ppURL)
  }
}