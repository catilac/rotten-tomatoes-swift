//
//  MessagePane.swift
//  RottenTomatoes
//
//  Created by Chirag Dave on 4/19/15.
//  Copyright (c) 2015 Chirag Davé. All rights reserved.
//

import UIKit

class MessagePane: UIView {
    
    var message = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        message.frame = CGRectMake(0, frame.origin.y + 25, frame.width, frame.height)
        message.textAlignment = NSTextAlignment.Center
        message.textColor = UIColor.whiteColor()
        message.backgroundColor = UIColor.clearColor()
        message.font = UIFont(name: "HelveticaNeue-Bold", size: 18.0)
        
        addSubview(message)
        backgroundColor = UIColor.redColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeMessage(text:String) {
        message.text = text
    }
    
    func removeMessage() {
        removeFromSuperview()
    }
    
    class func showMessage(superView: UIView, message: String) -> MessagePane {
        let messagePane = MessagePane(frame: CGRectMake(0, 0, superView.frame.width, 125))
        messagePane.changeMessage(message)
        superView.addSubview(messagePane)
        
        NSTimer.scheduledTimerWithTimeInterval(1.5, target: messagePane, selector: Selector("removeMessage"), userInfo: nil, repeats: false)
        
        return messagePane
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
