//
//  UIViewController+Toast.swift
//  UnitConverter
//
//  Created by user188399 on 3/15/21.
//  Some of the code in this file was reffered from the youtube video below:
//  https://www.youtube.com/watch?v=0M9g_w6MSiM
//

import Foundation
import UIKit

extension UIViewController {
    
    func showToast(_ message: String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.width / 2 - 125, y: self.view.frame.height * 0.85, width: 250, height: 40))
        toastLabel.textAlignment = .center
        toastLabel.backgroundColor = .black
        toastLabel.textColor = .white
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        toastLabel.text = message
        self.view.addSubview(toastLabel)
         
        UIView.animate(withDuration: 4.0, delay: 1.0, options: .curveEaseInOut, animations: {
            toastLabel.alpha = 0.0
        })
        {
            (isCompleted) in
            toastLabel.removeFromSuperview()
        }
    }
    
}
