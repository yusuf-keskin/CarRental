//
//  MainCoordinator.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 31.08.2022.
//

import Foundation
import UIKit


class MainCoordinator : NSObject, Coordinator, UINavigationControllerDelegate {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navOccured(with navEnum: Nav) {
        switch navEnum {
        case .signUpVC :
            let vc = SignUpVC()
            vc.coordinator = self
            navigationController.navigationBar.isHidden = true
            navigationController.viewControllers.removeAll()
            navigationController.setViewControllers([vc], animated: false)
            
            
//            let child = SignUpCoordinator(navigationController: navigationController)
//            child.parentCoordinator = self
//            childCoordinators.append(child)
//            child.start()
            
        case .loginVC :
            let vc = LoginVC()
            vc.coordinator = self
            print("login start")
            navigationController.navigationBar.isHidden = true
            navigationController.viewControllers.removeAll()
            navigationController.setViewControllers([vc], animated: false)
        case .mainVC :
            let vc = MainVC()
            vc.coordinator = self
            navigationController.navigationBar.isHidden = false
            navigationController.pushViewController(vc, animated: false)
        case .notifVC :
            let vc = NotifDataVC()
            vc.coordinator = self
            navigationController.navigationBar.isHidden = false
            navigationController.pushViewController(vc, animated: false)
        }
        
        
    }
    
    func start() {
        let vc = LoginVC()
        vc.coordinator = self
        navigationController.navigationBar.backgroundColor = UIColor.white
        navigationController.setViewControllers([vc], animated: false)
    }
    
//    func loginChild() {
//        let child = LoginCoordinator(navigationController: navigationController)
//        child.parentCoordinator = self
//        childCoordinators.append(child)
//        child.start()
//    }
 
    ///remove childs that finihsed the work
    func childDidFinish(_ child : Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        print(navigationController.viewControllers)
        print(self.childCoordinators)
        
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        if let signUpVC = fromViewController as? SignUpVC {
            childDidFinish(signUpVC.coordinator)
        }
        

    }
    
    
    
}
