//
//  CartRouter.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/29/21.
//

import Foundation
import UIKit

class CartRouter {
    var view: UIViewController {
        let vc = CartView()
        
        let interactor = CartInteractor()
        let presenter = CartPresenter(interactor: interactor, router: self)
        presenter.view = vc
        vc.presenter = presenter
        return vc
    }
    
    func showMenu(from: CartView) {
        from.navigationController?.popViewController(animated: true)
    }
}

