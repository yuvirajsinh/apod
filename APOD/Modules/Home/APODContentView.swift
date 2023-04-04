//
//  APODContentView.swift
//  APOD
//
//  Created by Yuvrajsinh Jadeja on 04/04/23.
//

import UIKit

final class APODContentView: UIView {
    private let scrollView: UIScrollView = UIScrollView()
    private let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.isUserInteractionEnabled = true
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18.0, weight: .light)
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        return label
    }()
    private let descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16.0)
        return label
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0)
        return stackView
    }()

    var data: APODData? {
        didSet {
            setData()
        }
    }

    var onImageClick: ((UIImage?) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubviews()
        addConstraints()
        addTapGesture()
    }

    private func addSubviews() {
        self.addSubview(scrollView)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descLabel)
        scrollView.arrangeWithStackView(withViews: [imageView, stackView], spacing: 16.0)
    }

    private func addConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            imageView.heightAnchor.constraint(equalToConstant: 300.0)
        ])
    }

    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(tapGesture)
    }

    private func setData() {
        dateLabel.text = data?.date
        titleLabel.text = data?.title
        descLabel.text = data?.explanation

        guard let url = data?.hdurl else { return }
        imageView.setImage(from: url, placeholder: UIImage(named: "Placeholder"))
    }

    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        onImageClick?(imageView.image)
    }
}
