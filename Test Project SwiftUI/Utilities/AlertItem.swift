//
//  AlertItem.swift
//  Test Project SwiftUI
//
//  Created by Admin on 12/06/2021.
//

import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    var title: String
    var message: String
    var dismissButton: Alert.Button?
}
