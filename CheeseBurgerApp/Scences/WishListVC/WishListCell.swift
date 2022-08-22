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
    @IBOutlet weak var islikedyouView: UIViewX!
    @IBOutlet weak var islikedyouImageView: UIImageView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityView: UIView!
    @IBOutlet weak var minusBttn: UIButton!
    
    var indexPath:IndexPath!
    
    var isPlusBttnClickedflag:Bool = true
    var numOfItems = 0{
        didSet{
            quantityLabel.text = "\(numOfItems)"
//            if numOfItems == 0{
//                self.delete(self)
//            }
            updateQuantityPrice(numOfItems, isPlusBttnClickedflag)
        }
    }
    
    var updateQuantityPrice : ((_ quantity:Int, _ isPlusBttnClickedflag:Bool) -> ())!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        burgerImageView.layer.cornerRadius = 10
    }
    
    @IBAction func plusBttnDidTapped(_ sender: UIButton) {

        isPlusBttnClickedflag = true
        
        let count = Int(quantityLabel.text ?? "")
        let orderAmount = count != nil ? count : 0
        numOfItems = orderAmount! + 1
        self.minusBttn.isUserInteractionEnabled = numOfItems > 0
//        guard let flag = self.isPlusBttnClickedflag else { return }
        
    }
    
    @IBAction func minusBttnDidTapped(_ sender: UIButton) {
        
        isPlusBttnClickedflag = false
        let count = Int(quantityLabel.text ?? "")
        print(count)
        let orderAmount = count != nil ? count : 0
        numOfItems = orderAmount! - 1
        sender.isUserInteractionEnabled = numOfItems != 0
    }
    
}
