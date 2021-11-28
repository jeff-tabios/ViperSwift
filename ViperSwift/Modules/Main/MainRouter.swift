//
//  MainRouter.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/28/21.
//

import Foundation
import UIKit

class MainRouter {
    var view: UIViewController {
        let vc = MainView()
        
        let slidesService = SlidesService()
        let pizzasService = MenuService()
        
        let interactor = MainInteractor(slidesService: slidesService, menuService: pizzasService)
        let presenter = MainPresenter(interactor: interactor, router: self)
        presenter.view = vc
        
        vc.presenter = presenter
        return vc
    }
    
    func showCart(from: MainView) {
        let cartRouter = CartRouter()
        from.navigationController?.pushViewController(cartRouter.view, animated: true)
    }
}
