//
//  CartPresenter.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/29/21.
//

import Foundation
import RxSwift

final class CartPresenter {
    
    let disposeBag = DisposeBag()
    
    weak var view: CartView?
    var router: CartRouter?
    var interactor: CartInteractor?
    
    let viewLoadedTrigger = PublishSubject<Void>()
    var items = PublishSubject<[Pizza]>()
    let menuButtonTappedTrigger = PublishSubject<Void>()
    
    init(interactor: CartInteractor, router: CartRouter) {
        self.interactor = interactor
        self.router = router
        
        menuButtonTappedTrigger.asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] _ in
                if let view = self?.view {
                    self?.router?.showMenu(from: view)
                }
            })
            .disposed(by: disposeBag)
        
        viewLoadedTrigger.asObservable()
            .bind(to: interactor.getContentTrigger)
            .disposed(by: disposeBag)
        
        interactor.items.asObservable()
            .bind(to: items)
            .disposed(by: disposeBag)
    }
}
