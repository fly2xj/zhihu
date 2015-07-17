//
//  ViewController.swift
//  zhihu
//
//  Created by shawn on 15/7/18.
//  Copyright (c) 2015年 shawn. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var stories: JSON?
    var top_stories: JSON?
    
    struct URL {
        static let latest = "http://news-at.zhihu.com/api/4/stories/latest?client=0"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Today"
        loadStories()
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    override func viewWillDisappear(animated: Bool) {
        tableView?.dataSource = nil
        tableView?.delegate = nil
    }
    override func viewDidAppear(animated: Bool) {
        if let bar = navigationController?.navigationBar {
            bar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            bar.shadowImage = UIImage()
            bar.translucent = true
            bar.tintColor = UIColor.whiteColor();
            bar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }
    
    func loadStories() {
        
        if let storiesUrl = NSURL(string: URL.latest),
            let data = NSData(contentsOfURL: storiesUrl){
                let json = JSON(data: data)
                stories = json["stories"]
                top_stories = json["top_stories"]
                
                if let imageUrl = json["top_stories"][0]["image"].string,
                    let imageData = NSData(contentsOfURL: NSURL(string: imageUrl)!) {
                        imageView.image = UIImage(data: imageData)
                }
                
        }
        /*
        if let data = NSString(contentsOfURL: NSURL(string: URL.latest)!, encoding: NSUTF8StringEncoding, error: nil){
            if let json = JSON(data) {
                if let imageURL = json["stories"][0]["images"][0] {
                    if let imageData = NSData(contentsOfURL: imageURL) {
                        imageView.image = UIImage(data: imageData)
                    }
                }
            }
        }*/
        
    }

    // MARK : datasource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = stories?.count {
            return count
        } else {
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? UITableViewCell {
            if let text = stories?[indexPath.row]["title"].string {
                cell.textLabel?.text = text
            }

            return cell
        }
        return UITableViewCell()
    }

}

