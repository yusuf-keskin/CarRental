//
//  LoginCoordinator.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 6.09.2022.
//

import Foundation
import UIKit

class LoginCoordinator : Coordinator {
    
    weak var parentCoordinator : MainCoordinator?
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navOccured(with navEnum: Nav) {
        
    }
    
    func start() {
        let vc = LoginVC()
        //vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
