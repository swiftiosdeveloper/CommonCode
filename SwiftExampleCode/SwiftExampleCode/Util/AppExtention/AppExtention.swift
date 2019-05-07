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
    
    func reloadWithoutAnimation(indexPath : IndexPath,_ completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: {
            //DispatchQueue.main.async {
            UIView.setAnimationsEnabled(false)
            self.layer.removeAllAnimations()
            let lastScrollOffset = self.contentOffset
            self.beginUpdates()
            self.reloadRows(at: [indexPath], with: .none)
            self.endUpdates()
            self.setContentOffset(lastScrollOffset, animated: false)
            UIView.setAnimationsEnabled(true)
            //}
        }, completion:{ _ in
            completion()
        })
        
    }
    
}
// #-#-#-#-#-#-#-#-#-#-#-#-#-#-#
//MARK:- UIView Extension
// #-#-#-#-#-#-#-#-#-#-#-#-#-#-#
extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
        self.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true, shadowRedius : CGFloat = 1 ) {
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = shadowRedius
        self.layer.cornerRadius = radius
    }
    
    func dropShadowWithMask(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true, shadowRedius : CGFloat = 1 ) {
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = shadowRedius
        self.layer.cornerRadius = radius
    }
    
}

// MARK: - Data
extension Data {
    func getJSONResponse() -> Any? {
        guard let response = try? JSONSerialization.jsonObject(with: self) else {
            return nil
        }
        return response
    }
    
    var size: Double {
        return Double(self.count) / (1000 * 1000)
    }
}
// MARK: - DateFormatter
extension DateFormatter {
    static let ddMMyyyy = "dd/MM/yyyy"
    static let yyyyMMdd = "yyyy-MM-dd"
    static let yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
}

// MARK: - Date
extension Date {
    func getString(in format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    
}
extension String{
    
    func getDate(fromFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}
