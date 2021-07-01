//
//  CardView.swift
//  Swipeable Cards
//
//  Created by Oleg Frolov on 27.06.2021.
//

import SwiftUI

struct CardView: View
{
    
    @State private var translation: CGSize = .zero
    var day: String = "Day"
    var cardAlpha: Double = 1.0
    
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
                    Image("Love")
                        .frame(width: 96, height: 96)
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
            .animation(.interactiveSpring(response: 0.5, blendDuration: 0.3))
            .offset(x: self.translation.width, y: self.translation.height)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                self.translation = gesture.translation
                    }
                    .onEnded {gesture in
                        self.translation = .zero
                    }
            )
            
        }
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        
        CardView()
    }
}
