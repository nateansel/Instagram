//
//  PhotosViewController.swift
//  Instagram
//
//  Created by Nathan Ansel on 1/30/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  var data: [Photo]?
  @IBOutlet weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    tableView.dataSource = self
    tableView.delegate   = self
    refreshData()
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return data?.count ?? 0
  }
  
  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
    headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
    
    let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
    profileView.clipsToBounds = true
    profileView.layer.cornerRadius = 15;
    profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
    profileView.layer.borderWidth = 1;
    
    // Use the section number to get the right URL
    profileView.setImageWithURL(data![section].profilePictureURL)
    
    headerView.addSubview(profileView)
    
    // Add a UILabel for the username here
    let usernameView = UILabel(frame: CGRect(x: 50, y: 10, width: 0, height: 0))
    usernameView.text = data![section].username
    usernameView.sizeToFit()
    
    headerView.addSubview(usernameView)
    
    return headerView
  }
  
  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("PhotoTableViewCell") as! PhotoTableViewCell
    cell.pictureView.setImageWithURL(data![indexPath.section].pictureURL)
    return cell
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return view.frame.size.width
  }
  
  
  // MARK: - Refresh & Save Data
  func refreshData() {
    let clientId = "e05c462ebd86446ea48a5af73769b602"
    let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
    let request = NSURLRequest(URL: url!)
    let session = NSURLSession(
      configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
      delegate:nil,
      delegateQueue:NSOperationQueue.mainQueue()
    )
    
    let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
      completionHandler: { (dataOrNil, response, error) in
        if let data = dataOrNil {
          if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
            data, options:[]) as? NSDictionary {
              self.data = self.parseJSONToPhotoObjects(responseDictionary)
              NSLog("response: \(responseDictionary)")
              self.tableView.reloadData()
          }
        }
    });
    task.resume()
  }
  
  
  func parseJSONToPhotoObjects(JSON: NSDictionary) -> [Photo] {
    var toReturn = [Photo]()
    for dict in JSON["data"] as! NSArray {
      let tempPhoto = Photo(dictionary: dict as! NSDictionary)
      toReturn.append(tempPhoto)
    }
    return toReturn
  }


}

