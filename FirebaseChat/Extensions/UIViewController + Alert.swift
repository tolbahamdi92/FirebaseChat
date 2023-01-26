//
//  UIViewController + Alert.swift
//  MediaFinder
//
//  Created by Tolba on 14/05/1444 AH.
//

import UIKit

extension UIViewController {
     func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: ButtonsTitle.ok, style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
