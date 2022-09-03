//
//  StorageProtocol.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 1.09.2022.
//

import Foundation

protocol Storage {
    
    var itemsCache : URL { get }
    
    func saveItemsToCache ()
    
    func loadItemsFromCache (completion : @escaping (_ notifData: [NotifData])->()) 
}
