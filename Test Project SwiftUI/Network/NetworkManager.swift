//
//  NetworkManager.swift
//  Test Project SwiftUI
//
//  Created by Admin on 08/06/2021.
//

import Foundation
final class NetworkManager{
    /// Builds the relevant URL components from the values specified
    /// in the Endpoint.
    fileprivate class func buildURL(endpoint: Endpoint) -> URLComponents {
        var components = URLComponents()
        components.scheme = endpoint.scheme.rawValue
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        return components
    }
    
    /// Executes the web call and will decode the JSON response into
    /// the Codable object provided.
    /// - Parameters:
    /// - endpoint: the endpoint to make the HTTP request against
    /// - completion: the JSON response converted to the provided
    //    Codable
    /// object, if successful, or failure otherwise
    
    class func request<T: Decodable>(endpoint: Endpoint,
                                     completion: @escaping (Result<T,
                                                                   Error>)
                                        -> Void) {
        let components = buildURL(endpoint: endpoint)
        guard let url = components.url else {
            Log.error("URL creation error")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) {
            data, response, error in
            if let error = error {
                completion(.failure(error))
                Log.error("Unknown Error", error)
                return
            }
            guard response != nil, let data = data else {
                return
            }
            if let responseObject = try? JSONDecoder().decode(T.self,
                                                              from:
                                                                data) {
                completion(.success(responseObject))
            } else {
                let error = NSError(domain: "com.flicker",
                                    code: 200,
                                    userInfo: [
                                        NSLocalizedDescriptionKey:
                                            "Failed"
                                    ])
                completion(.failure(error))
                Log.error("Decode Error", error)
            }
        }
        dataTask.resume()
    }
}
