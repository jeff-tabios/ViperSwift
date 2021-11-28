//
//  Pizzas.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/27/21.
//

import Foundation
import ObjectMapper

struct Products: Mappable {
    
    var pizzas: [Pizza]?
    var sushi: [Sushi]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        pizzas  <- map["pizzas"]
        sushi  <- map["sushi"]
    }
}

struct Pizza: Mappable {
    var id: Int?
    var name: String?
    var price: Double?
    var image: String?
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        price       <- map["price"]
        image       <- map["image"]
    }
}

struct Sushi: Mappable {
    var id: Int?
    var name: String?
    var price: Double?
    var image: String?
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        price       <- map["price"]
        image       <- map["image"]
    }
}
