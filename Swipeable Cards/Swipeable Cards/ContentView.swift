//
//  ContentView.swift
//  Swipeable Cards
//
//  Created by Oleg Frolov on 27.06.2021.
//

import SwiftUI

var days: [String] = ["Monday", "Tuesday", "Wednesday"]

struct ContentView: View {
    
    let yOffset: CGFloat = 24
    let cardRatio: CGFloat = 1.333
    var yCardsOffset: CGFloat {
        return -CGFloat(days.count) * yOffset / 2
    }
    
    var body: some View {
        VStack{
//            Spacer()
        GeometryReader { geometry in VStack {
        Spacer()
        ZStack {
            ForEach (days, id: \.self)
            {
                day in
                CardView(day: day).frame(width: geometry.size.width, height: geometry.size.width * cardRatio).offset(x:0, y: CGFloat(CGFloat(days.count - 1 - (days.firstIndex(of: day) ?? 0)) * self.yOffset))
            }
//            CardView().frame(height: 500)
        
        }.offset(y: yCardsOffset)
            Spacer()
        }
    }
    }
//        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
