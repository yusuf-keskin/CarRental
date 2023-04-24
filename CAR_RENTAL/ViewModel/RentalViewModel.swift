//
//  RentalViewModel.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 2.08.2022.
//

import Foundation

protocol RentalViewModelInterface {
    func updateSearch (completion : @escaping(_ model : [CarModel])->())
    var searchWord : Observable<String> { get set }
}

class RentalViewModel : RentalViewModelInterface {
    
    var searchWord = Observable<String>("")
    let apiManager : ApiManagerInterface
    
    init(apiManager: ApiManagerInterface) {
        self.apiManager = apiManager
    }
    
    func updateSearch (completion : @escaping(_ model : [CarModel])->()){
        apiManager.getDataFromServer(searchWord: searchWord.value) { carModels in
            completion(carModels)
        }
    }
}

