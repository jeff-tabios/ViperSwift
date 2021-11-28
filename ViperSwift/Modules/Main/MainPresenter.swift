//
//  MainPresenter.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/28/21.
//

import Foundation
import RxSwift
import RxCocoa

final class MainPresenter {
    let disposeBag = DisposeBag()
    var router: MainRouter?
    var interactor: MainInteractor?
    
    let slides = PublishSubject<Slides>()
    let pizzas = PublishSubject<Pizzas>()
    
    let viewLoadedTrigger = PublishSubject<Void>()
    
    init(interactor: MainInteractor, router: MainRouter) {
        self.interactor = interactor
        self.router = router
        
        viewLoadedTrigger.asObservable()
            .bind(to: interactor.getContentTrigger)
            .disposed(by: disposeBag)
        
        interactor.slides.asObservable()
            .bind(to: slides)
            .disposed(by: disposeBag)
        
        interactor.pizzas.asObservable()
            .bind(to: pizzas)
            .disposed(by: disposeBag)
        
    }
}
