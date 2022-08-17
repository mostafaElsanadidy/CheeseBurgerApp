//
//  CustomTabbar.swift
//  Zawidha
//
//  Created by Maher on 10/7/20.
//

import UIKit

import Foundation
import UIKit

@IBDesignable

class CustomTabbar: UITabBar {
    @IBInspectable var color: UIColor?
    @IBInspectable var radii: CGFloat = 100
    
    private var shapeLayer: CALayer?

    override class func awakeFromNib() {
        super.awakeFromNib()
        
        guard let root = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        let topSafeArea: CGFloat
        let bottomSafeArea: CGFloat

        if #available(iOS 11.0, *) {
            topSafeArea = root.view.safeAreaInsets.top
            bottomSafeArea = root.view.safeAreaInsets.bottom
        } else {
            topSafeArea = root.topLayoutGuide.length
            bottomSafeArea = root.bottomLayoutGuide.length
        }

        print("topSafeArea : \(topSafeArea)")
        print("bottomSafeArea : \(bottomSafeArea)")

        
    }
    override func draw(_ rect: CGRect) {
        self.invalidateIntrinsicContentSize()
        var tabFrame = self.frame

        tabFrame.size.height = tabFrame.height
        tabFrame.origin.y = (self.superview?.frame.size.height ?? 0)-tabFrame.height-45

        self.frame = tabFrame

        addShape()
    }
    
    func repositionBadge(tabIndex: Int){

        for badgeView in self.subviews[0].subviews {
            self.selectedItem?.badgeValue = "●"
            self.selectedItem?.badgeColor = .clear
            self.selectedItem?.setBadgeTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1)], for: .normal)
            if NSStringFromClass(badgeView.classForCoder) == "_UIBadgeView" {
                badgeView.layer.transform = CATransform3DIdentity
                badgeView.layer.transform = CATransform3DMakeTranslation(30, -7, 1.0)
            }
        }
    }
    
    
     func addShape() {
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.gray.withAlphaComponent(0.1).cgColor
        shapeLayer.fillColor = color?.cgColor ?? UIColor.white.cgColor
        shapeLayer.lineWidth = 1
        
        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }
        shapeLayer.shadowOpacity = 0.3
        shapeLayer.shadowOffset = CGSize(width: 0, height: 10)
        shapeLayer.shadowRadius = 5
        self.shapeLayer = shapeLayer
         
    }
    
    
    private func createPath() -> CGPath {
        
//        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 70), radius: CGFloat(self.frame.size.width), startAngle: CGFloat(70), endAngle: CGFloat(50), clockwise: true)
            
//        let curvePath = UIBezierPath.init(ovalIn: CGRect(x: -125, y: -10 , width: self.frame.width+250, height: 150))
       
        let roundCornersPath = UIBezierPath(
            roundedRect:CGRect(x: 20, y: 10 , width: self.frame.width-40, height: 70 //self.frame.height
            ),
            //bounds ,//CGRect(x: 20, y: -50, width: self.frame.width - 40, height: self.frame.height + 20)
            byRoundingCorners: [.allCorners],
            cornerRadii: CGSize(width: self.frame.width/10,height: 0.0))
        
        return roundCornersPath.cgPath

    }
    
}

extension UITabBar {
    func badgeViewForItem(at index: Int) -> UIView? {
        guard subviews.count > index else {
            return nil
        }
        return subviews[index].subviews.first(where: { NSStringFromClass($0.classForCoder) == "_UIBadgeView" })
    }

    func labelForItem(at index: Int) -> UILabel? {
        guard subviews.count > index else {
            return nil
        }
        return badgeViewForItem(at: index)?.subviews.first(where: { $0 is UILabel }) as? UILabel
    }
}

import UIKit

class BaseTabBar: UITabBar {
 

}
