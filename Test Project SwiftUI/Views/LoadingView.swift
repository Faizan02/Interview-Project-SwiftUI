//
//  LoadingView.swift
//  Test Project SwiftUI
//
//  Created by Admin on 08/06/2021.
//

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        ZStack {
            Color(.clear).edgesIgnoringSafeArea(.all)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                .scaleEffect(2)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
