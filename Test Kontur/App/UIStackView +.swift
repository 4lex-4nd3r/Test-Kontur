//
//  UIStackView +.swift
//  Test Kontur
//
//  Created by Александр on 28.08.2022.
//

import UIKit

extension UIStackView {
   convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {

      self.init(arrangedSubviews: arrangedSubviews)
      self.axis = axis
      self.spacing = spacing
      self.distribution = .equalSpacing
      self.translatesAutoresizingMaskIntoConstraints = false
   }
}
