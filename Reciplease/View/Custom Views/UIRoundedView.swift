//
//  UIRoundedView.swift
//  Reciplease
//
//  Created by Djiveradjane Canessane on 19/11/2020.
//

import UIKit

class UIRoundedView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        addCornerRadius()
    }

    private func addCornerRadius() {
        layer.cornerRadius = 4
    }
}
