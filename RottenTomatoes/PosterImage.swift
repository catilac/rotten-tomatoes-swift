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
