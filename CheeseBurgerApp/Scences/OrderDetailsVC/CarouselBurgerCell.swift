//
//  CarouselBurgerCell.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 17.08.22.
//

import UIKit

class CarouselBurgerCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var burgerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.mainView.layer.cornerRadius = 13.0
//        self.mainView.layer.shadowColor = UIColor.blue.cgColor
//        self.mainView.layer.shadowOpacity = 0.5
//        self.mainView.layer.shadowOffset = .zero
//        self.mainView.layer.shadowPath = UIBezierPath(rect: self.mainView.bounds).cgPath
//        self.mainView.layer.shouldRasterize = true
    }

}
