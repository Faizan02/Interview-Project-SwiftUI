//
//  FlickerResultsPage.swift
//  Test Project SwiftUI
//
//  Created by Admin on 08/06/2021.
//

import Foundation
struct FlickerResultsPage: Codable {
    let page: Int
    let pages: Int
    let photo: [FlickerPhoto]
}
