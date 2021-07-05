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
    var day: String = "Day"
    var cardAlpha: Double = 1.0
    
    @State private var translation: CGSize = .zero
    @State private var motionOffset: Double = 0.0
    @State private var motionScale: Double = 0.0
    @State private var lastCardState: DayState = .empty
    
    private func getIconName(state: DayState) -> String
    {
        switch state
        {
            case .love:     return "Love"
            case .poop:     return "Poop"
            default:        return "Empty"
        }
    }
    
    private func setCardState(offset: CGFloat) -> DayState
    {
        if offset <= CardViewConsts.poopTriggerZone   { return .poop }
        if offset >= CardViewConsts.loveTriggerZone   { return .love }
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
                        .frame(width: CardViewConsts.iconSize.width, height: CardViewConsts.iconSize.height)
                        .opacity(self.motionScale)
                        .scaleEffect(CGFloat(self.motionScale))
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
                
                Text(day.uppercased())
                    .font(.system(size: CardViewConsts.labelTextSize))
                    .kerning(CardViewConsts.labelTextKerning)
                    .foregroundColor(Color(AppColor.primaryTextColor.rawValue))
            }
            .frame(width: geometry.size.width, height: geometry.size.width * CardViewConsts.cardRatio)
            .background(Color.white)
            .opacity(cardAlpha)
            .cornerRadius(CardViewConsts.cardCornerRadius)
            .shadow(
                color: Color(AppColor.cardShadow.rawValue),
                radius: CardViewConsts.cardShadowBlur,
                x: 0,
                y: CardViewConsts.cardShadowOffset
            )
            .rotationEffect(
                .degrees(Double(self.translation.width / geometry.size.width * CardViewConsts.cardRotLimit)),
                anchor: .bottom
            )
            .offset(x: self.translation.width, y: self.translation.height)
            .animation(.interactiveSpring(
                        response: CardViewConsts.springResponse,
                        blendDuration: CardViewConsts.springBlendDur)
            )
            .gesture(
                DragGesture()
                    .onChanged
                    {
                        gesture in
                            self.translation = gesture.translation
                            self.motionOffset = Double(gesture.translation.width / geometry.size.width)
                            self.motionScale = Double.remap(
                                from: self.motionOffset,
                                fromMin: CardViewConsts.motionRemapFromMin,
                                fromMax: CardViewConsts.motionRemapFromMax,
                                toMin: CardViewConsts.motionRemapToMin,
                                toMax: CardViewConsts.motionRemapToMax
                            )
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

private struct CardViewConsts
{
    static let cardRotLimit: CGFloat = 20.0
    static let poopTriggerZone: CGFloat = -0.1
    static let loveTriggerZone: CGFloat = 0.1
    
    static let cardRatio: CGFloat = 1.333
    static let cardCornerRadius: CGFloat = 24.0
    static let cardShadowOffset: CGFloat = 16.0
    static let cardShadowBlur: CGFloat = 16.0
    
    static let labelTextSize: CGFloat = 24.0
    static let labelTextKerning: CGFloat = 6.0
    
    static let motionRemapFromMin: Double = 0.0
    static let motionRemapFromMax: Double = 0.25
    static let motionRemapToMin: Double = 0.0
    static let motionRemapToMax: Double = 1.0
    
    static let springResponse: Double = 0.5
    static let springBlendDur: Double = 0.3
    
    static let iconSize: CGSize = CGSize(width: 96.0, height: 96.0)
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
        .background(Color(AppColor.accent.rawValue))
        .edgesIgnoringSafeArea(.all)
    }
}
