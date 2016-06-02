//
//  WJNumericKeyboard.swift
//  WJNumericKeyboardDemo
//
//  Created by 俊王 on 16/6/2.
//  Copyright © 2016年 WJ. All rights reserved.
//

import UIKit

enum WJNumericKeyboardType {
    case Normal
    case Decimal
}

/** block方式监听点击 */
typealias buttonClickBlock = (currentString:String) -> Void

class WJNumericKeyboard: UIView {
    
    static let sharedInstance = WJNumericKeyboard() //这个位置使用 static，static修饰的变量会懒加载
    
    var numberCount = 0
    
    var numberString:String? = ""

    var btnBlock:buttonClickBlock?
    
    var numbericStringArray:Array<String>? = [ ]
    
    var isRandowNumberirc:Bool? = false
    
    /** 数字键盘数组 */
    private var numbericArray:Array<Array<String>>?
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.numbericArray = [["1","2","3"],["4","5","6"],["7","8","9"],[".","0","X"]]
    }
    
    // MARK: - creatNumberic methods
    
    func creatNumberic(numericKeyboardType:WJNumericKeyboardType) {
    
        let width = self.frame.size.width / 3
        let height = self.frame.size.height / 4
        
        numberCount = (self.numbericArray?.count)!
        
        for i in 0..<4 {
            for j in 0..<3 {
                
                let button = UIButton.init(type: UIButtonType.Custom)
                button.frame = CGRectMake(CGFloat(j) * width, CGFloat(i) * height, width, height)
                button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                button.setTitle(numbericArray![i][j], forState: UIControlState.Normal)
                button.titleLabel?.font = UIFont.boldSystemFontOfSize(26)
                button.backgroundColor = UIColor.whiteColor()
                button.addTarget(self, action:#selector(buttonClick(_:)) , forControlEvents: UIControlEvents.TouchUpInside)

                if (i == 3 && j == 0 || i == 3 && j == 2){
                    button.backgroundColor = UIColor.init(red: 200/255.0, green: 203/255.0, blue: 211/255.0, alpha: 1)
                }
                
                if numericKeyboardType == WJNumericKeyboardType.Normal && (i == 3 && j == 0) {
                    
                    button.setTitle("", forState: UIControlState.Normal)
                }
               
                self.addSubview(button)
            }
        }
        
        drawLineView(CGSizeMake(width, height))
    }
    
    func drawLineView(size:CGSize) {
        
        for i in 0...3 {
            let horizonLineView = WJHorizonLineView.init(frame: CGRectMake(0, CGFloat(i) * size.height + 0.9, self.frame.size.width, 0.8))
            self.addSubview(horizonLineView)
        }
        
        for i in 1...2 {
            let verticalLineView = WJVerticalLineView.init(frame: CGRectMake(CGFloat(i)*size.width, 0, 0.8, self.frame.size.height))
            self.addSubview(verticalLineView)
        }
    }
    
    // MARK: - 随机数生成器函数
    func createRandomMan(start: Int, end: Int) -> Array<Int> {
        
        var randomManArray:Array<Int> = []
        
        //根据参数初始化可选值数组
        var nums = [Int]()
        for i in start...end{
            nums.append(i)
        }
        
        func randomMan() -> Int! {
            if !nums.isEmpty {
                //随机返回一个数，同时从数组里删除
                let index = Int(arc4random_uniform(UInt32(nums.count)))
                return nums.removeAtIndex(index)
            }else {
                //所有值都随机完则返回nil
                return nil
            }
        }
        
        for _ in 0..<nums.count {
            
            randomManArray.append(randomMan())
        }
        
        return randomManArray
    }
    
    func creatRandomNumberic(numericKeyboardType:WJNumericKeyboardType){
        
        var randomArray:Array<AnyObject> = [AnyObject]()
        randomArray = createRandomMan(0, end: 9)
        let index = Int(arc4random_uniform(UInt32(randomArray.count)))
        if numericKeyboardType == WJNumericKeyboardType.Decimal && !randomArray.isEmpty {
            
            randomArray.insert(".", atIndex: index)
        }
        else{
            
            randomArray.insert("", atIndex: index)
        }
        
        randomArray.append("X")
        
        let width = self.frame.size.width / 3
        let height = self.frame.size.height / 4
        
        numberCount = (self.numbericArray?.count)!
        
        for i in 0..<randomArray.count {
            
            let button = UIButton.init(type: UIButtonType.Custom)
            button.frame = CGRectMake(CGFloat(i%3) * width, CGFloat(i%4) * height, width, height)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button.setTitle(String(randomArray[i]), forState: UIControlState.Normal)
            button.titleLabel?.font = UIFont.boldSystemFontOfSize(26)
            button.backgroundColor = UIColor.whiteColor()
            button.addTarget(self, action:#selector(buttonClick(_:)) , forControlEvents: UIControlEvents.TouchUpInside)
            
            self.addSubview(button)
        }
        
        drawLineView(CGSizeMake(width, height))
    }
    
    // MARK: - block and
    func btnBlockClick(block:(String)-> Void) {
        
        self.btnBlock = block
    }

    func buttonClick(btn:UIButton) {
    
        let number = btn.currentTitle
        if number == "X" {
            if self.numbericStringArray?.count > 0 {
                self.numbericStringArray?.removeLast()
            }
        }
        else{
            
            self.numbericStringArray?.append(number!)
        }

        ///字符串的拼接
        var apendString:String? = ""
        for indexString in self.numbericStringArray! {
            
            apendString = apendString!.stringByAppendingString(indexString)
        }
    
        self.numberString = apendString
        if self.btnBlock != nil {
            self.btnBlock!(currentString: self.numberString!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
