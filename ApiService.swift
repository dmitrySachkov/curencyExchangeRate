//
//  ApiService.swift
//  CurencyExchangeTestTask
//
//  Created by Dmitry Sachkov on 31.01.2021.
//

import Foundation
import Moya

enum ApiService {
    case getCurency
    case getRate(curency: String)
}

extension ApiService: TargetType {
    var baseURL: URL {
        return URL(string: "https://openexchangerates.org")!
    }
    
    var path: String {
        switch self {
        case .getCurency:
            return "/api/currencies.json"
        case .getRate(let curency):
            return
                "/api/latest.json?app_id=f89f4e7da071431eadf67549e6289a04&base:\(curency)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCurency:
            return .get
        case .getRate(_):
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getCurency, .getRate(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return .none
    }
    
    
}
