//
//  String.swift
//  GlobalLocatorLib
//
//  Created by Amr Aboelela on 6/10/21.
//  Copyright © 2021 Amr Aboelela. All rights reserved.
//
//  See LICENCE for details.
//

import Foundation

extension Double {

    var friendlyDirection: String {
        if self > 360 - 22.5 || self < 22.5 {
            return "N"
        } else if self < 90 - 22.5 {
            return "NE"
        } else if self < 90 + 22.5 {
            return "E"
        } else if self < 180 - 22.5 {
            return "SE"
        } else if self < 180 + 22.5 {
            return "S"
        } else if self < 270 - 22.5 {
            return "SW"
        } else if self < 270 + 22.5 {
            return "W"
        }
        return "NW"
    }
}
