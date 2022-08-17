//
//  UIView+AdditionalFeatures.swift
//  MadeinKuwait-Driver
//
//  Created by mostafa elsanadidy on 4/19/20.
//  Copyright © 2020 Amir. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

// Using a function since `var image` might conflict with an existing variable
// (like on `UIImageView`)
 func asImage() -> UIImage {
    if #available(iOS 10.0, *) {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    } else {
        UIGraphicsBeginImageContext(self.frame.size)
        self.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIImage(cgImage: image!.cgImage!)
    }
    }
    
}


extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat , path_width: CGFloat = 0) {
        
        var rect = bounds
        if path_width != 0{
            rect.size.width = path_width
        }
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
