//
//  CartManager.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/29/21.
//

import Foundation
import RxSwift

final class CartManager {
    static let shared = CartManager()
    
    var addTrigger = PublishSubject<Void>()
    
    var pizzas: [Pizza] = []
    
    func addToCart(pizza: Pizza) {
            pizzas.append(pizza)
            addTrigger.onNext(())
    }
}
