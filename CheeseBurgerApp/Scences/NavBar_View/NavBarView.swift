//
//  NavBarView.swift
//  NewYumm
//
//  Created by mostafa elsanadidy on 7/14/20.
//  Copyright © 2020 mostafa elsanadidy. All rights reserved.
//

import UIKit

@IBDesignable
class NavBarView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

       @IBOutlet weak var view:UIView!
       @IBOutlet weak var notiLabelView: UIView!
       @IBOutlet weak var notiLabel: UILabel!
    @IBOutlet weak var sideMenuBttn: UIButton!
    @IBOutlet weak var popVCBttn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    var popVC : (() -> ())!
    
   override func awakeFromNib() {
    
         super.awakeFromNib()
         setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){

        self.view = Bundle.init(for: NavBarView.self).loadNibNamed("\(NavBarView.self)", owner: self)![0] as? UIView
        
//        notiLabel.text = "9"
////        notiLabel.frame.size.width = 14
////        notiLabelView.frame.size.width = notiLabel.frame.size.width
////        let max_ = max(notiLabel.frame.size.height,notiLabel.frame.size.width)
////        print(max_)
//        notiLabel.frame.size.height = 20
//        notiLabel.frame.size.width = 20
        
        notiLabelView
            .layer.cornerRadius = 11
        view.frame = bounds
        view.frame.size.width = UIScreen.main.bounds.width
        NotificationCenter.default.addObserver(self, selector: #selector(updateCountOfCartItemsByNotification), name: Notification.Name(rawValue: "updateCountOfCartItems"), object: nil)
        self.addSubview(self.view)
    }
    
    @IBAction func popVC(_ sender: UIButton) {
        popVC()
    }
    
    @IBAction func showOrdersCarPage(_ sender: UIButton) {
        
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "showCarItems"), object: nil)
    }
    
    @IBAction func showSideMenu(_ sender: UIButton) {
            print("bghbghbhgbhgghb")
    //        if let enuBttn = sender as? SSMenuButton {
    //            enuBttn.sideMenuButtonTapped()
    //        }
        
            NotificationCenter.default.post(name: Notification.Name(rawValue: "OpenOrCloseSideMenu"), object: nil)
           //   SSSideMenuControls.openOrCloseSideMenu()
        }
    
    
    @objc func updateCountOfCartItemsByNotification(_ notification:Notification){
        
        notiLabel.text = notification.userInfo!["countOfItems"] as? String
    }
    
}
