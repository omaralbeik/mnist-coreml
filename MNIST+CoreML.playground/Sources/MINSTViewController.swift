//
//  MINSTViewController.swift
//  MNIST + CoreML
//
//  Created by Omar Albeik on 3/23/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

public class MINSTViewController: UIViewController {

	private var lastPoint: CGPoint = .zero
	private var swiped = false
	private var latestResult: MNISTOutput?

	private var brushWidth: CGFloat {
		return min(view.frame.size.width, view.frame.size.height) / 38.0
	}

	override public func loadView() {
		view = MNISTView(frame: .init(x: 0, y: 0, width: 600, height: 800))
	}
	
	public var mnistView: MNISTView {
		return view as! MNISTView
	}

	public override func viewDidLoad() {
		super.viewDidLoad()

		mnistView.clearButton.addTarget(self, action: #selector(didTapClearButton), for: .touchUpInside)
		mnistView.predictButton.addTarget(self, action: #selector(didTapPredictButton), for: .touchUpInside)
		mnistView.showAllButton.addTarget(self, action: #selector(didTapShowAllButton), for: .touchUpInside)
	}

	public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		swiped = false

		guard let touch = touches.first else { return }
		lastPoint = touch.location(in: mnistView.canvasImageView)

		if touch.isInView(mnistView.canvasImageView) {
			mnistView.placeholderView.setHidden(true)
		}
	}

	public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		swiped = true

		guard let touch = touches.first else { return }
		let currentPoint = touch.location(in: mnistView.canvasImageView)
		drawLine(from: lastPoint, to: currentPoint)
		lastPoint = currentPoint

		if touch.isInView(mnistView.canvasImageView) {
			mnistView.placeholderView.setHidden(true)
		}
	}

	public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard swiped else { return }
		drawLine(from: lastPoint, to: lastPoint)
	}

}

// MARK: - Actions
private extension MINSTViewController {

	@objc func didTapClearButton() {
		mnistView.canvasImageView.image = nil
		mnistView.resultLabel.text = ""
		mnistView.accuracyLabel.text = ""
		mnistView.placeholderView.setHidden(false)

		UIView.animate(withDuration: 0.25) {
			self.mnistView.layoutIfNeeded()
			self.mnistView.showAllButton.alpha = 0
		}
	}

	@objc func didTapPredictButton() {
		let size = CGSize(width: 28, height: 28)
		let image = mnistView.canvasImageView.image?.resize(to: size)
		guard let buffer = image?.resize(to: size)?.pixelBuffer() else { return }
		guard let result = try? MNIST().prediction(image: buffer) else { return }
		latestResult = result

		let digit = result.classLabel
		let accuracy = result.output[digit]

		updateLabels(digit: digit, accuracy: accuracy)
	}

	@objc func didTapShowAllButton() {
		guard let result = latestResult else { return }

		var message = ""

		for item in result.sortedResult {
			message += "\(item.key): \(item.value)\n"
		}

		let alert = UIAlertController(title: "All Labels", message: message, preferredStyle: .alert)
		let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
		alert.addAction(dismissAction)
		
		present(alert, animated: true, completion: nil)
	}
	
}

// MARK: - Helpers
private extension MINSTViewController {

	func updateLabels(digit: String, accuracy: Double?) {
		mnistView.resultLabel.text = "Prediction: \(digit)"
		
		if let anAccuracy = accuracy {
			mnistView.accuracyLabel.text = "Accuracy: \(anAccuracy)"
		}

		UIView.animate(withDuration: 0.25) {
			self.mnistView.layoutIfNeeded()
			self.mnistView.showAllButton.alpha = 1
		}
	}

	func drawLine(from point1: CGPoint, to point2: CGPoint) {
		UIGraphicsBeginImageContextWithOptions(mnistView.canvasImageView.frame.size, true, 0)
		let context = UIGraphicsGetCurrentContext()
		mnistView.canvasImageView.image?.draw(in: .init(origin: .zero, size: mnistView.canvasImageView.frame.size))

		context?.move(to: point1)
		context?.addLine(to: point2)
		context?.setLineCap(.round)
		context?.setLineWidth(brushWidth)
		context?.setStrokeColor(red: 1, green: 1, blue: 1, alpha: 1)
		context?.setBlendMode(.normal)
		context?.strokePath()

		mnistView.canvasImageView.image = UIGraphicsGetImageFromCurrentImageContext()
		mnistView.canvasImageView.alpha = 1
		UIGraphicsEndImageContext()
	}
	
}
