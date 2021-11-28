//
//  MainInteractor.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/28/21.
//

import Foundation
import RxSwift
import RxCocoa

final class MainInteractor {
    let disposeBag = DisposeBag()
    var slidesService: SlidesServiceProtocol
    var pizzasService: PizzasServiceProtocol
    
    let slides = PublishSubject<Slides>()
    let pizzas = PublishSubject<Pizzas>()
    var getContentTrigger = PublishSubject<Void>()
    
    init(slidesService: SlidesServiceProtocol, pizzasService: PizzasServiceProtocol) {
        self.slidesService = slidesService
        self.pizzasService = pizzasService
        
        getContentTrigger.asObservable()
            .withLatestFrom(slidesService.getSlides())
            .bind(to: slides)
            .disposed(by: disposeBag)
        
        getContentTrigger.asObservable()
            .withLatestFrom(pizzasService.getPizza())
            .bind(to: pizzas)
            .disposed(by: disposeBag)
    }
    
    func getSlides() {
        slidesService.getSlides()
            .subscribe(onNext: { slides in
                print(slides)
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)    }
    
    func getPizzas() {
        pizzasService.getPizza()
            .subscribe(onNext: { pizzas in
                print(pizzas)
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
    }
}
