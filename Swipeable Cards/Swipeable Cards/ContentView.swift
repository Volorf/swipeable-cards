//
//  ContentView.swift
//  Swipeable Cards
//
//  Created by Oleg Frolov on 27.06.2021.
//

import SwiftUI

struct ContentView: View
{
    var daysToCheck: [String]
    
    private let cardOffset: CGFloat = 24
    private let cardRatio: CGFloat = 1.333
    private let cardOffsetMultiplier: CGFloat = 4
    private let cardAlphaStep: Double = 0.1
    
    private var yCardsOffset: CGFloat
    {
        return -CGFloat(daysToCheck.count) * cardOffset / 2
    }
    
    private func calculateCardWidth(geo: GeometryProxy, offset: CGFloat, cardIndex: Int) -> CGFloat
    {
        return geo.size.width - ((offset * 2) * CGFloat(cardIndex))
    }
    
    private func calculateCardYOffset(offset: CGFloat, cardIndex: Int) -> CGFloat
    {
        return offset * CGFloat(cardIndex)
    }
    
    private func calculateItemInvertIndex(arr: [String], item: String) -> Int
    {
        if arr.isEmpty { return 0 }
        return arr.count - 1 - arr.firstIndex(of: item)!
    }
    
    private func calculateCardAlpha(cardIndex: Int) -> Double
    {
        return 1.0 - Double(cardIndex) * cardAlphaStep
    }
    
    var body: some View
    {
        VStack
        {
            GeometryReader
            {
                geometry in VStack
                {
                    Spacer()
                    ZStack
                    {
                        ForEach (daysToCheck, id: \.self)
                        {
                            day in
                            CardView(day: day, cardAlpha: calculateCardAlpha(cardIndex: calculateItemInvertIndex(arr: daysToCheck, item: day)))
                                .frame(width: calculateCardWidth(geo: geometry, offset: cardOffset, cardIndex: calculateItemInvertIndex(arr: daysToCheck, item: day)), height: geometry.size.width * cardRatio)
                                .offset(x: 0, y: calculateCardYOffset(offset: cardOffset, cardIndex: calculateItemInvertIndex(arr: daysToCheck, item: day)) * cardOffsetMultiplier)
                        }
    
                    }
                    .offset(y: yCardsOffset)
                    Spacer()
                }
            }
        }
        .padding(cardOffset)
        .background(Color("Accent"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView(daysToCheck: days)
    }
}
