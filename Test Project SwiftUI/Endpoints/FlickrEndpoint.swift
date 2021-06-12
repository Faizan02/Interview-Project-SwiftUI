//
//  FlickrEndpoint.swift
//  Test Project SwiftUI
//
//  Created by Admin on 08/06/2021.
//

import Foundation

enum FlickrEndpoint: Endpoint{
    case getSearchResults(searchText: String,page: Int)
    var scheme: HTTPScheme{
        switch self {
        case .getSearchResults:
            return .https
        }
    }
    
    var baseURL: String{
        switch self {
        case .getSearchResults:
            return flickrBaseUrl.baseUrl
        }
    }
    
    var path: String{
        switch self {
        case .getSearchResults:
            return "/services/rest/"
        }
    }
    
    var parameters: [URLQueryItem]{
        let apiKey = "337fdf795fd9fd1801b3569a98d9d37b"
        switch self {
        case .getSearchResults(let searchText, let page):
            return[URLQueryItem(name: "text", value: searchText),
                   URLQueryItem(name: "page", value: String(page)),
                   URLQueryItem(name: "method", value: "flickr.photos.search"),
                   URLQueryItem(name: "format", value: "json"),
                   URLQueryItem(name: "per_page", value: "20"),
                   URLQueryItem(name: "nojsoncallback", value: "1"),
                   URLQueryItem(name: "api_key", value: apiKey)
            ]
        }
    }

    
    var method: HTTPMethod{
        switch self {
        case .getSearchResults:
            return .get
        }
    }
    
    
}
