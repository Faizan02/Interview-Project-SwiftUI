//
//  ContentView.swift
//  Test Project SwiftUI
//
//  Created by Admin on 08/06/2021.
//

import SwiftUI

struct FlickrView: View {
    
    @StateObject private var viewModel = FlickerViewModel()
    
    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    var body: some View {
        ZStack{
            NavigationView{
                ScrollView{
                    LazyVGrid(columns: columns,spacing: 20){
                        ForEach(viewModel.flickerData, id:\.id){ item in
                            FlickerItem(urlString: viewModel.getFlickrImageURL(serverID: item.server, photoID: item.id, secret: item.secret))
                                .onAppear(){
                                    viewModel.listItemAppears(item: item)
                                }
                        }
                    }
                }.padding()
                .navigationTitle("Flickr")
            }
            .onAppear(){ viewModel.fetchFlickerData() }
            if viewModel.isLoading { LoadingView() }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: alertItem.dismissButton)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FlickrView()
    }
}
