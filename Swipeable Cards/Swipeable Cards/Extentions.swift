//
//  Extentions.swift
//  Swipeable Cards
//
//  Created by Oleg Frolov on 30.06.2021.
//

import Foundation
import SwiftUI

extension UIColor
{
    static var magenta: UIColor
    {
        return UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
    }
}

extension Color
{
    static func GetColorFromAssets(nameOfColor: String) -> Color
    {
        return Color(UIColor(named: nameOfColor) ?? UIColor.magenta)
    }
}
