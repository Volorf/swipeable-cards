//
//  CardView.swift
//  Swipeable Cards
//
//  Created by Oleg Frolov on 27.06.2021.
//
// My original concept https://dribbble.com/shots/2313705-Ambivalence-ll-Monday

import SwiftUI

enum DayState
{
    case love
    case poop
    case empty
}

struct CardView: View
{
    
    @State private var translation: CGSize = .zero
    @State private var motionOffset: Double = 0.0
    @State private var motionScale: Double = 0.0
    @State private var lastCardState: DayState = .empty
    
    var day: String = "Day"
    var cardAlpha: Double = 1.0
    let cardRotLimit: CGFloat = 20.0
    
    private func getIconName(state: DayState) -> String {
        switch state {
        case .love:     return "Love"
        case .poop:     return "Poop"
        default:        return "Empty"
        }
    }
    
    private func setCardState(offset: CGFloat) -> DayState
    {
        if offset <= -0.1   { return .poop }
        if offset >= 0.1    { return .love }
        return .empty
    }
    
    var body: some View
    {
        GeometryReader
        {
            geometry in
            ZStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            {
                VStack
                {
                    Spacer()
                    Image(getIconName(state: self.lastCardState))
                        .frame(width: 96, height: 96)
                        .opacity(self.motionScale)
                        .scaleEffect(CGFloat(self.motionScale) * 1)
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
                
                Text(day.uppercased())
                    .font(.system(size: 24.0))
                    .kerning(6.0)
                    .foregroundColor(Color.GetColorFromAssets(colorName: .primaryTextColor))
            }
            .frame(width: geometry.size.width, height: geometry.size.width * 1.33)
            .background(Color.white)
            .opacity(cardAlpha)
            .cornerRadius(24)
            .shadow(color: Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.05), radius: 16, x: 0, y: 16)
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width * cardRotLimit)), anchor: .bottom)
            .offset(x: self.translation.width, y: self.translation.height)
            .animation(.interactiveSpring(response: 0.5, blendDuration: 0.3))
            .gesture(
                DragGesture()
                    .onChanged
                    {
                        gesture in
                            self.translation = gesture.translation
                            self.motionOffset = Double(gesture.translation.width / geometry.size.width)
                            self.motionScale = Double.Remap(from: self.motionOffset, fromMin: 0.0, fromMax: 0.25, toMin: 0.0, toMax: 1.0)
                            print(self.motionScale)
                            self.lastCardState = setCardState(offset: gesture.translation.width)
                    }
                    .onEnded
                    {
                        gesture in
                            self.translation = .zero
                            self.motionScale = 0.0
                    }
            )
            
        }
        
    }
}

struct CardView_Previews: PreviewProvider
{
    static var previews: some View
    {
        VStack
        {
            CardView()
                .padding()
                .offset(y: 192)
        }
        .background(Color.GetColorFromAssets(colorName: .accent))
        .edgesIgnoringSafeArea(.all)
    }
}
