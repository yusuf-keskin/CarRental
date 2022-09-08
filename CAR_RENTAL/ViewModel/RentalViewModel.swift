
//  RentalViewModel.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 2.08.2022.


import Foundation

class RentalViewModel {
    
    var searchWord = Observable<String>("trailer")

    func updateSearch (completion : @escaping(_ model : [CarModel])->()){
        DataService.instance.getDataFromServer(searchWord: searchWord.value) { carModels in
            completion(carModels)
        }
    }
}


