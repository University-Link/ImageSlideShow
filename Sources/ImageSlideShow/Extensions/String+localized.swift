//
//  String+localized.swift
//  Demo
//
//  Created by Seungsoo Lee on 2021/11/25.
//  Copyright © 2021 Dimitri Giani. All rights reserved.
//

import Foundation

extension String {
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
}
