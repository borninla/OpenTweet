//
//  GradientView.swift
//  OpenTweet
//
//  Created by Andrew Lvovsky on 12/5/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

/// A view that displays a smooth gradient based on the colors and start/end points.
final class GradientView: UIView {

  var colors: [CGColor] = [] {
    didSet {
      setNeedsLayout()
    }
  }

  var locations: [NSNumber] = [0, 1] {
    didSet {
      setNeedsLayout()
    }
  }

  var startPoint = CGPoint(x: 0, y: 0) {
    didSet {
      setNeedsLayout()
    }
  }

  var endPoint = CGPoint(x: 1, y: 1) {
    didSet {
      setNeedsLayout()
    }
  }

  override class var layerClass: AnyClass {
    return CAGradientLayer.self
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    guard let layer = layer as? CAGradientLayer else {
      return
    }
    layer.colors = colors
    layer.locations = locations
    layer.startPoint = startPoint
    layer.endPoint = endPoint
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)

    if #available(iOS 13.0, *) {
      if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
        // Colors need to be reinitialized with new CGColor values for dark/light mode
        // toggling to properly change to their respective background colors
        colors = [UIColor.systemBackground.withAlphaComponent(0).cgColor, UIColor.systemBackground.cgColor]
        setNeedsDisplay()
      }
    }
  }

}
