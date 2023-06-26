//
//  Client.swift
//  Network
//
//  Created by Ray Hsu on 2023/6/26.
//

import Foundation

public class ApiClient {
    private let session: URLSessionProtocol
    
    private lazy var defaultHeader: [String: String] = {
        ["content-type": "application/json"]
    }()
    
    public init(session: URLSessionProtocol) {
        self.session = session
    }
}


public enum HTTPMethodType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
