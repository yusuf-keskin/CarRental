//
//  NotifDataModel.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 1.09.2022.
//

import Foundation

struct NotifData : Codable {
    var title : String
    var body : String
    
    @discardableResult
    static func makeNotifItem( _ notification : [String: AnyObject]) -> NotifData? {
        guard
        let alert = notification["alert"] as? [String: AnyObject],
        let title = alert["title"] as? String ,
        let body = alert["body"] as? String  else { return nil }
        
        let notifData = NotifData(title: title, body: body)
        
        let systemStorage = FileSystemStorage.shared
        systemStorage.add(item: notifData)
        
        NotificationCenter.default.post(name: NotifDataVC.refreshTableViewNotification, object: self)
    
    
//    @discardableResult
//    static func makeNotifItem( _ notification : [String: AnyObject]) -> NotifData? {
//        guard
//        let name = notification["alert"] as? String,
//        let description = notification["description"] as? String
//        else { return nil }
//
//        let notifData = NotifData(name: name, description: description)
//
//        let systemStorage = FileSystemStorage.shared
//        systemStorage.add(item: notifData)
//
//        NotificationCenter.default.post(name: NotifDataVC.refreshTableViewNotification, object: self)
     
        return notifData
    }
}

