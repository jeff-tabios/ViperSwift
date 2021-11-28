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
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
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
//                print(menu)
                self?.menu.reload(pizzas: menu.pizzas)
            }).disposed(by: disposeBag)
        
        presenter?.viewLoadedTrigger.onNext(())
    }
    
    func addSubviews() {
        view.addSubview(slideshow)
        view.addSubview(containerView)
        containerView.addSubview(menu)
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
        
        super.updateViewConstraints()
    }
}


extension MainView {

    func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanAction(_:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        containerView.addGestureRecognizer(panGesture)
    }

    @objc func handlePanAction(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let isDraggingDown = translation.y > 0
        let newHeight = currentContainerHeight - translation.y

        // Handle based on gesture state
        switch gesture.state {
        case .changed:
           if newHeight < maximumContainerHeight {
                containerView.snp.updateConstraints { make in
                    make.height.equalTo(newHeight)
                }
               view.layoutIfNeeded()
           }
        case .ended:
           if newHeight < defaultHeight {
               animateContainerHeight(defaultHeight)
           }
           else if newHeight < maximumContainerHeight && isDraggingDown {
               animateContainerHeight(defaultHeight)
           }
           else if newHeight > defaultHeight && !isDraggingDown {
               animateContainerHeight(maximumContainerHeight)
           }
        default:
           break
        }
    }

    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.containerView.snp.updateConstraints { make in
                make.height.equalTo(height)
            }
            self.view.layoutIfNeeded()
        }
        currentContainerHeight = height
    }

}
