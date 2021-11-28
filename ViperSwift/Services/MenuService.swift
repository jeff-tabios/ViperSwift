//
//  PizzasService.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/27/21.
//

import Foundation
import RxSwift

protocol MenuServiceProtocol {
    func getMenu() -> Observable<Products>
}

struct MenuService: APIService, MenuServiceProtocol {
    func getMenu() -> Observable<Products> {
        return request(url: StoreAPI.menu.endpoint, method: .GET)
    }
}
