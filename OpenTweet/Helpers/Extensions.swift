//
//  Extensions.swift
//  OpenTweet
//
//  Created by Andrew Lvovsky on 12/5/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

extension UIDevice {

  var hasNotch: Bool {
    let bottomSafeAreaInset = UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.safeAreaInsets.bottom ?? 0
    return bottomSafeAreaInset > 0
  }

}
