//
//  ImageCache.swift
//  APOD
//
//  Created by Yuvrajsinh Jadeja on 04/04/23.
//

import Foundation
import UIKit.UIImage

final class ImageCache {
    private let fileManager = FileManager()
    private let queue = DispatchQueue(label: "com.apod.image.cache", attributes: .concurrent)
    private let cacheDirectory: URL

    init(directory: URL? = nil) {
        if let d = directory {
            cacheDirectory = d
        } else {
            let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
            cacheDirectory = url.appendingPathComponent("com.apod.image.cache")
        }

        // Create directory on disk if needed
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
    }

    private func fileURL(forKey key: String) -> URL {
        if #available(iOS 16.0, *) {
            return cacheDirectory.appending(path: key)
        } else {
            return cacheDirectory.appendingPathComponent(key)
        }
    }

    private func read(forKey key: String) -> UIImage? {
        let fileUrl = fileURL(forKey: key)
        do {
            let data = try Data(contentsOf: fileUrl)
            return UIImage(data: data)
        } catch {
            return nil
        }
    }

    private func object(forKey key: String) -> UIImage? {
        var image: UIImage?
        queue.sync {
            image = self.read(forKey: key)
        }
        return image
    }

    private func setObject(_ image: UIImage, forKey key: String) {
        queue.sync(flags: .barrier, execute: {
            self.add(image, forKey: key)
        })
    }

    private func add(_ image: UIImage, forKey key: String) {
        let fileUrl = fileURL(forKey: key)
        do {
            if let data = image.jpegData(compressionQuality: 1.0) {
                try data.write(to: fileUrl, options: .atomic)
            }
        } catch {
            debugPrint(error)
        }
    }

    private func removeObject(forKey key: String) {
        let fileUrl = fileURL(forKey: key)
        try? fileManager.removeItem(at: fileUrl)
    }

    func removeAll() {
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: cacheDirectory,
                                                                       includingPropertiesForKeys: nil,
                                                                       options: .skipsHiddenFiles)
            for fileURL in fileURLs {
                try? FileManager.default.removeItem(at: fileURL)
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }

    // MARK: Subscripting
    public subscript(key: String) -> UIImage? {
        get {
            return object(forKey: key)
        }
        set(newValue) {
            if let value = newValue {
                setObject(value, forKey: key)
            } else {
                removeObject(forKey: key)
            }
        }
    }
}
