//
//  UIImageview+URL.swift
//
//  Created by Yuvrajsinh Jadeja on 04/04/23.
//

import UIKit

extension UIImageView {
    static let imageCache: ImageCache = ImageCache()

    func setImage(from url: URL, placeholder: UIImage? = nil) {
        if let img = placeholder {
            image = img
        }

        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .medium)
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.center

        if let cacheImage = Self.imageCache[url.lastPathComponent] {
            image = cacheImage
            return
        }

        // Download image from url
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    Self.imageCache.removeAll()
                    Self.imageCache[url.lastPathComponent] = image
                    self.image = image
                    activityIndicator.removeFromSuperview()
                }
            }
        }).resume()
    }
}
