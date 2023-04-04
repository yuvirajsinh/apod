//
//  PhotoDetailViewController.swift
//  APOD
//
//  Created by Yuvrajsinh Jadeja on 04/04/23.
//

import UIKit

protocol PhotoDetailViewModelable {
    func loadImage()
}

final class PhotoDetailViewController: UIViewController {
    private let astroImageView: PanZoomImageView = PanZoomImageView()
    
    private let viewModel: PhotoDetailViewModelable

    // MARK: - Initializer and Overrides
    required init(viewModel: PhotoDetailViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        viewModel.loadImage()
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .black

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClicked))

        addSubviews()
        addConstraints()
    }

    private func addSubviews() {
        view.addSubview(astroImageView)
    }

    private func addConstraints() {
        astroImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            astroImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            astroImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            astroImageView.topAnchor.constraint(equalTo: view.topAnchor),
            astroImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func doneClicked() {
        dismiss(animated: true)
    }
}

// MARK: - PhotoDetailPresenter
extension PhotoDetailViewController: PhotoDetailPresenter {
    func setImage(_ image: UIImage) {
        astroImageView.image = image
    }
}
