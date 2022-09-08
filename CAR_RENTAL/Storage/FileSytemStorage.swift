//
//  FileSytemStorage.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 1.09.2022.
//

import Foundation

class FileSystemStorage : Storage {
    
    static let shared = FileSystemStorage()
    
    var items : [NotifData] = []
    
    
    func add(item: NotifData) {
      items.insert(item, at: 0)
      saveItemsToCache()
      }
    
  
    var itemsCache: URL{
        get {
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) [0]
            return documentsURL.appendingPathComponent("notif.dat")
        }
    }
    
    func saveItemsToCache() {
        let encoder = JSONEncoder()
        do{
            let data = try encoder.encode(items)
            try data.write(to: itemsCache)
        } catch {
            print("Error saving notif data items", error)
        }
    }
    
    func loadItemsFromCache (completion : @escaping (_ notifData: [NotifData])->()) {
        do {
            guard FileManager.default.fileExists(atPath: itemsCache.path) else {
                print("No notif data file exist yet")
                return
            }
            let data = try Data(contentsOf: itemsCache)
            let items = try JSONDecoder().decode([NotifData].self, from: data)
            completion(items)
        } catch {
            print("Error loading notif data")
        }
    }
    
}
