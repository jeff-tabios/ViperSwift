//
//  CartView.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/29/21.
//

import Foundation
import UIKit
import RxSwift

final class CartView: UIViewController {
    let disposeBag = DisposeBag()
    
    var presenter: CartPresenter?
    
    lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "menuIcon"), for: .normal)
        button.layer.cornerRadius = 24
        button.setTitleColor(.white, for: .normal)

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        bind()
    }
    
    func bind() {
        menuButton.rx.tap.asDriver()
            .drive(presenter!.menuButtonTappedTrigger)
            .disposed(by: disposeBag)
        
        presenter?.items
            .subscribe(onNext: { [weak self] items in
                print(items)
            }).disposed(by: disposeBag)
        
        presenter?.viewLoadedTrigger.onNext(())
    }
    
    func addSubviews() {
//        view.addSubview(slideshow)
//        view.addSubview(containerView)
//        containerView.addSubview(menu)
//        
        view.addSubview(menuButton)
//        view.addSubview(cartCountView)
//        cartCountView.addSubview(cartCount)
        self.view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        
        menuButton.snp.remakeConstraints { make in
            make.width.height.equalTo(48)
            make.trailing.bottom.equalToSuperview().offset(-30)
        }
        
        super.updateViewConstraints()
    }
}
