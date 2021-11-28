//
//  Slides.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/27/21.
//

import Foundation
import ObjectMapper

struct Slides: Mappable {
    
    var slides: [Slide]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        slides  <- map["slides"]
    }
}

// MARK: - Slide
struct Slide: Mappable {
    var id: Int?
    var image: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id      <- map["id"]
        image   <- map["image"]
    }
}
