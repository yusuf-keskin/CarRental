//
//  urlRequestMaker.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 13.08.2022.
//

import Foundation

var searchWord = Observable<String>("trailer")

class UrlRequestMaker {
    func makeURL () -> URL {
        let url = URL(string: SEARCH_URL + searchWord.value + REST_OF_URL)!
        return url
    }
}
