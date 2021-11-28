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
        
        vc.presenter = presenter
        return vc
    }
}
