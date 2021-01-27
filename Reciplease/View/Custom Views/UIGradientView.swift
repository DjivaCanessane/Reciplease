//
//  UIGradientView.swift
//  Reciplease
//
//  Created by Djiveradjane Canessane on 19/11/2020.
//

import UIKit

class UIGradientView: UIView {

    override class var layerClass: AnyClass { CAGradientLayer.self }

    // MARK: - PRIVATE
    // MARK: IBInspectables
    @IBInspectable private var firstColor: UIColor = UIColor.clear { didSet { updateView() } }
    @IBInspectable private var secondColor: UIColor = UIColor.darkGray { didSet { updateView() } }
    @IBInspectable private var opacity: Float = 1.0 { didSet { updateView() } }

    // MARK: Methods
    //Updates the GradientView's layer with the firstColor, the secondColr and the opacity
    private func updateView() {
        guard let layer = layer as? CAGradientLayer else { return }
        layer.colors = [firstColor.cgColor, secondColor.cgColor]
        alpha = CGFloat(opacity)
    }
}
