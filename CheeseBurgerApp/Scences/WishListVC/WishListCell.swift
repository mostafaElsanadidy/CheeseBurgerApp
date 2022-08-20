//
//  WishListCell.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 18.08.22.
//

import UIKit
import SwipeCellKit

class WishListCell: SwipeCollectionViewCell {

    @IBOutlet weak var burgerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mealDescLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
  //  @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var islikedyouImageView: UIImageView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityView: UIView!
    
    var numOfItems = 0{
        didSet{
            quantityLabel.text = "\(numOfItems)"
            updateQuantityPrice(numOfItems)
        }
    }
    
    var updateQuantityPrice : ((_ quantity:Int) -> ())!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        burgerImageView.layer.cornerRadius = 10
    }
    
    @IBAction func plusBttnDidTapped(_ sender: UIButton) {
        if let count = Int(quantityLabel.text ?? ""),count != 0{
            numOfItems = count }
        numOfItems += 1
    }
    @IBAction func minusBttnDidTapped(_ sender: UIButton) {
        if let count = Int(quantityLabel.text ?? ""),count != 0{
            numOfItems = count }
        numOfItems = numOfItems == 0 ? 0 : numOfItems - 1
    }
    
}
