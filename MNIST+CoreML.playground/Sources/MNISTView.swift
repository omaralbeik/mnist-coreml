//
//  MNISTView.swift
//  MNIST + CoreML
//
//  Created by Omar Albeik on 3/23/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit
import CoreML

public class MNISTView: View {

	private var lastPoint: CGPoint = .zero

	private var brushWidth: CGFloat {
		return min(frame.size.width, frame.size.height) / 38.0
	}

	var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "CoreML"
		label.textColor = UIColor(hex: 0xFEEA0C)
		label.font = .systemFont(ofSize: 20, weight: .bold)
		label.textAlignment = .center
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.7
		return label
	}()

	var subtitleImageView: UIImageView = {
		let imageView = UIImageView(image: UIImage(named: "img_mnist"))
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()

	var backgroundImageView: UIImageView = {
		let imageView = UIImageView(image: UIImage(named: "img_draw_rect"))
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	var canvasImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.backgroundColor = .black
		return imageView
	}()

	var placeholderView: CanvasPlaceholderView = {
		let view = CanvasPlaceholderView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	var clearButton: Button = {
		let button = Button(image: UIImage(named: "img_clear_button"), title: "Clear", color: UIColor(hex: 0xEF416A)!)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()

	var predictButton: Button = {
		let button = Button(image: UIImage(named: "img_predict_button"), title: "Predict", color: UIColor(hex: 0x207FA6)!)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()

	var buttonsStackView: UIStackView = {
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.axis = .horizontal
		view.distribution = .fill
		view.alignment = .fill
		view.spacing = 16
		return view
	}()

	var resultLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .white
		label.font = .systemFont(ofSize: 35, weight: .thin)
		label.textAlignment = .center
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.6
		return label
	}()

	var accuracyLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .white
		label.font = .systemFont(ofSize: 15, weight: .semibold)
		label.textAlignment = .center
		return label
	}()

	override public func setViews() {
		super.setViews()

		addSubview(titleLabel)
		titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)

		addSubview(subtitleImageView)
		subtitleImageView.setContentCompressionResistancePriority(.required, for: .vertical)

		addSubview(backgroundImageView)
		addSubview(canvasImageView)
		addSubview(placeholderView)

		buttonsStackView.addArrangedSubview(clearButton)
		buttonsStackView.addArrangedSubview(predictButton)

		clearButton.addTarget(self, action: #selector(didTapClearButton), for: .touchUpInside)
		predictButton.addTarget(self, action: #selector(didTapPredictButton), for: .touchUpInside)

		addSubview(buttonsStackView)

		addSubview(resultLabel)
		resultLabel.setContentCompressionResistancePriority(.required, for: .vertical)

		addSubview(accuracyLabel)
		accuracyLabel.setContentCompressionResistancePriority(.required, for: .vertical)
	}

	override public func layoutViews() {
		titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: preferredPadding).isActive = true
		titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true

		subtitleImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: preferredPadding * 0.5).isActive = true
		subtitleImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
		subtitleImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

		backgroundImageView.topAnchor.constraint(equalTo: subtitleImageView.bottomAnchor, constant: preferredPadding).isActive = true
		backgroundImageView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.75).isActive = true
		backgroundImageView.heightAnchor.constraint(equalTo: backgroundImageView.widthAnchor).isActive = true
		backgroundImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

		canvasImageView.widthAnchor.constraint(equalTo: backgroundImageView.widthAnchor, multiplier: 0.82).isActive = true
		canvasImageView.heightAnchor.constraint(equalTo: backgroundImageView.heightAnchor, multiplier: 0.82).isActive = true
		canvasImageView.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor).isActive = true
		canvasImageView.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor).isActive = true

		placeholderView.widthAnchor.constraint(equalTo: canvasImageView.widthAnchor, multiplier: 0.65).isActive = true
		placeholderView.heightAnchor.constraint(equalTo: canvasImageView.heightAnchor, multiplier: 0.65).isActive = true
		placeholderView.centerXAnchor.constraint(equalTo: canvasImageView.centerXAnchor).isActive = true
		placeholderView.centerYAnchor.constraint(equalTo: canvasImageView.centerYAnchor).isActive = true

		buttonsStackView.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: preferredPadding).isActive = true
		buttonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		buttonsStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true

		resultLabel.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: preferredPadding).isActive = true
		resultLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		resultLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

		accuracyLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor).isActive = true
		accuracyLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		accuracyLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		accuracyLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -preferredPadding).isActive = true
	}

	override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else { return }

		if touch.isInView(canvasImageView) {
			placeholderView.setHidden(true)
		}

		lastPoint = touch.location(in: self.canvasImageView)
	}

	override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else { return }
		let currentPoint = touch.location(in: canvasImageView)
		drawLine(from: lastPoint, to: currentPoint)

		if touch.isInView(canvasImageView) {
			placeholderView.setHidden(true)
		}

		lastPoint = currentPoint
	}

}

// MARK: - Actions
private extension MNISTView {

	@objc func didTapClearButton() {
		canvasImageView.image = nil
		self.resultLabel.text = ""
		self.accuracyLabel.text = ""
		placeholderView.setHidden(false)

		UIView.animate(withDuration: 0.25) {
			self.layoutIfNeeded()
		}
	}

	@objc func didTapPredictButton() {
		let size = CGSize(width: 28, height: 28)
		let image = canvasImageView.image?.resize(to: size)
		guard let buffer = image?.resize(to: size)?.pixelBuffer() else { return }
		guard let result = try? MNIST().prediction(image: buffer) else { return }

		let digit = result.classLabel
		let accuracy = result.output[digit]

		self.updateLabels(digit: digit, accuracy: accuracy)
	}

}

// MARK: - Helpers
private extension MNISTView {

	func updateLabels(digit: String, accuracy: Double?) {
		resultLabel.text = "Prediction: \(digit)"

		if let anAccuracy = accuracy {
			accuracyLabel.text = "Accuracy: \(anAccuracy)"
		}

		UIView.animate(withDuration: 0.25) {
			self.layoutIfNeeded()
		}
	}

	func drawLine(from point1: CGPoint, to point2: CGPoint) {
		UIGraphicsBeginImageContextWithOptions(canvasImageView.frame.size, true, 1)
		let context = UIGraphicsGetCurrentContext()
		canvasImageView.image?.draw(in: .init(origin: .zero, size: canvasImageView.frame.size))

		context?.move(to: point1)
		context?.addLine(to: point2)
		context?.setLineCap(.round)
		context?.setLineWidth(brushWidth)
		context?.setStrokeColor(red: 1, green: 1, blue: 1, alpha: 1)
		context?.setBlendMode(.normal)
		context?.strokePath()

		canvasImageView.image = UIGraphicsGetImageFromCurrentImageContext()
		canvasImageView.alpha = 1
		UIGraphicsEndImageContext()
	}

}

