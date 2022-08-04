//
//  DataService.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 2.08.2022.
//

import Foundation

class DataService {

    static let instance = DataService()
    
    func getDataFromServer (searchWord : String, completion : @escaping (_ dict: Dictionary<String,Any> )->()) {
        
        let url = URL(string: SEARCH_URL + searchWord + REST_OF_URL)
        let session = URLSession.shared
        session.dataTask(with: url!) { data, response, error in
            if error != nil {
                print("Error getting data")
            } else {
                do {
                    guard let dictArray = try JSONSerialization.jsonObject(with: data!) as? Dictionary<String,Any> else {print("Naaah"); return}
                    completion(dictArray)
                } catch {
                }
            }
        }.resume()
    }
    
    
    func parseJson (dict : Dictionary<String,Any>, completion : @escaping (_ carModels : [CarModel]) -> ()) {
        var completedArray = [CarModel]()
        var modelArray = [CarModel]()
        var urlModelArray = [UrlModel]()
        
        guard let dataMain = dict["data"] as? [Dictionary<String,Any>]        else  {print("yemedi") ; return}
        guard let included = dict["included"] as? [Dictionary<String,Any>]        else  {print("yemedi") ; return}
        
        for data3 in dataMain {
            var model = CarModel()
            
            let attributes = data3["attributes"] as? Dictionary<String,Any>
            let name = attributes!["name"] as! String
            let relationships = data3["relationships"] as? Dictionary<String,Any>
            let primary_image = relationships!["primary_image"] as? Dictionary<String,Any>
            let data1 = primary_image!["data"] as? Dictionary<String,Any>
            let id1 = data1!["id"] as! String
            
            model = CarModel(name: name, imageUrl: nil, id: id1)
            modelArray.append(model)
        }

        for i in included {
            var urlModel = UrlModel()
            let attributes2 = i["attributes"] as! Dictionary<String,Any>
            let url = attributes2["url"] as! String
            let id2 = i["id"] as! String
            urlModel = UrlModel(id: id2, url: url)
            urlModelArray.append(urlModel)
        }
        
        for i in urlModelArray {
            for var j in modelArray {
                if i.id == j.id {
                    j.imageUrl = i.url
                    completedArray.append(j)
                }
            }
        }
       
        completion(completedArray)
    }
   
}
