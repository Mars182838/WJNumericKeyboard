//
//  WJLineView.swift
//  WJNumericKeyboardDemo
//
//  Created by 俊王 on 16/6/2.
//  Copyright © 2016年 WJ. All rights reserved.
//

import UIKit

class WJHorizonLineView: UIView {
    
    var lineHeight:CGFloat?
    var lineColor:UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        self.lineHeight = frame.size.height
        self.lineColor = UIColor.init(red: 206/255.0, green: 206/255.0, blue: 206/255.0, alpha: 1)
    }
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, self.lineHeight!)
        CGContextSetStrokeColorWithColor(context, self.lineColor!.CGColor)
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, 0, 0)
        CGContextAddLineToPoint(context, self.frame.size.width, 0)
        CGContextStrokePath(context)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class WJVerticalLineView: UIView {
    
    var lineHeight:CGFloat?
    var lineColor:UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        self.lineHeight = frame.size.width
        self.lineColor = UIColor.init(red: 206/255.0, green: 206/255.0, blue: 206/255.0, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, self.lineHeight!)
        CGContextSetStrokeColorWithColor(context, self.lineColor!.CGColor)
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, 0, 0)
        CGContextAddLineToPoint(context, 0, self.frame.size.height)
        CGContextStrokePath(context)
    }
}



