//
//  urlRequestMaker.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 13.08.2022.
//

import Foundation

protocol UrlRequestMakerInterface {
    func makeURL (_ keywords: String) -> URL?
}

class UrlRequestMaker : UrlRequestMakerInterface {
    
    var keyword_URL : String = "https://search.outdoorsy.co/rentals?filter[keywords]="
    var pageLimit_AndOffset : String = "&page[limit]=10&page[offset]=10"
    
    func makeURL (_ keywords: String) -> URL? {
        let url = URL(string: keyword_URL + keywords + pageLimit_AndOffset)
        return url
    }
}
