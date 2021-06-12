//
//  FlickerViewModel.swift
//  Test Project SwiftUI
//
//  Created by Admin on 08/06/2021.
//

import Foundation
class FlickerViewModel: ObservableObject{
    @Published var flickerData:[FlickerPhoto] = []
    @Published var isLoading = false
    @Published var alertItem: AlertItem?
    var flickerResponse:FlickerResponse?
    
    func fetchFlickerData(){
        if !checkIfAlreadyLoadingData(){
            isLoading = true
            NetworkManager.request(endpoint: FlickrEndpoint.getSearchResults(searchText: "iOS", page: getPageNumber())) { [weak self] (result: Result<FlickerResponse,Error>) in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    switch result{
                    case.success(let response):
                            self?.flickerResponse = response
                            let photos = response.photos?.photo ?? []
                            self?.flickerData.append(contentsOf: photos)
                        
                    case .failure(let error):
                        self?.alertItem = AlertItem(title: "Failure", message: error.localizedDescription)
                    }
                }
            }
        }
    }
    func checkIfAlreadyLoadingData()->Bool{
        return isLoading
    }
    func getPageNumber()->Int{
        return (flickerResponse?.photos?.page ?? 0) + 1
    }
    
    func listItemAppears(item: FlickerPhoto){
        guard let lastItem = flickerData.last else {
            return
        }
        if lastItem.id == item.id && !isLoading{
            fetchFlickerData()
        }
    }
    
    /// builds URL String from of Photo from it's propertires
    /// - Parameter serverID: server ID of the photo
    /// - Parameter photoID: ID of the photo
    /// - Parameter secret: Photo secret
    /// - Returns: A String containing url of the photo
    func getFlickrImageURL(serverID:String,photoID:String,secret:String)->String{
        //_{size-suffix}
        return "https://live.staticflickr.com/\(serverID)/\(photoID)_\(secret).jpg"
    }
}
