//
//  BurgerCell.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 16.08.22.
//

import UIKit
import SwipeCellKit

class BurgerCell: SwipeCollectionViewCell {

    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mealDescLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var islikedyouImageView: UIImageView!
    var isLikedYou = false{
        didSet{
            islikedyouImageView.image = UIImage(named: isLikedYou ? "selected heart" : "heart")?.withTintColor(.white, renderingMode: .alwaysTemplate)
          //  islikedyouImageView.resized_Image()
        }
    }
    var toggleIsLikedYou : ((_ isLikedYou:Bool) -> ())!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        islikedyouImageView.image = islikedyouImageView.image?.withTintColor(.white, renderingMode: .alwaysTemplate)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        islikedyouImageView.isUserInteractionEnabled = true
        islikedyouImageView.addGestureRecognizer(tapGestureRecognizer)
        }

        @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
        {
//            let tappedImage = tapGestureRecognizer.view as! UIImageView
            // Your action
            isLikedYou.toggle()
            toggleIsLikedYou(isLikedYou)
        }
    
    
    override func prepareForReuse() {
//        islikedyouImageView.image = islikedyouImageView.image?.withTintColor(.white, renderingMode: .alwaysTemplate)
//        mealImageView.resized_Image()
    }

}
