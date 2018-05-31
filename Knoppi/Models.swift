//
//  Models.swift
//  Knoppi
//
//  Created by Chase on 31/05/2018.
//  Copyright © 2018 s0w4. All rights reserved.
//

import Foundation
import UIKit

struct Orientation {
    // indicate current device is in the LandScape orientation
    static var isLandscape: Bool {
        get {
            return UIDevice.current.orientation.isValidInterfaceOrientation
                ? UIDevice.current.orientation.isLandscape
                : UIApplication.shared.statusBarOrientation.isLandscape
        }
    }
    // indicate current device is in the Portrait orientation
    static var isPortrait: Bool {
        get {
            return UIDevice.current.orientation.isValidInterfaceOrientation
                ? UIDevice.current.orientation.isPortrait
                : UIApplication.shared.statusBarOrientation.isPortrait
        }
    }
}
