//
//  Error.swift
//  APILoader-Sample
//
//  Created by 薮木翔大 on 2022/11/29.
//

import Foundation

public enum APIError : Error {
    case invalid(reason: String)
    case badNetwork
}
