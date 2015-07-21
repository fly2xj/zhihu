//
//  DetailViewController.swift
//  zhihu
//
//  Created by shawn on 15/7/18.
//  Copyright (c) 2015年 shawn. All rights reserved.
//

import UIKit
import SwiftyJSON


class DetailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    var url: NSURL?
    var thumb: UIImage = UIImage(named: "bg.jpg")!
    var caption: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.scrollView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        let imageview = UIImageView(frame: CGRectMake(0, -100, 600, 300))
        imageview.image = thumb
        imageview.contentMode = UIViewContentMode.ScaleAspectFill
        imageview.clipsToBounds = true
        webView.scrollView.addSubview(imageview)
        
        let shadowview = UIImageView(frame: CGRectMake(0, -100, 600, 300))
        shadowview.image = UIImage(named: "shadow.png")
        shadowview.contentMode = UIViewContentMode.ScaleAspectFill
        shadowview.clipsToBounds = true
        webView.scrollView.addSubview(shadowview)
        
        
        if caption != nil {
            let label = UILabel(frame: CGRectMake(20, 130, 300, 50))
            label.font = UIFont.boldSystemFontOfSize(20)
            label.textColor = UIColor.whiteColor()
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.ByCharWrapping
            label.text = caption
            webView.scrollView.addSubview(label)
        }
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if url != nil {
            if let data = NSData(contentsOfURL: url!) {
                let json = JSON(data: data)
                if let body = json["body"].string,
                    let css = json["css"][0].string {
                        let html = "<link href='\(css)' rel='stylesheet' type='text/css' />\(body)"
                        webView?.loadHTMLString(html, baseURL: nil)
                }
            }
//            let request = NSURLRequest(URL: url!)
//            webView?.loadRequest(request)
        }
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        webView.scrollView.delegate = nil
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        if offset >= 180 {
            UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        } else  {
            UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        }
    }
}
