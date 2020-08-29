//
//  Optionals.swift
//  IOSCodeChallenge
//
//  Created by neelam panwar on 29/08/20.
//  Copyright © 2020 Neelam Panwar. All rights reserved.
//

import UIKit

protocol OptionalType { init() }

extension String: OptionalType {}
extension Int: OptionalType {}
extension Int64: OptionalType {}
extension Float: OptionalType {}
extension Double: OptionalType {}
extension CGFloat: OptionalType {}
extension Bool: OptionalType {}
extension UIImage : OptionalType {}
extension IndexPath : OptionalType {}
extension NSNumber : OptionalType {}
extension Date : OptionalType {}
extension UIViewController : OptionalType {}


prefix operator /
prefix func /<T: OptionalType>( rhs: T?) -> T {
    
    guard let validRhs = rhs else { return T() }
    return validRhs
}
