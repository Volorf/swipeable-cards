//
//  ContentView.swift
//  Swipeable Cards
//
//  Created by Oleg Frolov on 27.06.2021.
//

import SwiftUI

var days: [String] = ["Monday", "Tuesday", "Wednesday"]

struct ContentView: View
{
    let cardOffset: CGFloat = 24
    let cardRatio: CGFloat = 1.333
    let cardOffsetMultiplier: CGFloat = 4
    
    var yCardsOffset: CGFloat
    {
        return -CGFloat(days.count) * cardOffset / 2
    }
    
    private func CalculateCardWidth(geo: GeometryProxy, offset: CGFloat, cardIndex: Int) -> CGFloat
    {
        return geo.size.width - ((offset * 2) * CGFloat(cardIndex))
    }
    
    private func CalculateCardYOffset(offset: CGFloat, cardIndex: Int) -> CGFloat
    {
        return offset * CGFloat(cardIndex)
    }
    
    private func CalculateItemInvertIndex(arr: [String], item: String) -> Int
    {
        if arr.isEmpty
        {
            return 0
        }
        return arr.count - 1 - arr.firstIndex(of: item)!
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
                        ForEach (days, id: \.self)
                        {
                            day in
                            CardView(day: day)
                                .frame(width: CalculateCardWidth(geo: geometry, offset: cardOffset, cardIndex: CalculateItemInvertIndex(arr: days, item: day)), height: geometry.size.width * cardRatio)
                                .offset(x: 0, y: CalculateCardYOffset(offset: cardOffset, cardIndex: CalculateItemInvertIndex(arr: days, item: day)) * cardOffsetMultiplier)
                        }
    
                    }
                    .offset(y: yCardsOffset)
                    Spacer()
                }
            }
        }
        .padding(cardOffset)
        .background(Color(UIColor(named: "Accent") ?? UIColor.red))
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
    }
}
