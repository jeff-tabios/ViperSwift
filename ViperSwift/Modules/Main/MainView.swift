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
import SnapKit

final class MainView: UIViewController {
    let disposeBag = DisposeBag()
    
    var presenter: MainPresenter?
    
    let defaultHeight: CGFloat = UIScreen.main.bounds.height * 0.4
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 40
    var currentContainerHeight: CGFloat = UIScreen.main.bounds.height * 0.4
    
    lazy var slideshow: Slideshow = {
        Slideshow()
    }()
    
    lazy var menu: Menu = {
        Menu()
    }()
    
    lazy var cartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cartIcon"), for: .normal)
        button.addTarget(self, action: #selector(didTouchUpInsideCartButton(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 24
        button.setTitleColor(.white, for: .normal)

        return button
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var cartCountView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 10
        view.isHidden = true
        return view
    }()
    
    lazy var cartCount: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.backgroundColor = .darkGray
        label.textColor = .white
        label.font = label.font.withSize(12)
        return label
    }()
    
    @objc func didTouchUpInsideCartButton(_ button: UIButton) {
        print("toCart")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        addSubviews()
        setupPanGesture()
        bind()
    }
    
    func bind() {
        presenter?.slides
            .subscribe(onNext: { [weak self] slides in
                self?.slideshow.reload(slides: slides.slides)
            }).disposed(by: disposeBag)
        
        presenter?.menu
            .subscribe(onNext: { [weak self] menu in
                self?.menu.reload(pizzas: menu.pizzas)
            }).disposed(by: disposeBag)
        
        CartManager.shared.addTrigger.asObserver()
            .subscribe(onNext: { [weak self] in
                let count = CartManager.shared.pizzas.count
                if count > 0 {
                    self?.cartCountView.isHidden = false
                    self?.cartCount.text = "\(count)"
                } else {
                    self?.cartCountView.isHidden = true
                }
            }).disposed(by: disposeBag)
        
        presenter?.viewLoadedTrigger.onNext(())
    }
    
    func addSubviews() {
        view.addSubview(slideshow)
        view.addSubview(containerView)
        containerView.addSubview(menu)
        
        view.addSubview(cartButton)
        view.addSubview(cartCountView)
        cartCountView.addSubview(cartCount)
        self.view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        slideshow.snp.remakeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-(UIScreen.main.bounds.height * 0.4))
        }
        
        containerView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(defaultHeight)
        }
        
        menu.snp.remakeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(40)
        }
        
        cartButton.snp.remakeConstraints { make in
            make.width.height.equalTo(48)
            make.trailing.bottom.equalToSuperview().offset(-30)
        }
        
        cartCountView.snp.remakeConstraints { make in
            make.width.height.equalTo(20)
            make.top.equalTo(cartButton)
            make.trailing.equalTo(cartButton)
        }
        
        cartCount.snp.remakeConstraints { make in
            make.center.equalToSuperview()
        }
        
        super.updateViewConstraints()
    }
}
