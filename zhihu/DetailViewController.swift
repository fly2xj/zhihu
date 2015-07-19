//
//  DetailViewController.swift
//  zhihu
//
//  Created by shawn on 15/7/18.
//  Copyright (c) 2015年 shawn. All rights reserved.
//

import UIKit
import SwiftyJSON


class DetailViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var url: NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.hidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
