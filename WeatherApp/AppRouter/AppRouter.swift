//
//  AppRouter.swift
//  WeatherApp
//
//  Created by Chandra Rao on 08/09/18.
//  Copyright © 2018 Chandra Rao. All rights reserved.
//

import Foundation
import UIKit

protocol AlertDelegate {
    func okButtonClicked()
    func cancelButtonClicked()
}

class AppRouter {
    static let sharedInstance = AppRouter()
    var getProfileProtocol: AlertDelegate?
    var centreNavigationController: UINavigationController = UINavigationController()
    
    private init() {
    }
    
    func createRootOfApplication(fromWindow windowObj: UIWindow?, toController controllerVC: UIViewController?) {
        if let window = windowObj, let controller = controllerVC {
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window.rootViewController = controller
                window.makeKeyAndVisible()
            }, completion: { (animated) in
            })
        }
    }
    
    func setCentreNavigationController(centreNavigationController toViewController: UINavigationController) {
        self.centreNavigationController = toViewController
    }
    
    func pushController(fromViewController sourceController: UIViewController?, toViewController destinationController: UIViewController?) {
        if let fromController = sourceController, let toController = destinationController {
            fromController.navigationController?.pushViewController(toController, animated: true)
        }
    }
    
    func popToPreviousController(fromViewController sourceController: UIViewController?) {
        if let fromController = sourceController {
            fromController.navigationController?.popViewController(animated: true)
        }
    }
    
    func presentController(fromViewController sourceController: UIViewController?, toViewController destinationController: UIViewController?) {
        if let fromController = sourceController, let toController = destinationController {
            let navigationController = UINavigationController(rootViewController: toController)
            navigationController.navigationBar.isTranslucent = false
            navigationController.navigationBar.barStyle = UIBarStyle.black
            fromController.navigationController?.present(navigationController, animated: true, completion: {
                // Do Nothing
            })
        }
    }
    
    func showAlertOnController(onController sourceController: UIViewController?, withTitle title: String? = Constants.AppName, withMessage alertMessage: String?) {
        if let onController = sourceController, let message = alertMessage {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                
            })
            alertController.addAction(okAction)
            onController.navigationController?.present(alertController, animated: true, completion: {
                
            })
        }
    }
    
    func showAlertOnControllerAndPopCurrenController(onController sourceController: UIViewController?, withMessage alertMessage: String?, isCancelReq cancelStatus: Bool = true) {
        if let onController = sourceController, let message = alertMessage {
            let alertController = UIAlertController(title: Constants.AppName, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                sourceController?.navigationController?.popViewController(animated: true)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                
            })
            alertController.addAction(okAction)
            if cancelStatus {
                alertController.addAction(cancelAction)                
            }
            onController.navigationController?.present(alertController, animated: true, completion: {
                
            })
        }
    }
    
    func showAlertOnCentreController(withMessage alertMessage: String?) {
        if let message = alertMessage {
            let alertController = UIAlertController(title:Constants.AppName, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                
            })
            alertController.addAction(okAction)
            self.centreNavigationController.present(alertController, animated: true, completion: {
                
            })
            
        }
    }
}
