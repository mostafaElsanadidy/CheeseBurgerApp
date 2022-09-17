//
//  ShoppingCartVC.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 22.08.22.
//

import UIKit

//class ShoppingCartVC: UIViewController {
//    
//    @IBOutlet weak var mealsTableView: UITableView!
//    @IBOutlet weak var totalLabel: UILabel!
//    @IBOutlet weak var shippingFeedsLabel: UILabel!
//    @IBOutlet weak var orderAmountLabel: UILabel!
//    @IBOutlet weak var countOfCartItemsLabel: UILabel!
//    @IBOutlet weak var countOfCartItemsView: UIViewX!
//
//    var shoppingCartViewModel = ShoppingCartViewModel()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        setupBinder()
//        shoppingCartViewModel.totalPriceDidChange()
//        setup_Collection()
//    }
//
//    func setupBinder(){
//        shoppingCartViewModel.shoppingCartMeals.bind{
//            [weak self] shoppingCartMeals in
//            guard let strongSelf = self else{return}
//            DispatchQueue.main.async{
//                strongSelf.mealsTableView.reloadData()
//            }
//        }
//        shoppingCartViewModel.totalPrice.bind{
//            [weak self] totalPrice in
//            guard let strongSelf = self else{return}
//            DispatchQueue.main.async{
//                strongSelf.orderAmountLabel?.text = "\(totalPrice) "+"$"
//                strongSelf.shippingFeedsLabel?.text = "10.0 $"
//                strongSelf.totalLabel?.text = "\(totalPrice+10.0)"
//                
//            }
//        }
//        shoppingCartViewModel.isPlusBttnClickedflag.bind{
//            [weak self] flag in
//            guard let strongSelf = self,let flag = flag else{return}
//            var countOfCartItems = (Int(strongSelf.countOfCartItemsLabel.text ?? "") ?? 0)
//            countOfCartItems =  flag ? countOfCartItems + 1 : countOfCartItems - 1
//            
//            print(countOfCartItems)
//            strongSelf.countOfCartItemsLabel.text = "\(countOfCartItems)"
//        }
//        shoppingCartViewModel.collectionWillDeleteCellIndex.bind{
//            [weak self] cellIndex in
//            guard let strongSelf = self, let cellIndex = cellIndex else{return}
//            guard var visibleRows = strongSelf.mealsTableView.indexPathsForVisibleRows else{return}
//            let indexPath = IndexPath(row: cellIndex , section: 0)
//            for (i,visibleRow) in visibleRows.enumerated(){
//                if indexPath == visibleRow{
//                    visibleRows.remove(at: i)
//                }
//            }
//            strongSelf.mealsTableView.beginUpdates()
//            strongSelf.mealsTableView.reloadRows(at: visibleRows, with: .automatic)
//            strongSelf.mealsTableView.deleteRows(at: [IndexPath(row: cellIndex, section: 0)], with: .fade)
//            strongSelf.mealsTableView.endUpdates()
//        }
//    }
//    // MARK: - Setup Collection
//    private func setup_Collection() {
//        
//        mealsTableView.dataSource = self
//        mealsTableView.delegate = self
//        mealsTableView.register(UINib(nibName: "ShoppingCartCell", bundle: nil), forCellReuseIdentifier: "ShoppingCartCell")
//        
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        NotificationCenter.default.addObserver(self, selector: #selector(updateCountOfCartItemsByNotification), name: Notification.Name(rawValue: "updateCountOfCartItems"), object: nil)
//        NotificationCenter.default.post(name: Notification.Name(rawValue: "showCountOfCartItems"), object: nil)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
////            self.mealsTableView.reloadData()
//    }
//
//    @objc func updateCountOfCartItemsByNotification(_ notification:Notification){
//        let dictionaryValue = notification.userInfo!["countOfItems"] as? String
//        countOfCartItemsLabel.text = dictionaryValue ?? ""
//    }
//    
//    @IBAction func didCardBttnTapped(_ sender: UIButton) {
//        
////        NotificationCenter.default.post(name: Notification.Name(rawValue: "showCarItems"), object: nil)
//        self.mealsTableView.reloadData()
//        mealsTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
//    }
//    
//    @IBAction func didReturnBttnTapped(_ sender: UIButton) {
//        self.popVCFromNav()
//    }
//
//    
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
