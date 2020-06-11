//
//  APIService.swift
//  WeatherApp
//
//  Created by botichelli on 5/20/20.
//  Copyright © 2020 Oleksandra Sildushkina. All rights reserved.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    
    let baseURL = "https://bus.sildushkina.com/"
    let session = URLSession.shared
    
    let apikey = ""
    
    func simpleGetRequest(path: String, completion: @escaping(_ data: Data?, _ error: Error?) -> Void) {
        
        guard let request = createRequest(path: path, parameters: [:]) else { return }
        _ = session.dataTask(with: request) { data, response, error in
            completion(data, error)
        }.resume()

    }
    
    func getRequestWithParameters(path: String, parameters: [String: String], completion: @escaping(_ data: Data?, _ error: Error?) -> Void) {
        guard let request = createRequest(path: path, parameters: parameters) else { return }
        
        _ = session.dataTask(with: request) { data, response, error in
            completion(data, error)
        }.resume()
    }
    
    private func createRequest(path: String, parameters: [String: String]) -> URLRequest? {
        var components = URLComponents(string: baseURL + path)
        
        guard components != nil else { return nil }
        let queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
//        queryItems.append(URLQueryItem(name: "appid", value: apikey))
        components?.queryItems = queryItems
        
        guard let url = components!.url else { return nil }
        print(url)
        return URLRequest(url: url)
    }
}
