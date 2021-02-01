//
//  CurencyExchangeRate.swift
//  CurencyExchangeTestTask
//
//  Created by Dmitry Sachkov on 31.01.2021.
//

import Foundation

struct CurencyExchangeRate: Decodable {
    let disclaimer: String
    let license: String
    let timestamp: Int
    let base: String
    let rates: [String: Double]
}
