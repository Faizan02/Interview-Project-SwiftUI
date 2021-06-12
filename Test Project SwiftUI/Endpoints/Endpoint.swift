//
//  Endpoint.swift
//  Test Project SwiftUI
//
//  Created by Admin on 08/06/2021.
//

import Foundation
enum HTTPMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}
enum HTTPScheme: String {
    case http
    case https
}
/// The API protocol allows us to separate the task of constructing a
//URL,
/// its parameters, and HTTP method from the act of executing the URL
//request
/// and parsing the response.
protocol Endpoint {
    /// .http or .https
    var scheme: HTTPScheme { get }
    // Example: "api.flickr.com"
    var baseURL: String { get }
    // "/services/rest/"
    var path: String { get }
    // [URLQueryItem(name: "api_key", value: API_KEY)]
    var parameters: [URLQueryItem] { get }
    // "GET"
    var method: HTTPMethod { get }
}
