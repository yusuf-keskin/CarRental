//
//  AppDelegate.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 31.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

                window = UIWindow(frame: UIScreen.main.bounds)
                let viewModel = createRentalViewModel()
                window?.rootViewController = UINavigationController(rootViewController: ViewController(rentalModel: viewModel))
                window?.makeKeyAndVisible()
                window?.backgroundColor = .white

        return true
    }
    
    func createRentalViewModel() -> RentalViewModelInterface {
        let requestMaker : UrlRequestMakerInterface = UrlRequestMaker()
        let dataParser : DataParserInterface = DataParser()
        let apiManager : ApiManagerInterface = ApiManager(urlRequestMaker: requestMaker, dataParser: dataParser) 
        let viewModel : RentalViewModelInterface = RentalViewModel(apiManager: apiManager)
        return viewModel
    }

}

