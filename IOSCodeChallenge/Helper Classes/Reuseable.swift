//
//  Reuseable.swift
//  IOSCodeChallenge
//
//  Created by neelam panwar on 29/08/20.
//  Copyright © 2020 Neelam Panwar. All rights reserved.
//

import UIKit

protocol Reusable: NSObject {
  static var reuseableIdentifier: String { get }
}

extension Reusable {
  static var reuseableIdentifier: String {
    return String(describing: self)
  }
}

extension UITableViewCell: Reusable {}
