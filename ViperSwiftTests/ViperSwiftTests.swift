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

    func test_pizzaServiceShouldReturnPizzas() {
        let disposeBag = DisposeBag()
        let sut = PizzasService()
        
        let exp = expectation(description: "get pizzas")
        sut.getPizza()
            .subscribe(onNext: { pizzas in
                print(pizzas)
                XCTAssert(pizzas.pizzas?.count == 8)
                exp.fulfill()
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
            
        wait(for: [exp], timeout: 10)
    }

}
