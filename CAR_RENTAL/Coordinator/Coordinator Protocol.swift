//
//  Coordinator Protocol.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 31.08.2022.
//

import Foundation
import UIKit

enum NavVC {
    case loginVC
    case signUpVC
    case mainVC
    case notifVC
    
}

protocol Coordinator {
    var child : [Coordinator]? { get set }
    
    var navigationController : UINavigationController? { get set }
    
    func navOccured (with navVC : NavVC)
    
    func start()
}

protocol Coordinating {
    var coordinator : Coordinator? { get set }
}
