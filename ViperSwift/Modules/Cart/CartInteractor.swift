//
//  CartInteractor.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/29/21.
//

import Foundation
import RxSwift

final class CartInteractor {
    let disposeBag = DisposeBag()
    
    var items = PublishSubject<[Pizza]>()
    var getContentTrigger = PublishSubject<Void>()
    
    init() {
        getContentTrigger.asObservable()
            .withLatestFrom(Observable.just(CartManager.shared.pizzas))
            .bind(to: items)
            .disposed(by: disposeBag)
    }
    
}
