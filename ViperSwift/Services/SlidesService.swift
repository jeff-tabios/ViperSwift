//
//  SlidesService.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/27/21.
//

import Foundation
import RxSwift

protocol SlidesServiceProtocol {
    func getSlides() -> Observable<Slides>
}

struct SlidesService: APIService, SlidesServiceProtocol {
    func getSlides() -> Observable<Slides> {
        return request(url: StoreAPI.slides.endpoint, method: .GET)
    }
}
