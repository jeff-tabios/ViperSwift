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
    var menuService: MenuServiceProtocol
    
    let slides = PublishSubject<Slides>()
    let menu = PublishSubject<Products>()
    var getContentTrigger = PublishSubject<Void>()
    
    init(slidesService: SlidesServiceProtocol, menuService: MenuServiceProtocol) {
        self.slidesService = slidesService
        self.menuService = menuService
        
        getContentTrigger.asObservable()
            .withLatestFrom(Observable.combineLatest(slidesService.getSlides(), menuService.getMenu()))
            .subscribe(onNext: { [weak self] slides, products in
                self?.slides.onNext(slides)
                self?.menu.onNext(products)
            })
            .disposed(by: disposeBag)
    }
}
