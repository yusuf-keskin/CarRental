//
//  DataService.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 2.08.2022.
//

import Foundation

protocol ApiManagerInterface {
    func getDataFromServer (searchWord : String, completion : @escaping (_ carModels : [CarModel] ) -> ()) 
}

class ApiManager : ApiManagerInterface {

    let urlRequestMaker : UrlRequestMakerInterface
    let dataParser : DataParserInterface
    
    init(urlRequestMaker : UrlRequestMakerInterface, dataParser : DataParserInterface) {
        self.urlRequestMaker = urlRequestMaker
        self.dataParser = dataParser
    }
    
    func getDataFromServer (searchWord : String, completion : @escaping (_ carModels : [CarModel] ) -> ()) {
        
        let url = urlRequestMaker.makeURL(searchWord)
        let session = URLSession.shared
        
        guard let url = url else { return }
        
        session.dataTask(with: url) { [self] data, response, error in
            if error != nil {
                print("Error getting data")
            } else {
                do {
                    guard let dictArray = try JSONSerialization.jsonObject(with: data!) as? Dictionary<String,Any> else {print("Data cannot cast as Dictionary<String,Any>"); return}
                    completion(dataParser.parseJson(dict: dictArray))
                } catch {
                }
            }
        }.resume()
    }
    
}
