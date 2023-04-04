//
//  HomeViewController.swift
//  APOD
//
//  Created by Yuvrajsinh Jadeja on 04/04/23.
//

import UIKit

protocol HomeViewModelable: AnyObject {
    func fetchAPOD()
    func showFullImage(image: UIImage?)
}

final class HomeViewController: UIViewController {
    private lazy var loaderView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView()
        activityView.hidesWhenStopped = true
        activityView.color = .lightGray
        return activityView
    }()
    private lazy var contentView: APODContentView = APODContentView()
    private let viewModel: HomeViewModelable

    init(viewModel: HomeViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.fetchAPOD()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        addSubviews()
        addConstraints()
    }

    private func addSubviews() {
        view.addSubview(loaderView)
    }

    private func addConstraints() {
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func showData(for data: APODData) {
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        contentView.data = data
        contentView.onImageClick = { [weak self] image in
            self?.viewModel.showFullImage(image: image)
        }
    }
}

extension HomeViewController: HomeViewPresenter {
    func startLoading() {
        loaderView.startAnimating()
    }

    func stopLoading() {
        loaderView.stopAnimating()
    }

    func setData(_ data: APODData) {
        showData(for: data)
    }

    func showAlert(title: String?, message: String?) {
        let alertVc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVc.addAction(UIAlertAction(title: "OK", style: .default))

        present(alertVc, animated: true)
    }

    func navigateToFullImage(builder: PhotoDetailBuilder) {
        let detailVC = builder.build()
        let navVC = UINavigationController(rootViewController: detailVC)
        present(navVC, animated: true)
    }
}
