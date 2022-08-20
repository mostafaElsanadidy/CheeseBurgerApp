//
//  UIViewController+TabBarImages.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 16.08.22.
//

import Foundation
import UIKit

extension UIViewController{
    
    func pushViewController(id:String = "" , VC:UIViewController! = nil){
      
        if VC != nil{
            self.navigationController?.pushViewController(VC , animated: true)
        }else if id != ""{
        let homeVC = self.storyboard!.instantiateViewController(withIdentifier :id)
        //present(homeVC, animated: true, completion: nil)
            self.navigationController?.pushViewController(homeVC , animated: true)}
    }
    
    
    @objc func popVCFromNav(){
        
    self.navigationController?.popViewController(animated: true)
    }
    
    func configureTabBarImage(with selectedIndx:Int, isSelectedState:Bool = false) -> UIImage{
              var imageName = ""
        var renderingMode:UIImage.RenderingMode = .alwaysOriginal
          
        var height:CGFloat = 30
            switch selectedIndx{
            case 0:
                imageName = isSelectedState ? "Selected Home" : "Home"
            case 1:
                height = 30
                imageName = isSelectedState ? "selected heart" : "heart"
            case 2:
                height = 30
                imageName = isSelectedState ? "selected user" : "user"
            case 3:
                height = 45
                imageName = "doollar"
            default:
                height = 30
                imageName = "MOney-sign"
            }
            
        let view = UIView.init(frame: CGRect.init(x: 0, y: -100, width: 50, height: 50))
                     
//        view.backgroundColor = #colorLiteral(red: 0.4549019608, green: 0.5411764706, blue: 0.6156862745, alpha: 1)
//        view.layer.cornerRadius = 60/2
                                  
        let imageView = UIImageView.init(frame: CGRect.init(x: view.frame.size.width/2-height/2,y: view.frame.size.height/2-height/2, width: height, height: height))
        
        
//        var realColor = UIColor()
//
//        if imageColor == #colorLiteral(red: 0.4549019608, green: 0.5411764706, blue:            0.6156862745, alpha: 1){
//                realColor = .white
//              }else{
//                realColor = #colorLiteral(red: 1, green: 0.6470588235, blue: 0.4039215686, alpha: 1)
//              }
        
        let imageColor = isSelectedState ? #colorLiteral(red: 0.8807975054, green: 0.5316982269, blue: 0.219119817, alpha: 1) : #colorLiteral(red: 0.7294118404, green: 0.7294118404, blue: 0.7294118404, alpha: 1)
        
        let image = UIImage(named: imageName)?.withTintColor(imageColor, renderingMode: renderingMode)
//        let image = UIImage(named: imageName)?.withTintColor(imageColor, renderingMode: renderingMode)
                      
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        //like as badgeView
        if isSelectedState{
            
            let subView = UIView(frame: CGRect(x: imageView.frame.origin.x+6, y: imageView.frame.origin.y+imageView.frame.height+5, width: imageView.frame.width-12, height: 1))
            subView.backgroundColor = imageColor
           // label.layer.cornerRadius = 20/2

            view.addSubview(subView)
        }
        
       
        
         return view.asImage().withRenderingMode(renderingMode)
    
    }
}
