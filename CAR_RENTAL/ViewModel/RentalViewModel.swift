//
//  RentalViewModel.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 2.08.2022.
//

import Foundation

class RentalViewModel {
    
    var searchWord = Observable<String>("trailer")
    var model = Observable<[CarModel]>([CarModel]())

    func updateSearch (completion: @escaping (_ success : Bool)-> ())  {
        DataService.instance.getDataFromServer(searchWord: searchWord.value) { dict in
                DataService.instance.parseJson(dict: dict) { [self] carModels in
                    model.value = carModels
                    completion(true)
            }
        }
    }

}
