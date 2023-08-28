//
//  Extensions.swift
//  Instagram
//
//  Created by Angela Terao on 25/07/2023.
//

import UIKit

extension UIColor {
    
    static let darkPeach = UIColor(red: 226/255, green: 70/255, blue: 91/255, alpha: 1) //UIColor(red: 249/255, green: 126/255, blue: 114/255, alpha: 1)
    static let lightPeach = UIColor(red: 249/255, green: 165/255, blue: 157/255, alpha: 1)
    static let grayShadow = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
}

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, paddingTop: CGFloat, bottom: NSLayoutYAxisAnchor?, paddingBottom: CGFloat, right: NSLayoutXAxisAnchor?,  paddingRight: CGFloat, left: NSLayoutXAxisAnchor?, paddingLeft: CGFloat, height: CGFloat?, width: CGFloat?) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
    }
    
}

extension UIViewController {
    
    func initializeHideKeyboard(){

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMyKeyboard))
        
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissMyKeyboard(){

        view.endEditing(true)
    }
    
    
}


