//
//  OptionCell.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 16.08.22.
//

import UIKit

class OptionCell: UICollectionViewCell {

    @IBOutlet weak var segmentedView: UIViewX!
    @IBOutlet weak var segmentedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        segmentedView.isHidden = true
        self.bringSubviewToFront(segmentedLabel)
    }

    
    override var isSelected: Bool{
        didSet{
            self.contentView.bringSubviewToFront(self.segmentedLabel)
            toggleIsHighlighted(isSelected: isSelected)
        }
    }
//    override var isHighlighted: Bool {
//           didSet {
//               toggleIsHighlighted()
//           }
//       }

    func toggleIsHighlighted(isSelected:Bool) {
           
        UIView.transition(with: self.contentView, duration: 0.5, options: [.transitionCrossDissolve], animations: {
               self.segmentedView.isHidden = !isSelected
//               self.quantityLabel.isHidden = !self.quantityLabel.isHidden
//               self.quantityView.isHidden = !self.quantityView.isHidden
               }, completion: {_ in
           //        self.currentIndex = nextIndex
               })
//           UIView.animate(withDuration: 0.5, delay: 0, options: [.transitionFlipFromLeft], animations: {
//               self.segmentedView.isHidden = false
////               self.bringSubviewToFront(self.segmentedLabel)
//           })
//           UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseOut], animations: {
//               self.alpha = self.isHighlighted ? 0.9 : 1.0
//               self.transform = self.isHighlighted ?
//                   CGAffineTransform.identity.scaledBy(x: 0.97, y: 0.97) :
//                   CGAffineTransform.identity
//           })
       }
}
