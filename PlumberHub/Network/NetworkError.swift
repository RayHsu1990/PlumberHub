//
//  NetworkError.swift
//  Network
//
//  Created by Ray Hsu on 2023/6/26.
//

import Foundation

enum NetworkError: Error {
    case noData
    case decodeError
    case generic(Error)
    case urlError
}
