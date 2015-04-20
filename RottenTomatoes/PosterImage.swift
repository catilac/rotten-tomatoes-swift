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
        let lowResURL = NSURL(string: posters["detailed"] as! String)!
        let lowResURLRequest = NSURLRequest(URL: lowResURL, cachePolicy: .ReturnCacheDataElseLoad, timeoutInterval: 1)
        
        setImageWithURLRequest(lowResURLRequest, placeholderImage: self.image, success: { (req, resp, img) -> Void in
            self.image = img
            self.fadeIn()
            
            var urlString = posters["original"] as! String
            urlString = self.switchCDN(urlString)
            
            let highResURL = NSURL(string: urlString)!
            let highResURLRequest = NSURLRequest(URL: highResURL, cachePolicy: .ReturnCacheDataElseLoad, timeoutInterval: 1)
            self.setImageWithURLRequest(highResURLRequest, placeholderImage: img, success: { (req, resp, largeImage) -> Void in
                self.image = largeImage
            }, failure: nil)
        }, failure: nil)
    }
    
    func fadeIn() {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.alpha = 1.0
        })
    }
    
    private func switchCDN(url: String) -> String {
        var range = url.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
        if let range = range {
            return url.stringByReplacingCharactersInRange(range, withString: "https://content6.flixster.com/")
        }
        return url
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
