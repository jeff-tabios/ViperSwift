//
//  Pizzas.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/27/21.
//

import Foundation
import ObjectMapper

struct Pizzas: Mappable {
    
    var pizzas: [Pizza]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        pizzas <- map["pizzas"]
    }
}

struct Pizza: Mappable {
    var id: Int?
    var pizzaName: String?
    var price: Double?
    var image: String?
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        id          <- map["id"]
        pizzaName   <- map["pizzaName"]
        price       <- map["price"]
        image       <- map["image"]
    }
}
