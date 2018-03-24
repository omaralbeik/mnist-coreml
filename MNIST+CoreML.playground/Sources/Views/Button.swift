//
//  Button.swift
//  MNIST + CoreML
//
//  Created by Omar Albeik on 3/23/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

class Button: UIButton {
	
	override var isHighlighted: Bool {
		didSet {
			UIView.animate(withDuration: 0.25) {
				self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity
			}
		}
	}
	
	convenience init(image: UIImage?, title: String, color: UIColor) {
		self.init(type: .system)
		
		setImage(image, for: .normal)
		setTitle(title.uppercased(), for: .normal)
		
		titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
		imageView?.contentMode  = .scaleAspectFit
		
		backgroundColor = color.withAlphaComponent(0.8)
		tintColor = .white
		
		layer.cornerRadius = 8
		layer.borderWidth = 2
		layer.borderColor = color.cgColor
		
		contentEdgeInsets = .init(top: 4, left: 0, bottom: 4, right: 20)
		imageEdgeInsets = .init(top: 4, left: 0, bottom: 4, right: 0)
		titleEdgeInsets  = .init(top: 4, left: 0, bottom: 4, right: 0)
	}

}


