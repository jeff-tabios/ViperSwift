//
//  MainView.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/28/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class MainView: UIViewController {
    var presenter: MainPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.slides
            .subscribe(onNext: { slides in
                print(slides)
            },onError: { error in
                print(error)
            },onCompleted: nil, onDisposed: nil)
        
        presenter?.pizzas
            .subscribe(onNext: { pizzas in
                print(pizzas)
            },onError: { error in
                print(error)
            },onCompleted: nil, onDisposed: nil)
        
        presenter?.viewLoadedTrigger.onNext(())
    }
}
