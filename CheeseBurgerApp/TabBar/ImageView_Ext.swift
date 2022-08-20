//
//  ImageView_Ext.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 19.08.22.
//

import Foundation
import UIKit

extension UIImageView{
    
    func resized_Image(){
        let horizontalRatio = bounds.width / (self.image?.size.width ?? 0)
        let verticalRatio = bounds.height / (self.image?.size.height ?? 0)
        let ratio = min(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: (self.image?.size.width ?? 0) * ratio,
                             height: (self.image?.size.height ?? 0) * ratio)
        
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        self.image?.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.image = newImage
//        print(self.image?.size)
        return
    }
//    cell.firstImage.image?.resized_Image(withBounds: cell.firstImage.frame.size, in: cell.firstImage)
    
}


extension UIImage{

    func resizeImage(image: UIImage?, targetSize: CGSize) -> UIImage? {
        let size = image?.size
        let width = (size?.width ?? 0)
        let height = (size?.height ?? 0)

        let widthRatio  = targetSize.width  / width
        let heightRatio = targetSize.height / height

       // Figure out what our orientation is, and use that to form the rectangle
       var newSize: CGSize
       if(widthRatio > heightRatio) {
           newSize = CGSize(width: width * heightRatio, height: height * heightRatio)
       } else {
           newSize = CGSize(width: width * widthRatio,  height: height * widthRatio)
       }

       // This is the rect that we've calculated out and this is what is actually used below
       let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

       // Actually do the resizing to the rect using the ImageContext stuff
       UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image?.draw(in: rect)
       let newImage = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()

       return newImage
   }
    
    func resizedImage(withBounds bounds: CGSize) -> UIImage {
            let horizontalRatio = bounds.width / size.width
            let verticalRatio = bounds.height / size.height
            let ratio = min(horizontalRatio, verticalRatio)
            let newSize = CGSize(width: size.width * ratio,
                                 height: size.height * ratio)
            
            UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
            draw(in: CGRect(origin: CGPoint.zero, size: newSize))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return newImage!
        }
}
