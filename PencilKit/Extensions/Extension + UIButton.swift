//
//  Extension + UIButton.swift
//  PencilKit
//
//  Created by Сергей Горбачёв on 03.08.2021.
//

import UIKit

extension UIButton {
    convenience init(color: UIColor) {
        self.init(type: .system)
        self.backgroundColor = color
    }
}


