//
//  APIService.swift
//  ViperUISwift
//
//  Created by Jeffrey Tabios on 11/27/21.
//

import Foundation
import RxSwift
import ObjectMapper

enum HTTPMETHOD: String {
    case GET
    case POST
    case DELETE
    case PUT
}

protocol APIService {
    func request<T: Mappable>(url: String, method: HTTPMETHOD, contentType: String, params: [String: Any]?) -> Observable<T>
}

extension APIService {
    func request<T: Mappable>(url: String,
                              method: HTTPMETHOD,
                              contentType: String = "application/json",
                              params: [String: Any]? = nil) -> Observable<T> {
        
        return Observable<T>.create({ (observer) -> Disposable in
            
            //MOCK!
            let configuration = URLSessionConfiguration.default
            configuration.protocolClasses = [MockURLProtocol.self] 
            let sessionManager = URLSession(configuration: configuration)
            
            if let apiEndpoint = URL(string: url) {
                var urlRequest = URLRequest(url: apiEndpoint)
                urlRequest.httpMethod = method.rawValue
                urlRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
                
                sessionManager.dataTask(with: urlRequest) { data, response, error in
                    if let data = data {
                        let jsonString = String(decoding: data, as: UTF8.self)
                        if let results = Mapper<T>().map(JSONString: jsonString) {
                            observer.onNext(results)
                            observer.onCompleted()
                        }
                    } else if let error = error {
                        observer.onError(error)
                    }
                    
                }.resume()
            }
            return Disposables.create()
        })

    }
}
