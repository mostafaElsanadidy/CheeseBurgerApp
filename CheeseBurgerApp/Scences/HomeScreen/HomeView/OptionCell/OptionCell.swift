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
               }, completion: {_ in
               })
       }
}
