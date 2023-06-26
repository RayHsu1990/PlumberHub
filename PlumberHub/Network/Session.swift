//
//  Session.swift
//  Network
//
//  Created by Ray Hsu on 2023/6/26.
//

import Foundation
import Combine


public protocol URLSessionProtocol {
    func performDataTask<Output: Codable>(with request: URLRequest, completionHandler: @escaping (Result<Output, Error>) -> Void)
    
    func performDataTask<Output: Codable>(with request: URLRequest) async throws -> Output

    func performDataTask<Output: Codable>(with request: URLRequest) -> AnyPublisher<Output, Error>
}

extension URLSession: URLSessionProtocol {
    public func performDataTask<Output: Codable>(with request: URLRequest, completionHandler: @escaping (Result<Output, Error>) -> Void) {
        dataTask(with: request) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(NetworkError.noData))
                return
            }
            
            do {
                let output = try JSONDecoder().decode(Output.self, from: data)
                completionHandler(.success(output))
            } catch {
                completionHandler(.failure(NetworkError.decodeError))
            }
        }
        .resume()
    }
    
    public func performDataTask<Output: Codable>(with request: URLRequest) async throws -> Output {
        let (data, response) = try await data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              (200...299).contains(response.statusCode) else {
            throw NetworkError.noData
        }
        guard let output = try? JSONDecoder().decode(Output.self, from: data) else {
            throw NetworkError.decodeError
        }
        return output
    }
    
    public func performDataTask<Output: Codable>(with request: URLRequest) -> AnyPublisher<Output, Error> {
        dataTaskPublisher(for: request)
            .tryMap { element -> Data in
                guard let response = element.response as? HTTPURLResponse,
                        (200...299).contains(response.statusCode) else {
                    throw NetworkError.noData
                }
                return element.data
            }
            .decode(type: Output.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

}
