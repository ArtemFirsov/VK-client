//
//  WebImageView.swift
//  VK-client
//
//  Created by Artem Firsov on 11/9/21.
//

import UIKit

class WebImageView: UIImageView {
    
    func configure(imageUrl: String?) {
        guard let imageUrl = imageUrl, let url = URL(string: imageUrl) else { return }
        
//        self.sd_setImage(with: url, placeholderImage: UIImage())
        
        if let cached = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cached.data)
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }

            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self.image = UIImage(data: data)
                    self.imageHandler(data: data, response: response)

                }
            }
        }
        dataTask.resume()
    }
    
    private func imageHandler(data: Data, response: URLResponse) {
        guard let responseUrl = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseUrl))
    }
}
