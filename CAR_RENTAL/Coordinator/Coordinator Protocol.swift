//
//  Coordinator Protocol.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 31.08.2022.
//

import Foundation
import UIKit

enum Nav {
    case loginVC
    case signUpVC
    case mainVC
    case notifVC
   
}

protocol Coordinator: AnyObject {
    var childCoordinators : [Coordinator] { get set }
    
    var navigationController : UINavigationController { get set }
    
    func navOccured (with navEnum : Nav)
    
    func start()
}

