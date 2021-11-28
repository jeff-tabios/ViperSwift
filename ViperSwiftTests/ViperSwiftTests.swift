//
//  ViperSwiftTests.swift
//  ViperSwiftTests
//
//  Created by Jeffrey Tabios on 11/27/21.
//

import XCTest
import RxSwift
@testable import ViperSwift

class ViperSwiftTests: XCTestCase {

    func test_pizzasServiceShouldReturnPizzas() {
        let disposeBag = DisposeBag()
        let sut = MenuService()
        
        let exp = expectation(description: "get pizzas")
        sut.getMenu()
            .subscribe(onNext: { pizzas in
                print(pizzas)
                XCTAssert(pizzas.pizzas?.count == 8)
                exp.fulfill()
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
            
        wait(for: [exp], timeout: 10)
    }
    
    func test_pizzasServiceShouldReturnSlides() {
        let disposeBag = DisposeBag()
        let sut = SlidesService()
        
        let exp = expectation(description: "get slides")
        sut.getSlides()
            .subscribe(onNext: { slides in
                print(slides)
                XCTAssert(slides.slides?.count == 5)
                exp.fulfill()
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
            
        wait(for: [exp], timeout: 10)
    }

}
