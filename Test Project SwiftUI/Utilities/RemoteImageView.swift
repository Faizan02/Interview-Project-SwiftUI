//
//  RemoteImageView.swift
//  Test Project SwiftUI
//
//  Created by Admin on 08/06/2021.
//

import SwiftUI

final class RemoteImageLoader: ObservableObject {
    
    
    private let cache = NSCache<NSString, UIImage>()
    @Published var image: Image? = nil
    //NetworkManager.shared.downloadImage(from: url)
    func load(fromURL url: String) {
        downloadImage(from: url) { uiImage in
            guard let uiImage = uiImage else { return }
            DispatchQueue.main.async {
                self.image = Image(uiImage: uiImage)
            }
        }
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}


struct RemoteImageLoad: View {
    
    var image: Image?
    
    var body: some View {
        image?.resizable() ?? Image("loadingIndicator").resizable()
    }
}


struct RemoteImage: View {
    
    @StateObject private var imageLoader = RemoteImageLoader()
    var urlString: String
    
    var body: some View {
        RemoteImageLoad(image: imageLoader.image)
            .onAppear { imageLoader.load(fromURL: urlString) }
    }
}
