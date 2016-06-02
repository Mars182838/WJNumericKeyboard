//
//  ViewController.swift
//  WJNumericKeyboardDemo
//
//  Created by 俊王 on 16/6/2.
//  Copyright © 2016年 WJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    private let numbericKeyboardHeight = 228
    
    var numbericKeyboard:WJNumericKeyboard!
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /** 固定的数字键盘 */
//        self.numbericKeyboard = WJNumericKeyboard.sharedInstance  // 使用单例模式
//        numbericKeyboard!.frame = CGRectMake(0, self.view.frame.size.height - CGFloat(numbericKeyboardHeight), self.view.frame.size.width, CGFloat(numbericKeyboardHeight))
//        numbericKeyboard!.btnBlockClick { (numberString) in
//            
//            self.textField.text = numberString
//        }
//        numbericKeyboard.creatNumberic(false)
        
        /** 动态变换的数字键盘 */

        self.numbericKeyboard = WJNumericKeyboard.sharedInstance        // 使用单例模式
        numbericKeyboard.frame = CGRectMake(0, self.view.frame.size.height - CGFloat(numbericKeyboardHeight), self.view.frame.size.width, CGFloat(numbericKeyboardHeight))
        numbericKeyboard.btnBlockClick { (numberString) in
            
            self.textField.text = numberString
        }

        numbericKeyboard.isRandowNumberirc = true
        numbericKeyboard.creatRandomNumberic(.Decimal)
        
        //使用InputView 方法
        for view in self.view.subviews {
            if let textField = view as? UITextField {
                textField.inputView = numbericKeyboard!
                textField.delegate = self
            }
        }
    }
    
    //MARK: - textFieldDelegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        self.textField = textField
        if (numbericKeyboard?.isRandowNumberirc)! {
            
            self.numbericKeyboard.creatRandomNumberic(.Decimal)
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        self.textField.text = nil
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

