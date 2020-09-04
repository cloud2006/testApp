//
//  NetworkService.swift
//  sixtTestApp
//
//  Created by Pavel Antonyuk on 03.09.2020.
//  Copyright © 2020 Pavel Antonyuk. All rights reserved.
//

import Foundation

final class NetworkService {
    
    let baseUrl = "http://www.codetalk.de/cars.json"
    
    let defaultSession = URLSession(configuration: .default)
    
    var dataTask: URLSessionDataTask?
    var errorMessage = ""
    
    func fetchData(completion: @escaping ([Car]?) -> Void) {
        dataTask?.cancel()
        
        guard let url = URL(string: baseUrl) else {
            return
        }
        
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            
            if let error = error {
                self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if let data = data {
                
                var response: [Car]
                
                do {
                    let responseData = try JSONDecoder().decode([Car].self, from: data)
                    response = responseData
                } catch _ as NSError {
                    return
                }
                
                DispatchQueue.main.async {
                    completion(response)
                }
            }
        }
        
        dataTask?.resume()
    }
}
