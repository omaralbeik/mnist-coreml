//
//  View.swift
//  MNIST + CoreML
//
//  Created by Omar Albeik on 3/23/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

public class View: UIView {

	override public init(frame: CGRect) {
		super.init(frame: frame)

		setViews()
		layoutViews()
	}

	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		setViews()
		layoutViews()
	}

	public func setViews() {
		backgroundColor = UIColor(hex: 0x363634)
	}

	public func layoutViews() {}

	public var preferredPadding: CGFloat {
		return 20
	}

}
