//
//  Endpoints.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/27/21.
//

import Foundation

enum StoreAPI: String {
    case slides = "http://someDomain.com/slides"
    case pizzas = "http://someDomain.com/pizzaList"
    
    var endpoint: String {
        self.rawValue
    }
}
