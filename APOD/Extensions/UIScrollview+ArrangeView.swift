//
//  UIScrollview+ArrangeView.swift
//  APOD
//
//  Created by Yuvrajsinh Jadeja on 04/04/23.
//

import UIKit

public extension UIScrollView {
    /// Arranges all given views in `UIStackView` and adds it as container view for the sender
    /// - Parameters:
    ///   - views: List of UIView to be added in scroll view
    ///   - spacing: Spacing between each view
    ///   - insets: `UIEdgeInsets` to define padding in scroll view
    func arrangeWithStackView(withViews views: [UIView], axis: NSLayoutConstraint.Axis = .vertical, spacing: CGFloat = 0.0, insets: UIEdgeInsets? = nil, customSpacing: [CGFloat]? = nil) {
        // Create StackView
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.spacing = spacing

        views.forEach({ stackView.addArrangedSubview($0) })

        // Give custom spacing if required
        if let cSpacing = customSpacing, cSpacing.count == views.count {
            for (i, spacing) in cSpacing.enumerated() {
                stackView.setCustomSpacing(spacing, after: views[i])
            }
        }

        // Create ScrollView
        self.addSubview(stackView)

        // Constraint
        addConstraintForContentView(stackView, axis: axis, insets: insets)
    }

    /// Adds autolayout constraints for content view which holds all other views
    /// - Parameters:
    ///   - contentView: Content view which will hold all other views
    ///   - axis: Axis of view arrangement
    ///   - insets: Insets for `contentView` from `UIScrollView`
    private func addConstraintForContentView(_ contentView: UIView, axis: NSLayoutConstraint.Axis, insets: UIEdgeInsets?) {
        if axis == .vertical {
            NSLayoutConstraint.activate([
                contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: insets?.left ?? 0.0),
                contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(insets?.right ?? 0.0)),
                contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: insets?.top ?? 0.0),
                contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0.0)
            ])
            let bottom = contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -(insets?.bottom ?? 0.0))
            bottom.priority = .defaultLow
            bottom.isActive = true
        } else {
            NSLayoutConstraint.activate([
                contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: insets?.left ?? 0.0),
                contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: insets?.top ?? 0.0),
                contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -(insets?.bottom ?? 0.0)),
                contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0)
            ])
            let trailing = contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(insets?.right ?? 0.0))
            trailing.priority = .defaultLow
            trailing.isActive = true
        }
    }
}
