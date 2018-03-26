//
//  CanvasPlaceholderView.swift
//  MNIST + CoreML
//
//  Created by Omar Albeik on 3/23/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

class CanvasPlaceholderView: View {

    var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "img_canvas_placeholder"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Touch and pan to draw a single digit"
        label.textColor = UIColor(hex: 0xAAAAAA)
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        return label
    }()

    override func setViews() {
        addSubview(imageView)
        addSubview(titleLabel)
    }

    override func layoutViews() {
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(lessThanOrEqualTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: 0.4).isActive = true

        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: preferredPadding * 0.75).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    func setHidden(_ hidden: Bool, animated: Bool = true) {
        UIView.animate(withDuration: animated ? 0.25 : 0) {
            self.transform = hidden ? CGAffineTransform(scaleX: 0.75, y: 0.75) : .identity
            self.alpha = hidden ? 0 : 1
        }
    }

}
