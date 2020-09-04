//
//  NetworkService.swift
//  sixtTestApp
//
//  Created by Pavel Antonyuk on 03.09.2020.
//  Copyright © 2020 Pavel Antonyuk. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case apiUnreachable
    case invalidJSON
}

final class NetworkService {
    
    let baseUrl = "http://www.codetalk.de/cars.json"
    
    let defaultSession = URLSession(configuration: .default)
    
    var dataTask: URLSessionDataTask?
    
    func fetchData(completion: @escaping (Result<[Car], RequestError>) -> Void) {
        dataTask?.cancel()
        
        guard let url = URL(string: baseUrl) else {
            return
        }
        
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            
            DispatchQueue.main.async {
                if error != nil {
                    completion(.failure(.apiUnreachable))
                } else if let data = data {
                    do {
                        let responseData = try JSONDecoder().decode([Car].self, from: data)
                        completion(.success(responseData))
                    } catch {
                        completion(.failure(.invalidJSON))
                    }
                }
            }
        }
        
        dataTask?.resume()
    }
}
