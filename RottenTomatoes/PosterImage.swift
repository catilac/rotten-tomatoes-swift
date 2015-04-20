//
//  PosterImage.swift
//  RottenTomatoes
//
//  Created by Chirag Davé on 4/19/15.
//  Copyright (c) 2015 Chirag Davé. All rights reserved.
//

import UIKit

class PosterImage: UIImageView {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        alpha = 0.0
    }
    
    func setPosterImage(posters: NSDictionary) {
        println(posters)
        let lowResURL = NSURL(string: posters["detailed"] as! String)!
        let lowResURLRequest = NSURLRequest(URL: lowResURL)

        setImageWithURLRequest(lowResURLRequest, placeholderImage: self.image, success: { (req, resp, img) -> Void in
            self.image = img
            self.fadeIn()
            var urlString = posters["original"] as! String
            var range = urlString.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
            if let range = range {
                urlString = urlString.stringByReplacingCharactersInRange(range, withString: "https://content6.flixster.com/")
            }
            let highResURL = NSURL(string: urlString)
            self.setImageWithURL(highResURL, placeholderImage: img)
        }, failure: nil)
    }
    
    func fadeIn() {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.alpha = 1.0
        })
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
