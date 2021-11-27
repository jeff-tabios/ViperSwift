//
//  PizzasService.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/27/21.
//

import Foundation
import RxSwift

protocol PizzasServiceProtocol {
    func getPizza() -> Observable<Pizzas>
}

struct PizzasService: APIService, PizzasServiceProtocol {
    func getPizza() -> Observable<Pizzas> {
        return request(url: StoreAPI.pizzas.endpoint, method: .GET)
    }
}
