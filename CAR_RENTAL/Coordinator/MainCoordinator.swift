//
//  MainCoordinator.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 31.08.2022.
//

import Foundation
import UIKit


class MainCoordinator : Coordinator {
    var child: [Coordinator]?
    
    var navigationController: UINavigationController?
    
    func navOccured(with NavVC: NavVC) {
        switch NavVC {
        case .signUpVC :
            var vc : UIViewController & Coordinating = SignUpVC()
            vc.coordinator = self
            navigationController?.navigationBar.isHidden = true
            navigationController?.pushViewController(vc, animated: false)
        case .loginVC :
            var vc : UIViewController & Coordinating = LoginVC()
            vc.coordinator = self
            navigationController?.navigationBar.isHidden = true
            navigationController?.pushViewController(vc, animated: false)
        case .mainVC :
            var vc : UIViewController & Coordinating = MainVC()
            vc.coordinator = self
            navigationController?.navigationBar.isHidden = false
            navigationController?.pushViewController(vc, animated: false)
        case .notifVC :
            var vc : UIViewController & Coordinating = NotifDataVC()
            vc.coordinator = self
            navigationController?.navigationBar.isHidden = false
            navigationController?.pushViewController(vc, animated: false)
        }
        
    }
    
    func start() {
        var vc : UIViewController & Coordinating = LoginVC()
        vc.coordinator = self
        navigationController?.navigationBar.backgroundColor = UIColor.white
        navigationController?.setViewControllers([vc], animated: false)
    }
    

    
    
}
