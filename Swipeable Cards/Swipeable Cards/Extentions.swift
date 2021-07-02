//
//  Extentions.swift
//  Swipeable Cards
//
//  Created by Oleg Frolov on 30.06.2021.
//
import SwiftUI

extension UIColor
{
    static var magenta: UIColor = UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
}

extension Color
{
    static func GetColorFromAssets(colorName: AppColor) -> Color
    {
        return Color(UIColor(named: colorName.rawValue) ?? UIColor.magenta)
    }
}


extension Double
{
    static func Remap (from: Double, fromMin: Double, fromMax: Double, toMin: Double, toMax: Double) -> Double
    {
        let fromAbs: Double  =  from - fromMin
        let fromMaxAbs: Double = fromMax - fromMin
        let normal: Double = fromAbs / fromMaxAbs
        let toMaxAbs = toMax - toMin
        let toAbs: Double = toMaxAbs * normal
        var to: Double = toAbs + toMin
        
        to = abs(to)
        
        if to < toMin { return toMin }
        if to > toMax { return toMax }
       
        return to
    }
}


