//
//  PhotoDetailViewModel.swift
//  APOD
//
//  Created by Yuvrajsinh Jadeja on 04/04/23.
//

import UIKit

protocol PhotoDetailPresenter: AnyObject {
    func setImage(_ image: UIImage)
}

final class PhotoDetailViewModel: PhotoDetailViewModelable {
    weak var presenter: PhotoDetailPresenter?
    
    private let dependency: PhotoDetailDependency
    
    init(dependency: PhotoDetailDependency) {
        self.dependency = dependency
    }

    func loadImage() {
        presenter?.setImage(dependency.image)
    }
}
