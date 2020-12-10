//
//  AlertManager.swift
//  Reciplease
//
//  Created by Djiveradjane Canessane on 17/11/2020.
//

import UIKit

class AlertManager {
    func showErrorAlert(title: String, message: String, viewController: UIViewController) {
        let alertVC =
            UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        viewController.present(alertVC, animated: true, completion: nil)
    }
}
