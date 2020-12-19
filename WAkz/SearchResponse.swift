//
//  SearchResponse.swift
//  WAkz
//
//  Created by Almagul Musabekova on 19.12.2020.
//

import Foundation

class SearchResponse {
    var responce: String
    var cityName: String
    
    init(response: String, cityName: String) {
        self.responce = response
        self.cityName = cityName
    }
}
