//
//  DataService.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 2.08.2022.
//

import Foundation

class DataService {
    
    
    
    static let instance = DataService(urlRequestMaker: UrlRequestMaker.init(), dataParser: DataParser.init())
    
    var dataTask : URLSessionDataTask?
    let urlRequestMaker : UrlRequestMaker
    let dataParser : DataParser
    
    init(urlRequestMaker : UrlRequestMaker, dataParser : DataParser) {
        self.urlRequestMaker = urlRequestMaker
        self.dataParser = dataParser
    }
    
    func getDataFromServer (searchWord : String, completion : @escaping (_ carModels : [CarModel] ) -> ()) {
        let url = urlRequestMaker.makeURL()
        
        let session = URLSession.shared
        session.configuration.urlCache?.memoryCapacity = 512 * 1024 * 1024
        session.configuration.requestCachePolicy = .returnCacheDataElseLoad
        print(session.configuration.urlCache?.memoryCapacity as Any)
        
        let dataTask = session.dataTask(with: url) { [self] data, response, error in
            if error != nil {
                print("Error getting data", error as Any)
            } else {
                do {
                    guard let dictArray = try JSONSerialization.jsonObject(with: data!) as? Dictionary<String,Any> else {print("Naaah"); return}
                    completion(dataParser.parseJson(dict: dictArray))
                } catch {
                }
            }
        }
        
        dataTask.resume()
        self.dataTask = dataTask
    }
    
}
