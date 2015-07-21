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
        static let detail = "https://news-at.zhihu.com/api/3/news/"
    }
    
    struct identifiers {
        static let cell = "cell"
        static let detailSegue = "show content"
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
                
                print("\(stories)")
                if let imageUrl = json["top_stories"][0]["image"].string,
                    let imageData = NSData(contentsOfURL: NSURL(string: imageUrl)!) {
                        imageView.image = UIImage(data: imageData)
                        imageView.setNeedsLayout()
                        //imageView.superview?.bounds.height = imageView.image?.size.height
                }
                
        }
      
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
        if let cell = tableView.dequeueReusableCellWithIdentifier(identifiers.cell, forIndexPath: indexPath) as? SoriesTableViewCell {
            if let text = stories?[indexPath.row]["title"].string,
                let id = stories?[indexPath.row]["id"].int,
                let thumb = stories?[indexPath.row]["images"][0].string {
                    cell.contentText = text
                    cell.id = id
                    cell.thumbUrl = NSURL(string: thumb)
            }

            return cell
        }
        return UITableViewCell()
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 106
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == identifiers.detailSegue {
            if let navigation = segue.destinationViewController as? UINavigationController,
                let detailView = navigation.visibleViewController as? DetailViewController,
                let cell = sender as? SoriesTableViewCell {
                    detailView.url = NSURL(string: "\(URL.detail)\(cell.id)")
                    detailView.caption = cell.contentText
                    if cell.thumb.image != nil {
                        detailView.thumb = cell.thumb.image!
                    }
            }
        }
    }

}

