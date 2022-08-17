//
//  AppDelegate_S.swift
//  Zawidha
//
//  Created by Maher on 10/4/20.
//

import UIKit

let ad = UIApplication.shared.delegate as! AppDelegate

extension AppDelegate {
//    func isLoading() {
//        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
//    }
//    
//    func killLoading() {
//        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
//    }
    
    // MARK: - Redirect TO VC
    @objc func redirect_TO(vc : UIViewController) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
            return
        }
        sceneDelegate.redirect_To_VC(vc: vc)
    }
    
    // MARK: - Current Root VC
    func CurrentRootVC() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
            return nil
        }
        return  sceneDelegate.window?.currentViewController()
    }
}
