//
//  AppExtention.swift
//  SwiftExampleCode
//
//  Created by JITESH on 25/04/19.
//  Copyright © 2019 JITESH. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

// #-#-#-#-#-#-#-#-#-#-#-#-#-#-#
//MARK:- UIViewController Extension
// #-#-#-#-#-#-#-#-#-#-#-#-#-#-#
extension UIViewController {
    func showAlert(title: String? = nil, message: String, firstBtnName: String = "OK", firstBtnHandler: ((UIAlertAction) -> Void)? = nil, secondBtnName: String? = nil, secondBtnHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: firstBtnName, style: .default, handler: firstBtnHandler))
        if secondBtnName != nil {
            alertController.addAction(UIAlertAction(title: secondBtnName, style: .default, handler: secondBtnHandler))
        }
        self.present(alertController, animated: true)
    }
    
    func showLoader()
    {
//        SVProgressHUD.setDefaultMaskType(.custom)
//        //SVProgressHUD.setRingRadius(5.0)
//        SVProgressHUD.setRingThickness(4.0)
//        SVProgressHUD.setDefaultStyle(.custom)
//        SVProgressHUD.setBackgroundColor(UIColor.clear)
//        SVProgressHUD.setForegroundColor(colorBlueNavigation)
        SVProgressHUD.show()
    }
    func hideLoader()
    {
        SVProgressHUD.dismiss()
    }
    
}
